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

import re
import sys

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
      Caveats:
        - includes quotation
        - drops trailing commas
        - drops comments
        - does not include newlines

  Args:
      lines (list): Raw file content

  Returns:
      dict: {'KEY': VAL} like {'FURC_AV_RAZ': 'Razoufa'}
  """

  # SI_FURC_STRING_WASSOLDBY = "Was sold by <<1>> in <<2>> (<<3>>) <<4>>",
  RE_STRING_PAIR = re.compile(r'^\s*(?P<KEY>[A-Z][A-Z0-9_]*)\s*=\s*(?P<VAL>.+?)\s*,?(\s*--.+)?\s*$')

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
  Generates a combined map from the reference and the translations.

  Args:
    curlang_map (dict): Map of the current translation (ex 'de.lua')
    reflang_map (dict): Reference language map, used to fill in missing keys in curlang_map.

  Returns:
    tuple[dict,dict,dict]: Merged map, leftover map, untranslated map
      - merged map: combination of base lang and translation
      - leftover map: definitions in translation but not in base
      - untranslated map: strings that are the same in both (does not necessarily mean that the translation is missing, if 2 languages use the same word)
  """

  # Save leftover variables from translated file (not in reference language anymore)
  leftovers = {key: curlang_map[key] for key in (list(set(curlang_map.keys()) - set(reflang_map.keys())))}

  # Remove leftovers from translations
  for key in leftovers.keys():
    del curlang_map[key]

  merged = {**reflang_map, **curlang_map}
  untranslated = {}

  # Check for untranslated variables
  for key, val in merged.items():
    if key in reflang_map and key in curlang_map and reflang_map[key] == curlang_map[key]:
      untranslated[key] = val
    elif not key in curlang_map:
      untranslated[key] = val

  # Remove untranslated variables from merged map
  for key in untranslated.keys():
    del merged[key]

  return (merged, leftovers, untranslated)

# markers to identify the region that will be overwritten in translation files
TRANSL_START_MARKER  = "-- ////// START : DON'T REMOVE THIS LINE"
TRANSL_END_MARKER    = "-- ////// END   : DON'T REMOVE THIS LINE"

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
    current_langfile.extend(f"""
  local filterDisabled = "disables this filter"
  local strings = {{
    {TRANSL_START_MARKER}
    {TRANSL_END_MARKER}
  }}

  for stringId, stringValue in pairs(strings) do
    ZO_CreateStringId(stringId, stringValue)
    SafeAddVersion(stringId, 1)
  end

  """.splitlines(keepends=True))

  # just abort if the region markers are missing
  if not TRANSL_START_MARKER in (item.strip() for item in current_langfile):
    print(f"Error: Missing region marker in {out_path}")
    exit(EXIT_FAILURE)

  # Extract string pairs from the maps
  str_list = [f"{key} = {val},\n" for key, val in merged[0].items()]
  leftover_list = [f"{key} = {val},\n" for key, val in merged[1].items()]
  untranslated_list = [f"{key} = {val},\n" for key, val in merged[2].items()]

  # Get the region that will be replaced
  start_index = next(i for i, item in enumerate(current_langfile) if item.strip() == TRANSL_START_MARKER)
  end_index = next(i for i, item in enumerate(current_langfile) if item.strip() == TRANSL_END_MARKER)

  # 1. Insert our translations
  str_list.sort()
  current_langfile[start_index + 1:end_index] = str_list
  end_index = start_index + 1 + len(str_list)

  # 2. Insert any untranslated items
  if untranslated_list:
    untranslated_list.sort()
    current_langfile[end_index:end_index] = untranslated_list
    current_langfile.insert(end_index, f"-- {len(untranslated_list)} ENTRIES THE SAME IN BOTH LANGUAGES\n")
    end_index += len(untranslated_list) + 1

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

  # Default use case: Generate LuaDoc with default paths
  if len(sys.argv) == 1:
    # use default files if none supplied
    str_map = extract_strings(get_file_content(input_file))
    write_lua_doc(input_file, out_path, str_map)
    print(f"Wrote {input_file} to {out_path}")

    exit(EXIT_SUCCESS)

  # Clean up paths
  if len(sys.argv) > 1:
    input_file = sys.argv[1].replace('\\','/')
  if len(sys.argv) > 2:
    out_path = sys.argv[2].replace('\\','/')

  if input_file == out_path:
    print("Error: Input and output file are the same.")
    exit(EXIT_FAILURE)

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
  else:
    write_lua_doc(input_file, out_path, str_map)

  print(f"Wrote {input_file} to {out_path}")
  exit(EXIT_SUCCESS)
