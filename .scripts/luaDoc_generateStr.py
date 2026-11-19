#!/usr/bin/env python3

"""Helps getting string definitions for IDE support. Also used to generate missing string variables in all locale files. Make a backup, if you have manual entries.

Use inside the project folder and paths relative it, because those are being used as identifiers for the code section markers like:

-- ////// START : GENERATED FROM locale/en.lua
...
-- ////// END   : GENERATED FROM locale/en.lua

Example calls (use your main language files only):
  python .scripts/luaDoc_generateStr.py
  python .scripts/luaDoc_generateStr.py locale/en.lua
  python .scripts/luaDoc_generateStr.py locale/en.lua docs/autocomplete_definitions.lua
  python .scripts/luaDoc_generateStr.py locale/en.lua locale/de.lua --generate-translation
"""

import glob
import re
import sys

MASTER_SUFFIX = 'locale/en.lua'

EXIT_FAILURE = -1
EXIT_SUCCESS = 0

def get_file_content(path: str) -> list[str]:
  """Get content of file as a list, empty if doesn't exist"""
  try:
    with open(path, 'r') as file:
      content = file.readlines()
    return content
  except FileNotFoundError:
    return []


def extract_strings(lines: list) -> dict:
  """Collects valid string definition pairs.
  Args:
      lines (list): Raw file content

  Returns:
      dict: {'KEY': VAL} like {'FURC_AV_RAZ': 'Razoufa'}
  """

  # SI_FURC_STRING_WASSOLDBY = "Was sold by <<1>> in <<2>> (<<3>>) <<4>>",
  # A quoted value is taken whole, or a `--` inside it reads as the start of a trailing Lua comment and the rest of the string is dropped
  RE_STRING_PAIR = re.compile(
    r'^\s*(?P<KEY>[A-Z][A-Z0-9_]*)\s*=\s*'
    r'(?P<VAL>"(?:[^"\\]|\\.)*"|.+?)'
    r'\s*,?(\s*--.+)?\s*$')

  str_map = {}
  for line in lines:
    string_match = RE_STRING_PAIR.fullmatch(line)
    if string_match:
      key = string_match.group('KEY').strip()
      val = string_match.group('VAL').strip()
      str_map[key] = f"{val}"

  return str_map

def merge_translation(curlang_map: dict, reflang_map: dict) -> tuple[dict,dict,dict]:
  """
  Sorts a translation against the reference. A translation file holds only what was translated (missing falls back to English)

  Args:
    curlang_map (dict): Map of the current translation (ex 'de.lua')
    reflang_map (dict): Reference language map

  Returns:
    tuple[dict,dict,dict]: Translated map, leftover map, untranslated map
      - translated map: what the translation defines, a identical string included (two languages may use the same word)
      - leftover map: definitions in translation but not in base
      - untranslated map: reference strings the translation does not define; just reported, not stored
  """
  leftovers = {key: val for key, val in curlang_map.items() if key not in reflang_map}
  translated = {key: val for key, val in curlang_map.items() if key in reflang_map}
  untranslated = {key: val for key, val in reflang_map.items() if key not in curlang_map}
  return (translated, leftovers, untranslated)

# markers to identify the region that will be overwritten in translation files
TRANSL_START_MARKER  = "-- ////// START : DON'T REMOVE THIS LINE"
TRANSL_END_MARKER    = "-- ////// END   : DON'T REMOVE THIS LINE"

# What the strings table is handed to at the end of a locale file
REGISTER_STRINGS = """for stringId, stringValue in pairs(strings) do
  ZO_CreateStringId(stringId, stringValue)
  SafeAddVersion(stringId, 1)
end"""

NEW_TRANSLATION_FILE = f"""-- Auto-synced from locale/en.lua by luaDoc_generateStr.py
-- (translated strings only, copy missing ones from en.lua)
-- Edit values between START/END markers
local strings = {{
  {TRANSL_START_MARKER}
  {TRANSL_END_MARKER}
}}

{REGISTER_STRINGS}
"""

