#!/usr/bin/env python3

"""Helps getting names of GUI elements for IDE support.
Use paths relative to the script. Use inside the script folder.
Example calls:
  python ./generateGuiNames.py
  python ./generateGuiNames.py ../dir/input.xml
  python ./generateGuiNames.py ../dir/input.xml ./output.lua
  python ./generateGuiNames.py ../xml/FurnitureCatalogue.xml
  python ./generateGuiNames.py ../FurnitureCatalogue_DevUtility/xml.xml
"""

import sys
import xml.etree.ElementTree as ET

EXIT_FAILURE = -1
EXIT_SUCCESS = 0

PREFIX_PARENT = '$(parent)'

# XMLClass: APIClass
TAG_CLASSES = {
  "Backdrop": "BackdropControl",
  "Button": "ButtonControl",
  "Control": "Control",
  "EditBox": "EditControl",
  "Label": "LabelControl",
  "Slider": "SliderControl",
  "Texture": "TextureControl",
  "TopLevelControl": "Control",
}

CTRL_UNKNOWN = "'???'"

def load_xml_file(path: str) -> ET.Element:
  """Get node and its hierarchy from an xml file"""
  try:
    tree = ET.parse(path)
    root = tree.getroot()
  except Exception:
    print(f"File not found or invalid XML: {path}")
    print(f"Please run from inside the script folder and use relative paths like ../dir/some.xml")
    exit(EXIT_FAILURE)
  return root

def get_file_content(path: str) -> list[str]:
  """Get content of file, empty if doesn't exist"""
  try:
    with open(path, 'r') as file:
      content = file.readlines()
    return content
  except FileNotFoundError:
    return []

def get_parent_name(node: ET.Element, parent_map: dict) -> str:
  """Find parent in supplied map"""
  parent = parent_map[node]
  if parent is None: return None
  parent_name = parent.get("name")
  return parent_name or get_parent_name(parent, parent_map)

def get_resolved_hierarchy(root: ET.Element) -> list[str]:
  """Traverse and resolve Node names level by level"""
  result = []
  # ET cannot get parents, we need to save them in a map
  parent_map = {c:p for p in root.iter() for c in p}
  level_nodes = [root]
  level = 0
  while level_nodes:
    next_level_nodes = []
    result.append(f"---------- LVL: {level:02d} ----------\n")
    for node in level_nodes:
      node_name = node.get('name')
      if node_name and node_name.startswith(PREFIX_PARENT):
        parent = parent_map[node]
        parent_name = get_parent_name(parent, parent_map)
        node.set('name', f"{parent_name}{node_name[len(PREFIX_PARENT):]}")
        result.append(f"{node.get('name')} = {TAG_CLASSES.get(node.tag, CTRL_UNKNOWN)}\n")
      elif node_name:
        # Name already resolved
        result.append(f"{node_name} = {TAG_CLASSES.get(node.tag, CTRL_UNKNOWN)}\n")

      # store next level
      next_level_nodes.extend(list(node))

    # move down 1 level
    level_nodes = next_level_nodes
    level += 1

  return result

def write_lua_doc(identifier: str, lua_path: str, content: str):
  lua_content = get_file_content(lua_path)

  start_marker  = f"-- ////// START : GENERATED FROM {identifier}\n"
  end_marker    = f"-- ////// END   : GENERATED FROM {identifier}\n"

  try:
    # replace region, if already exists
    start_index = lua_content.index(start_marker)
    end_index = lua_content.index(end_marker)
    lua_content[start_index + 1:end_index] = content
  except ValueError:
    # append region, if doesn't exist
    lua_content.extend([start_marker] + content + [end_marker])

  # save changes to file
  with open(lua_path, 'w') as file:
    file.writelines(lua_content)


if __name__ == '__main__':
  lua_path = "AutocompleteDefinitions.lua"

  if len(sys.argv) == 1:
    # use default files if none supplied
    xml_paths = ["../xml/FurnitureCatalogue.xml", "../FurnitureCatalogue_DevUtility/xml.xml"]
    for xml_path in xml_paths:
      resolved_names = get_resolved_hierarchy(load_xml_file(xml_path))
      write_lua_doc(identifier=xml_path, lua_path=lua_path, content=resolved_names)
      print(f"Wrote {xml_path} to {lua_path}")
    exit(EXIT_SUCCESS)

  if len(sys.argv) > 1:
    xml_path = sys.argv[1].replace('\\','/')
  if len(sys.argv) > 2:
    lua_path = sys.argv[2].replace('\\','/')

  resolved_names = get_resolved_hierarchy(load_xml_file(xml_path))
  write_lua_doc(identifier=xml_path, lua_path=lua_path, content=resolved_names)
  print(f"Wrote {xml_path} to {lua_path}")
  exit(EXIT_SUCCESS)
