#!/usr/bin/env python3

import argparse
import glob
import os
import re
import shutil
import sys
import urllib.request

from tempfile import NamedTemporaryFile

"""
Utilities module for GitHub actions and general use.
"""

EXIT_FAILURE = -1

NO_VERSION = 'NO_VERSION'

TYPE_MANIFEST_ESO = 'TYPE_MANIFEST_ESO'
EXT_MANIFEST_ESO = '.txt'
EXT_MANIFEST_ADDITIONAL = '.manifest'
TYPE_MANIFEST_ADDITIONAL = 'TYPE_MANIFEST_ADDITIONAL'

MANIFEST_HEADER = {
  'Title': '', # Title ingame
  'Version': NO_VERSION,
  'type': TYPE_MANIFEST_ADDITIONAL,
  'files': None
}

RE_MANIFEST_FIELD = re.compile(r"^##\s*(?P<KEY>\w+):\s*(?P<VALUE>.+)$")
"""match manifest properties"""

def get_manifest_data(manifest_file: str) -> dict:
  """Extracts data from manifest file.
  All listed files are considered to be located relative to the manifest file path.

  Args:
      manifest_file (str): Path to manifest file

  Returns:
      str: Manifest as a dict.
  """

  manifest = dict.copy(MANIFEST_HEADER)
  manifest['files'] = []
  manifest_file = os.path.normpath(manifest_file)
  manifest_dir = os.path.dirname(manifest_file)
  try:
    with open(manifest_file, 'r') as file:
      for line in file:
        line = line.strip()
        if line.startswith((';', '# ')): continue # skip comments

        match = re.fullmatch(RE_MANIFEST_FIELD, line)
        if match:
          key,value = match.group('KEY', 'VALUE')
          manifest[key] = value # duplicates shall be overwritten
        else:
          if line and not line.startswith(("#", ";")):
            line = line.replace('$(language)', '*') # mask for all files in lang dir
            line = line.replace('\\', '/')
            line = os.path.normpath(line)
            if '*' in line: # resolve mask to get filenames
              manifest['files'].extend(glob.glob(os.path.join(manifest_dir, line)))
            else:
              manifest['files'].append(os.path.join(manifest_dir, line))

    if manifest_file.endswith('.txt'):
      manifest['type'] = TYPE_MANIFEST_ESO

  except Exception as ex:
    print(f"Failed to get data from {manifest_file}: {ex}")
  return manifest

def extract_header_from_file(path: str, delim: str="[//]:"):
  with open(path, 'r') as file:
    data = file.read()
  return extract_header(data, delim)

def extract_header(note: str, delim: str="[//]:") -> str:
  """Extracts text that comes before a specified delimiter's first occurence, usually a header.

  Args:
      note (str): Text we might want to separate from the rest
      delim (str, optional): Delimiter the text will be split at. Defaults to "[//]:".

  Returns:
      str: Extracted header or empty string if no delimiter or whitepace text
  """
  if not note: return ''
  note_parts = note.split(delim, 1)
  if len(note_parts) == 1: return ''
  return note_parts[0].strip()


def prepend_str_to_file(text:str, file: str):
  text = str.strip(text)
  if not text or not file: return

  dir_name = os.path.dirname(file)
  temp = NamedTemporaryFile(dir=dir_name) # what is my purpose?
  renamed_file = temp.name # > you pass the name
  temp.close() # oh my god

  os.rename(file, renamed_file)
  with open(file, 'w') as target:
    target.write(text + '\n\n')
    with open(renamed_file, 'r') as old:
      shutil.copyfileobj(old, target)
  os.remove(renamed_file)


RE_CHANGELOG_VERSION = re.compile(r"(?=\n\d+[\w\.\(\)\-]*)")
"""just for splitting changelog"""

def get_latest_log_entries(cl_file: str, entries: int=20) -> list[str]:
  """Gets latest x entries from full changelog file

  Args:
      cl_file (str): Path to changelog file
      entries (int, optional): Max number of entries to show. Defaults to 20.

  Returns:
      list[str]: Truncated changelog
  """
  with open(cl_file, 'r') as f:
    data = f.read()
  return RE_CHANGELOG_VERSION.split(data, entries)[0:entries]

