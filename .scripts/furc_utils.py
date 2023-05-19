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


'''
.---------------------------------------.
|                                       |
|     PARSING & STRING OPERATIONS       |
|                                       |
.---------------------------------------.
'''

TYPE_MF_ESO = 'TYPE_MF_ESO'
EXT_MF_ESO = '.txt'
EXT_MF_ADDITIONAL = '.manifest'
TYPE_MF_ADDITIONAL = 'TYPE_MF_ADDITIONAL'

PROP_MF_TITLE='Title'
PROP_MF_VERSION='Version'
PROP_MF_APIVERSION='APIVersion'
PROP_MF_TYPE='type'
PROP_MF_FILES='files'

MANIFEST_HEADER = {
  PROP_MF_TITLE: '', # Title ingame
  PROP_MF_VERSION: '',
  PROP_MF_TYPE: TYPE_MF_ADDITIONAL,
  PROP_MF_FILES: None
}

RE_MANIFEST_FIELD = re.compile(r"^##\s*(?P<KEY>\w+):\s*(?P<VALUE>.+)$")
"""match manifest properties"""

RE_CL_SPLIT = re.compile(r"(?=\n\d+\s?[\w\.\(\)\-]*)")
"""just for splitting changelog"""

RE_CL_VERSION_HEADER = re.compile(r"^\d+[\.\d]*.*$", re.MULTILINE)
"""Headers like: 1.2.3 (2020-12-12)"""

def get_manifest_data(manifest_file: str) -> dict:
  """Extracts data from manifest file.
  All listed files are considered to be located relative to the manifest file path.

  Relevant fields:
    - PROP_MF_TITLE: str
    - PROP_MF_VERSION: str
    - PROP_MF_APIVERSION: str
    - PROP_MF_TYPE: TYPE_MF_ESO | TYPE_MF_ADDITIONAL
    - PROP_MF_FILES: list[str]

  Args:
      manifest_file (str): Path to manifest file

  Returns:
      str: Manifest as a dict.
  """

  manifest = dict.copy(MANIFEST_HEADER)
  manifest[PROP_MF_FILES] = []
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
              manifest[PROP_MF_FILES].extend(glob.glob(os.path.join(manifest_dir, line)))
            else:
              manifest[PROP_MF_FILES].append(os.path.join(manifest_dir, line))

    if manifest_file.endswith(EXT_MF_ESO):
      manifest[PROP_MF_TYPE] = TYPE_MF_ESO

  except Exception as ex:
    print(f"Failed to get data from {manifest_file}: {ex}")
  return manifest


def get_log_entries(cl_file: str, entries: int=20) -> list[str]:
  """Gets latest x entries from full changelog file

  Args:
      cl_file (str): Path to changelog file
      entries (int, optional): Max number of entries to show. Defaults to 20.

  Returns:
      list[str]: Truncated changelog
  """
  with open(cl_file, 'r') as f:
    data = f.read()
  return RE_CL_SPLIT.split(data, entries)[0:entries]


def extract_header_from_file(path: str, delim: str="[//]:"):
  if not os.path.exists(path): return ''

  with open(path, 'r', encoding='utf-8') as file:
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

CL_FILE = 'CHANGELOG'

def update_changelog(notes_file:str, header: str, cl_file: str=CL_FILE):
  # Prepare changelog
  change = extract_header_from_file(notes_file)
  if change:
    if header:
      # strip existing header, if any
      change = RE_CL_VERSION_HEADER.sub('', change.strip())
      # add new header, like: 1.2.3 (2020-12-12)
      change = f"{header}\n{change}"
    print(f"🧾 Writing to changelog:\n{change}")
    prepend_str_to_file(change, cl_file)
  else:
    print(f"🧾 Changelog unchanged")


'''
.---------------------------------------.
|                                       |
|           FILE OPERATIONS             |
|                                       |
.---------------------------------------.
'''

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


def replace_once_in_file(pattern_repl_fallback: list[tuple], path: str) -> bool:
  """Replaces first occurence of a matched regex pattern in a file

  Args:
      options (list[tuple]): tuples like (pattern, replacement, fallback)
      path (str): path to file (r+w)

  Returns:
      bool: True if file has changed
  """
  with open(path, 'r+', encoding='utf-8') as f:
    f_current = f.read()
    f_new = f_current

    for entry in pattern_repl_fallback:
      pattern, replacement, fallback = entry
      if not pattern.search(f_current):
        f_new = f"{fallback}\n" + f_new
      else:
        f_new = pattern.sub(repl=replacement, string=f_new, count=1)

    if f_current != f_new:
      f.seek(0)
      f.write(f_new)
      f.truncate()

  return f_current != f_new


