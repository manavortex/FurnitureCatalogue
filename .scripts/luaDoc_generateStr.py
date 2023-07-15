#!/usr/bin/env python3

"""Helps getting string definitions for IDE support. Make a backup, if you have manual entries.

Use inside the script folder and paths relative to the script, because those are being used as identifiers for the code section markers like:

-- ////// START : GENERATED FROM ../locale/en.lua
...
-- ////// END   : GENERATED FROM ../locale/en.lua

Example calls (load the main language files only):
  cd .scripts
  python ./luaDoc_generateStr.py
  python ./luaDoc_generateStr.py ../dir/lang.lua
  python ./luaDoc_generateStr.py ../dir/lang.lua ./output.lua
  python ./luaDoc_generateStr.py ../locale/en.lua

⚠️ Attention ⚠️
The string extraction flattens, meaning it does not support multidimensional string declarations like:
local namespace1 = {A = "namespace1 my string"}
local namespace2 = {A = "namespace2 my string"}
This will result in A being overwritten with "namespace2 my string"
"""

import re
import sys

EXIT_FAILURE = -1
EXIT_SUCCESS = 0

def get_file_content(path: str) -> list[str]:
  """Get content of file, empty if doesn't exist"""
  try:
    with open(path, 'r') as file:
      content = file.readlines()
    return content
  except FileNotFoundError:
    return []

def parse_file(lines: list) -> list:
  """Collects valid string lines to list

  Args:
      lines (list): Raw file content

  Returns:
      list: string entries as key-value pairs
  """

  # local filterDisabled = "disables this filter"
  RE_PLACEHOLDER = re.compile('^\s*local (?P<KEY>\w+)\s*=\s*(?P<VAL>(\'.+\')|(\".+\"))\s*(--.+)?$')

  # SI_FURC_STRING_WASSOLDBY = "Was sold by <<1>> in <<2>> (<<3>>) <<4>>",
  RE_STRING_PAIR = re.compile('^\s*(?P<KEY>[A-Z][A-Z0-9_]+)\s*=\s*(?P<VAL>.+?)\s*,?(\s*--.+)?\s*$')

  placeholders = []
  strings = []
  for line in lines:
    placeholder_match = RE_PLACEHOLDER.fullmatch(line)
    string_match = RE_STRING_PAIR.fullmatch(line)

    # normalise quotes and escapes in val or use as-is?
    if placeholder_match:
      key = placeholder_match.group('KEY').strip()
      val = placeholder_match.group('VAL').strip()
      placeholders.append(f"local {key} = {val}\n")
    elif string_match:
      key = string_match.group('KEY').strip()
      val = string_match.group('VAL').strip()
      strings.append(f"{key} = {val}\n")

  sep_ph  = ["\n------ PLACEHOLDERS ------\n"]
  sep_str = ["\n--------  STRINGS --------\n"]
  return sep_ph + placeholders + sep_str + strings


def write_lua_doc(identifier: str, lua_path: str, parsed: list):
  lua_content = get_file_content(lua_path)

  start_marker  = f"-- ////// START : GENERATED FROM {identifier}\n"
  end_marker    = f"-- ////// END   : GENERATED FROM {identifier}\n"

  try:
    # replace region, if already exists
    start_index = lua_content.index(start_marker)
    end_index = lua_content.index(end_marker)
    lua_content[start_index + 1:end_index] = parsed
  except ValueError:
    # append region, if doesn't exist
    lua_content.extend([start_marker] + parsed + [end_marker])

  # save changes to file
  with open(lua_path, 'w') as file:
    file.writelines(lua_content)

# ToDo: add str extraction for translation tables
def write_translation_csv(identifier: str, tbl_path: str, parsed: list):
  return ""


if __name__ == '__main__':
  lua_path = "luaDoc_Definitions.lua"
  str_kv_pairs = {}

  if len(sys.argv) == 1:
    # use default files if none supplied
    lng_paths = ["../locale/en.lua"]
    for lng_file in lng_paths:
      resolved_names = parse_file(get_file_content(lng_file))
      write_lua_doc(identifier=lng_file, lua_path=lua_path, parsed=resolved_names)
      print(f"Wrote {lng_file} to {lua_path}")
    exit(EXIT_SUCCESS)

  if len(sys.argv) > 1:
    lng_file = sys.argv[1].replace('\\','/')
  if len(sys.argv) > 2:
    lua_path = sys.argv[2].replace('\\','/')

  resolved_names = parse_file(get_file_content(lng_file))
  write_lua_doc(identifier=lng_file, lua_path=lua_path, parsed=resolved_names)
  print(f"Wrote {lng_file} to {lua_path}")
  exit(EXIT_SUCCESS)