def compare_versions(a: str, b: str) -> int:
  """Compares 2 version numbers

  Args:
      a (str): version str like 1.23
      b (str): version str like 1.23

  Returns:
      int: a<b: -1, a==b: 0, a>b: 1
  """

  if a is None and b is None: return 0
  if a is None: return -1
  if b is None: return 1

  try:
    a_parts = a.split(".")
    b_parts = b.split(".")
  except ValueError:
    raise ValueError("Invalid version format. Must be using numbers and in the format like x.y or x.y.z")

  # add 0 padding to make verions of different length comparable
  max_length = max(len(a_parts), len(b_parts))
  a_parts += ['0'] * (max_length - len(a_parts))
  b_parts += ['0'] * (max_length - len(b_parts))

  if a_parts < b_parts:
      return -1
  elif a_parts > b_parts:
      return 1
  else:
      return 0

def file_to_binary_string(archive_uri: str):
  """Returns file content as binary string

  Args:
      archive_uri (str): file path or URL

  Returns:
      _type_: binary string
  """

  msg = f"{archive_uri}: "
  # Try to open it as a URL, because that is our default use case
  try:
    with urllib.request.urlopen(archive_uri) as response:
      return response.read()
  except Exception:
    msg += 'Cannot be reached as URL. '

  # Not a URL or other problem, check locally
  if not os.path.isfile(archive_uri):
    msg += 'Cannot find file locally either. '
    raise ValueError(msg)

  try:
    with open(archive_uri, 'rb') as file:
      return file.read()
  except Exception:
    msg += 'Could not open file.'

  # If we reached this point, then the file content could not be retrieved
  raise ValueError(msg)


RE_GHLIST_TAG = re.compile(r"\s+(\d+[\.\d]+)\s+")
"""version tags like 1.23"""

def get_highest_version_from_gh_list(gh_list :str) -> str:
  """Get the highest release version from a list generated by gh cli

  Input example:\n
  Version 1.23    Pre-release     1.23    2023-05-16T15:12:00Z\n
  Version 4.6     Pre-release     4.6     2023-05-15T00:36:49Z\n
  Version 4.5     Latest  4.5     2023-05-15T00:59:34Z\n

  Args:
      gh_list (str): see input example

  Returns:
      str: highest version or 0
  """

  highest = "0"
  for entry in gh_list.split('\n'):
    current = RE_GHLIST_TAG.search(entry)
    if not current: continue
    current = current.groups()[-1]
    cmp = compare_versions(current, highest)
    if cmp <= 0: continue
    highest = current

  return highest


def crash_and_burn(msg: str=''):
  """Performs some crashing and/or burning"""
  print(f"🔥 ABORT ABORT ABORT: {msg} 🔥")
  exit(EXIT_FAILURE)

# Make some methods available for shell use
if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  subparsers = parser.add_subparsers(dest='command')

  # Compare Versions
  prs_compare = subparsers.add_parser('compare', help='Compare two versions like 1.23.4<=>1.23.39 --> 1')
  prs_compare.add_argument('a', type=str, help='First Version')
  prs_compare.add_argument('b', type=str, help='Second version')

  # Get Binary String from file (good shell alternative because it also handles URLs)
  prs_file2binary = subparsers.add_parser('file2binary', help='Return file content as a binary string like b\'ABC\\0x00\'')
  prs_file2binary.add_argument('filepath', help='local file or url')

  # Get String before delimiter
  prs_extract_header = subparsers.add_parser('extract_header', help='Get the first part of a text split at given delimiter')
  prs_extract_header.add_argument('text', help='Text containing the header')
  prs_extract_header.add_argument("--delimiter", default='[//]:', help='Delimiter the string splits at. Default=[//]')

  prs_get_latest_ver = subparsers.add_parser('getlatest', help='Get the highest version number from gh release list')
  prs_get_latest_ver.add_argument('list', nargs='?', default=sys.stdin, help='The output of gh release list')

  args = parser.parse_args()
  if args.command == 'compare':
    print(compare_versions(args.a, args.b))
  elif args.command == 'file2binary':
    print(file_to_binary_string(args.filepath))
  elif args.command == 'extract_header':
    print(extract_header(args.text, args.delimiter))
  elif args.command == 'getlatest':
    if args.list is sys.stdin:
      release_list = args.list.read()
    else:
      release_list = args.list
    print(get_highest_version_from_gh_list(release_list))
  else:
    parser.print_help()
