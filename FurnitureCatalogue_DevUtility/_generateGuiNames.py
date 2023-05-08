#!/usr/bin/env python3

import sys
from pathlib import Path
import xml.etree.ElementTree as ET

'''
Example call:
python .\_generateGuiNames.py 'C:/Users/UserName/Documents/Elder Scrolls Online/live/AddOns/FurnitureCatalogue/xml/FurnitureCatalogue.xml'
'''

PREFIX_PARENT = '$(parent)'

def load_xml_file(xml_file_path):
  tree = ET.parse(xml_file_path)
  root = tree.getroot()
  return root

def get_parent_name(node, parent_map):
  parent = parent_map[node]
  if parent is None: return None
  parent_name = parent.get("name")
  return parent_name or get_parent_name(parent, parent_map)

def resolve_names_bfs(root):
  parent_map = {c:p for p in root.iter() for c in p}
  level_nodes = [root]
  level = 0
  while level_nodes:
    next_level_nodes = []
    print(f"---------- LVL: {level:02d} ----------")
    for node in level_nodes:
      node_name = node.get('name')
      if node_name and node_name.startswith(PREFIX_PARENT):
        parent = parent_map[node]
        parent_name = get_parent_name(parent, parent_map)
        node.set('name', f"{parent_name}{node_name[9:]}")
        print(f"{node.get('name')} = {node.tag}")
      elif node_name:
        # Name already resolved
        print(f"{node_name} = {node.tag}")

      # store next level
      next_level_nodes.extend(list(node))

    # move down 1 level
    level_nodes = next_level_nodes
    level += 1

# ToDo: Autogenerator for XML and EN-locale.lua
MARKER_START = '-- START OF GENERATED CODE BLOCK FOR FILE: '
MARKER_END = '-- END OF GENERATED CODE BLOCK FOR FILE: '


if __name__ == '__main__':
  file_path = f"{Path(__file__).parent}/../xml/FurnitureCatalogue.xml"
  if len(sys.argv) > 1:
    file_path = sys.argv[1]

  root_node = load_xml_file(file_path)
  resolve_names_bfs(root_node)