def write_translation_file(out_path: str, merged: tuple[dict,dict,dict]):
  """(Re)writes the translation file with the merged map.
        Any leftover definitions are appended at the end.
        The file must contain the region markers or not exist yet.

  Args:
      out_path (str): Output file path
      merged (tuple[dict,dict,list]): Merged, leftover, untranslated maps
  """
  current_langfile = get_file_content(out_path)
  if not current_langfile:
    current_langfile.extend(NEW_TRANSLATION_FILE.splitlines(keepends=True))

  # just abort if the region markers are missing
  if not TRANSL_START_MARKER in (item.strip() for item in current_langfile):
    print(f"Error: Missing region marker in {out_path}")
    sys.exit(EXIT_FAILURE)

  # Extract string pairs from the maps
  str_list = [f"{key} = {val},\n" for key, val in merged[0].items()]
  leftover_list = [f"{key} = {val},\n" for key, val in merged[1].items()]

  # Get the region that will be replaced
  start_index = next(i for i, item in enumerate(current_langfile) if item.strip() == TRANSL_START_MARKER)
  end_index = next(i for i, item in enumerate(current_langfile) if item.strip() == TRANSL_END_MARKER)

  # 1. Insert our translations
  str_list.sort()
  current_langfile[start_index + 1:end_index] = str_list
  end_index = start_index + 1 + len(str_list)

  # 2. Untranslated strings are not written: the game falls back to the reference text

  # 3. Insert any leftovers
  if leftover_list:
    leftover_list.sort()
    current_langfile[end_index:end_index] = leftover_list
    current_langfile.insert(end_index, f"-- {len(leftover_list)} LEFTOVER TRANSLATIONS, PLEASE CHECK!\n")

  # save changes to file
  with open(out_path, 'w') as file:
    file.writelines(current_langfile)


def write_lua_doc(identifier: str, doc_path: str, str_map: dict):
  current_luadoc = get_file_content(doc_path)
  str_list = [f"{key} = {val}\n" for key, val in str_map.items()]
  str_list.sort()

  start_marker  = f"-- ////// START : GENERATED FROM {identifier}\n"
  end_marker    = f"-- ////// END   : GENERATED FROM {identifier}\n"
  try:
    # replace region, if already exists
    start_index = current_luadoc.index(start_marker)
    end_index = current_luadoc.index(end_marker)
    current_luadoc[start_index + 1:end_index] = str_list
  except ValueError:
    # append region, if doesn't exist
    current_luadoc.extend([start_marker] + str_list + [end_marker])

  # save changes to file
  with open(doc_path, 'w') as file:
    file.writelines(current_luadoc)


if __name__ == '__main__':
  # Default files (relative to PWD)
  input_file = "locale/en.lua"
  out_path = "docs/autocomplete_definitions.lua"

  # Default use case: Generate LuaDoc for all locale masters (main addon + any bundled addon)
  if len(sys.argv) == 1:
    masters = sorted(p.replace('\\', '/') for p in glob.glob(f'**/{MASTER_SUFFIX}', recursive=True))
    if not masters:
      print(f"Error: no {MASTER_SUFFIX} found — run from the project root.")
      sys.exit(EXIT_FAILURE)
    for master in masters:
      str_map = extract_strings(get_file_content(master))
      write_lua_doc(master, out_path, str_map)
      print(f"Wrote {master} to {out_path}")

    sys.exit(EXIT_SUCCESS)

  # Clean up paths
  if len(sys.argv) > 1:
    input_file = sys.argv[1].replace('\\','/')
  if len(sys.argv) > 2:
    out_path = sys.argv[2].replace('\\','/')

  if input_file == out_path:
    print("Error: Input and output file are the same.")
    sys.exit(EXIT_FAILURE)

  if out_path.endswith(MASTER_SUFFIX):
    print(f"Error: {out_path} is a master file, it is never generated.")
    sys.exit(EXIT_FAILURE)

  # Parse input file
  str_map = extract_strings(get_file_content(input_file))

  # Check if we want to generate a translation file
  make_translation = len(sys.argv) == 4 and sys.argv[3] == '--generate-translation'

  # Only 2 cases: luadoc or translation file generation
  if(make_translation):
    reflang_map = extract_strings(get_file_content(input_file))
    curlang_map = extract_strings(get_file_content(out_path))
    merged = merge_translation(curlang_map, reflang_map)
    write_translation_file(out_path, merged)
    print(f"{len(merged[2])} untranslated in {out_path}" + (": " + ", ".join(sorted(merged[2])) if merged[2] else ""))
  else:
    write_lua_doc(input_file, out_path, str_map)

  print(f"Wrote {input_file} to {out_path}")
  sys.exit(EXIT_SUCCESS)