'''
.---------------------------------------.
|                                       |
|   VERSIONING & VERSION PARSING        |
|                                       |
.---------------------------------------.
'''

def to_semver(ver: str) -> str:
  return int_to_semver(semver_to_int(ver))

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

  a_num = semver_to_int(a)
  b_num = semver_to_int(b)

  if a_num < b_num:
      return -1
  elif a_num > b_num:
      return 1
  else:
      return 0

def semver_to_int(version: str) -> int:
  if not version: raise ValueError("Version required")

  parts = version.split('.')
  major = int(parts[0])
  if major < 0: raise ValueError("No support for negative values")

  num = major * 1e6
  num += int(parts[1]) * 1e3 if len(parts) > 1 else 0
  num += int(parts[2]) if len(parts) > 2 else 0

  return int(num)

def int_to_semver(num: int) -> str:
    major = int(num // 1e6)
    num %= 1e6
    minor = int(num // 1e3)
    num %= 1e3
    patch = int(num)

    return f"{major}.{minor}.{patch}"


VERSION_IMPACT_MAJOR = 'major'
VERSION_IMPACT_MINOR = 'minor'
VERSION_IMPACT_PATCH = 'patch'
def get_next_version(current: str, impact: str = VERSION_IMPACT_MINOR) -> str:
  """Generates the next major, minor or patch version number.

  Args:
      current (str): version `x.y.z`, like `1.23.4` or `1`
      breaking_change (bool, optional): Defaults to False.

  Returns:
      str: `1.2.3` => major: `2.0.0`, minor: `1.24.0`, patch: `1.23.5`
  """
  # Validates version number and converts it to int
  ver_int = semver_to_int(current)

  if impact == VERSION_IMPACT_PATCH:
    ver_int += 1
  elif impact == VERSION_IMPACT_MAJOR:
    ver_int //= 1e6
    ver_int += 1
    ver_int *= 1e6
  else:
    ver_int //= 1e3
    ver_int += 1
    ver_int *= 1e3

  return int_to_semver(int(ver_int))


RE_GHLIST_TAG = re.compile(r"\s+(\d+[\.\d]+)\s+")
"""version tags like 1.23"""

def get_highest_version_from_gh_list(gh_list :str) -> str:
  """Get the highest release version from a list generated by gh cli

  ```
  Input example:
  Version 1.23    Pre-release     1.23    2023-05-16T15:12:00Z
  Version 4.6     Pre-release     4.6     2023-05-15T00:36:49Z
  Version 4.5     Latest  4.5     2023-05-15T00:59:34Z
  ```

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


RE_MF_VERSION_LINE = re.compile(r"(?P<PREFIX>^##\s*Version:\s*).*$", re.MULTILINE)
RE_MF_ADDONVERSION_LINE = re.compile(r"(?P<PREFIX>^##\s*AddonVersion:\s*).*$", re.MULTILINE)
RE_MAINLUA_VERSION_LINE = re.compile(r"(?P<PREFIX>^FurnitureCatalogue\.version\s*=\s*).*$", re.MULTILINE)

def replace_versions(new_semver: str, output_file: str=None):
  new_intver = semver_to_int(new_semver) # throws error if invalid
  changes = []

  # Replace version in main manifest
  mfpath = 'FurnitureCatalogue.txt'
  mf_values = [
    (RE_MF_VERSION_LINE, f"\g<PREFIX>{new_semver}", f"## Version: {new_semver}"),
    (RE_MF_ADDONVERSION_LINE, f"\g<PREFIX>{new_intver}", f"## AddonVersion: {new_intver}"),
  ]
  if replace_once_in_file(mf_values, mfpath): changes.append(mfpath)

  # Replace version in main file
  luapath = 'startup.lua'
  lua_values = [(RE_MAINLUA_VERSION_LINE, f"\g<PREFIX>{new_intver} -- will be AUTOREPLACED with AddonVersion",
    f"FurnitureCatalogue.version = {new_intver} -- will be AUTOREPLACED with AddonVersion")]
  if replace_once_in_file(lua_values, luapath): changes.append(luapath)

  if output_file:
    with open(output_file, 'w') as f:
      f.writelines('\n'.join(changes))
  else:
    print(f"Changed {len(changes)} files:")
    print('\n'.join(changes))


'''
.---------------------------------------.
|                                       |
|       ERROR HANDLING & MAIN           |
|                                       |
.---------------------------------------.
'''

EXIT_FAILURE = -1

def crash_and_burn(msg: str=''):
  """Performs some crashing and/or burning"""
  print(f"🔥 ABORT ABORT ABORT: {msg} 🔥")
  exit(EXIT_FAILURE)

# Make some methods available for shell use
if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  subparsers = parser.add_subparsers(dest='command')

  # 1. Bump Versions
  parser_bump = subparsers.add_parser('changeversion', help='Replace versions in predefined files')
  parser_bump.add_argument('--new-version', help='New version')
  parser_bump.add_argument('--output-file', help='Write list of changed files to this file')

  # 2. Compare Versions
  parser_cmp = subparsers.add_parser('compare', help='Compare two versions like 1.23.4<=>1.23.39 --> 1')
  parser_cmp.add_argument('a', type=str, help='First Version')
  parser_cmp.add_argument('b', type=str, help='Second version')

  # 3. Convert Version
  parser_conv = subparsers.add_parser('convert_version', help='Semver to int or other way around')
  conv_grp = parser_conv.add_mutually_exclusive_group(required=True)
  conv_grp.add_argument('--int', type=int, help='Int to semver like 3456780 -> 3.456.78')
  conv_grp.add_argument('--semver', type=str, help='Semver to int like 1.23.4 -> 1002304')

  # 4. Get String before delimiter
  parser_eh = subparsers.add_parser('extract_header', help='Get the first part of a text split at given delimiter')
  parser_eh.add_argument("--delimiter", default='[//]:', help='Delimiter the string splits at. Default=[//]')
  eh_group = parser_eh.add_mutually_exclusive_group(required=True)
  eh_group.add_argument('--text', help='Text containing the header')
  eh_group.add_argument('--file', help='Textfile containing the header')

  # 5. Get Binary String from file/URL
  parser_f2bin = subparsers.add_parser('file2binary', help='Return file content as a binary string like b\'ABC\\0x00\'')
  parser_f2bin.add_argument('filepath', help='local file or url')

  # 6. Get highest version number from gh formatted list
  parser_latest = subparsers.add_parser('getlatest', help='Get the highest version number from gh release list')
  parser_latest.add_argument('list', nargs='?', default=sys.stdin, help='The output of gh release list')

  # 7. Get next version number
  parser_next = subparsers.add_parser('nextversion', help='Get incremented version', description='Use a flag to set version change impact. No flag means minor change: 1.23.4 -> 1.24.0')
  parser_next.add_argument('--current', required=True, help='Current version')
  next_grp = parser_next.add_mutually_exclusive_group(required=False)
  next_grp.add_argument('--major', action='store_true', help='Major: 1.23.4 -> 2.0.0')
  next_grp.add_argument('--patch', action='store_true', help='Patch: 1.23.4 -> 1.23.5')

  # 8. Update Changelog
  parser_clup = subparsers.add_parser('update_changelog', help='Update the changelog if there are notes')
  parser_clup.add_argument('--notes-file', help='File containing notes')
  parser_clup.add_argument('--changelog-file', help='File to add changes to', default=CL_FILE)
  parser_clup.add_argument('--header', help='Header to add to the notes.')

  args = parser.parse_args()
  # 1. Bump Versions
  if args.command == 'changeversion':
    replace_versions(args.new_version, args.output_file)
  # 2. Compare Versions
  elif args.command == 'compare':
    print(compare_versions(args.a, args.b))
  # 3. Convert Version
  elif args.command == 'convert_version':
    if args.int:
      print(int_to_semver(args.int))
    else:
      print(semver_to_int(args.semver))
  # 4. Get String before delimiter
  elif args.command == 'extract_header':
    if args.file:
      print(extract_header_from_file(args.file, args.delimiter))
    else:
      print(extract_header(args.text, args.delimiter))
  # 5. Get Binary String from file/URL
  elif args.command == 'file2binary':
    print(file_to_binary_string(args.filepath))
  # 6. Get highest version number from gh formatted list
  elif args.command == 'getlatest':
    if args.list is sys.stdin:
      release_list = args.list.read()
    else:
      release_list = args.list
    print(get_highest_version_from_gh_list(release_list))
  # 7. Get next version number
  elif args.command == 'nextversion':
    if args.major:
      impact = VERSION_IMPACT_MAJOR
    elif args.patch:
      impact = VERSION_IMPACT_PATCH
    else:
      impact = VERSION_IMPACT_MINOR
    print(get_next_version(args.current, impact))
  # 8. Get next version number
  elif args.command == 'update_changelog':
    update_changelog(args.notes_file, args.header, args.changelog_file)
  else:
    parser.print_help()
