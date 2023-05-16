#!/usr/bin/env python3

import argparse
import os
import shutil
import zipfile

import furc_utils as FU

"""
Generates package for release. Use standalone or in automated workflow.
Run from project root, not from inside this folder.
Does not sanitise user input, so use only with trusted input.
"""

PACKAGE_DIR = '.package' # package folder, will be deleted if it already exists

IS_GITHUB = os.getenv('GITHUB_ACTIONS') is not None

def find_manifests(directory: str, file_ext: ...) -> list[str]:
  """Returns list with potential manifest files"""
  manifests = []
  directory = os.path.normpath(directory)
  try:
    for root, _, files in os.walk(directory):
      for source in files:
        if source.endswith(file_ext):
          manifests.append(os.path.join(root, source))
  except Exception:
    return []

  return manifests

def package_addon(name: str, exclude_filename: str):
  """Copies select files to package directory. Creates zip archive for release.

  Args:
      name (_type_): AddOn title for version and name of archive
      exclude_filename (_type_): File name to be excluded from the package.
  """

  addon_name = name or 'FurnitureCatalogue'
  addon_version = FU.NO_VERSION

  # Clear preexisting package, to catch cases in which it was created in a different way
  if os.path.exists(PACKAGE_DIR):
    shutil.rmtree(PACKAGE_DIR)

  files_to_copy = []
  found_manifests = find_manifests('.', (FU.EXT_MANIFEST_ESO, FU.EXT_MANIFEST_ADDITIONAL))
  print(f"{len(found_manifests)} manifest files checked")
  # parse all files mentioned in detected AddOn manifests
  for manifest in found_manifests:
    manifest_data = FU.get_manifest_data(manifest)
    if addon_version == FU.NO_VERSION and manifest_data['Title'] == addon_name:
      addon_version = manifest_data['Version']
    files_to_copy.extend(manifest_data['files'])

    # Add only the manifest files required by ESO
    if manifest_data['type'] == FU.TYPE_MANIFEST_ESO:
      print(f"detected: {manifest_data['Title']}@v{manifest_data['Version']}")
      files_to_copy.append(manifest)

  addon_dir = os.path.normpath(os.path.join(PACKAGE_DIR, addon_name))
  # copy files
  counter = 0
  for source in files_to_copy:
    try:
      # skip excluded filenames
      if os.path.basename(source) == exclude_filename: continue
      source = os.path.normpath(source)
      target = os.path.normpath(os.path.join(addon_dir, source))
      os.makedirs(os.path.dirname(target), exist_ok=True) # Create target directory
      shutil.copy(source, target)
      counter += 1
    except Exception as ex: # continue on error
      print(f"skipped file: {ex}")
      continue

  print(f"added {counter}/{len(files_to_copy)} files")

  # zip it
  archive = f"{addon_name}-{addon_version}.zip"
  if addon_version == FU.NO_VERSION:
    FU.crash_and_burn('version was not set, aborting packaging')

  with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for root, _, files in os.walk(addon_dir):
      for file in files:
        src_file = os.path.join(root, file)
        target_file = src_file.replace(PACKAGE_DIR, '')
        zipf.write(src_file, arcname=target_file)

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description="Package AddOn for release")
  parser.add_argument('--name', help='AddOn title for version and zip name', default="FurnitureCatalogue")
  parser.add_argument('--exclude_filename', help='Will be excluded from package', default="Custom.lua")
  args = parser.parse_args()

  package_addon(args.name, args.exclude_filename)
