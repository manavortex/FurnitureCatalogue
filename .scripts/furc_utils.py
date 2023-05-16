#!/usr/bin/env python3

import glob
import os
import re
import shutil
import urllib

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

RE_CHANGELOG_VERSION = re.compile(r"(?=\n\d+[\w\.\(\)\-]*)")
"""just for splitting changelog"""

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


def get_str_before_delim(note: str, delim: str="[//]:") -> str:
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
  a_parts += [0] * (max_length - len(a_parts))
  b_parts += [0] * (max_length - len(b_parts))

  if a_parts < b_parts:
      return -1
  elif a_parts > b_parts:
      return 1
  else:
      return 0

def get_binary_as_str(archive_uri: str):
  """Returns file content as binary string

  Args:
      archive_uri (str): file path or URL

  Returns:
      _type_: binary string
  """

  if archive_uri.startswith('http://') or archive_uri.startswith('https://'):
    with urllib.request.urlopen(archive_uri) as response:
      data = response.read()
  elif os.path.isfile(archive_uri):
    with open(archive_uri, 'rb') as file:
      data = file.read()
  else:
    raise ValueError("archive_uri is neither a valid URL nor a local file path")

  return data

def crash_and_burn(msg: str=''):
  """Performs some crashing and/or burning"""
  print(f"🔥 ABORT ABORT ABORT: {msg} 🔥")
  exit(EXIT_FAILURE)

if __name__ == '__main__':
  print("I'm a module, why are you running me")
