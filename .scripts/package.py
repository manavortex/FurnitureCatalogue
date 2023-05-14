#!/usr/bin/env python3

import argparse
import glob
import os
import re
import shutil
import zipfile

"""
Generates package for release. Use standalone or in automated workflow.
Run from project root, not from inside this folder.
Does not sanitise user input, so use only with trusted input.
"""

EXIT_FAILURE = -1

PACKAGE_DIR = '.package' # package folder, will be deleted if it already exists
NO_VERSION = 'NO_VERSION'

TYPE_MANIFEST_ESO = 'TYPE_MANIFEST_ESO'
EXT_MANIFEST_ESO = '.txt'

TYPE_MANIFEST_ADDITIONAL = 'TYPE_MANIFEST_ADDITIONAL'
EXT_MANIFEST_ADDITIONAL = '.manifest'

IS_GITHUB = os.getenv('GITHUB_ACTIONS') is not None
GITHUB_PIPE = '>> $GITHUB_STEP_SUMMARY'

MANIFEST_HEADER = {
  'Title': '',
  'Version': NO_VERSION,
  'type': TYPE_MANIFEST_ADDITIONAL,
  'files': None
}
RE_MANIFEST_FIELD = re.compile(f"^##\s*(?P<KEY>\w+):\s*(?P<VALUE>.+)$")

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
            if '*' in line: # need to resolve filemasks here for shutil.copy
              manifest['files'].extend(glob.glob(os.path.join(manifest_dir, line)))
            else:
              manifest['files'].append(os.path.join(manifest_dir, line))

    if manifest_file.endswith('.txt'):
      manifest['type'] = TYPE_MANIFEST_ESO

  except Exception as ex:
    LOG['errors'].append(f"Failed to get data from {manifest_file}: {ex}")
  return manifest

def package_addon(name: str, exclude_filename: str):
  """Copies select files to package directory. Creates zip archive for release.

  Args:
      name (_type_): AddOn title for version and name of archive
      exclude_filename (_type_): File name to be excluded from the package.
  """

  addon_name = name or 'FurnitureCatalogue'
  addon_version = NO_VERSION

  # Clear preexisting package, to catch cases in which it was created in a different way
  if os.path.exists(PACKAGE_DIR):
    shutil.rmtree(PACKAGE_DIR)

  files_to_copy = []
  found_manifests = find_manifests('.', (EXT_MANIFEST_ESO, EXT_MANIFEST_ADDITIONAL))
  LOG['infos'].append(f"{len(found_manifests)} manifest files checked")
  # parse all files mentioned in detected AddOn manifests
  for manifest in found_manifests:
    manifest_data = get_manifest_data(manifest)
    if addon_version == NO_VERSION and manifest_data['Title'] == addon_name:
      addon_version = manifest_data['Version']
    files_to_copy.extend(manifest_data['files'])

    # Add only the manifest files required by ESO
    if manifest_data['type'] == TYPE_MANIFEST_ESO:
      LOG['infos'].append(f"detected: {manifest_data['Title']}@v{manifest_data['Version']}")
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
      LOG['warnings'].append(f"skipped file: {ex}")
      continue

  LOG['infos'].append(f"added {counter}/{len(files_to_copy)} files")

  # zip it
  archive = f"{addon_name}-{addon_version}.zip"
  if addon_version == NO_VERSION:
    LOG['errors'].append('version was not set, aborting packaging')
    crash_and_burn_gracefully()

  with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for root, _, files in os.walk(addon_dir):
      for file in files:
        src_file = os.path.join(root, file)
        target_file = src_file.replace(PACKAGE_DIR, '')
        zipf.write(src_file, arcname=target_file)

  if IS_GITHUB:
    print_summary(GITHUB_PIPE)
  else:
    print_summary()

# Logging and error handling

def crash_and_burn_gracefully():
  if IS_GITHUB:
    print_summary(GITHUB_PIPE)
  else:
    print_summary()
  exit(EXIT_FAILURE)

LOG = {'errors': [],'warnings': [],'infos': [],}
def log(type:str, msg:str):
  LOG[type].append(msg)

def get_log_summary() -> list[str]:
  summary = []

  if len(LOG['errors']) > 0:
    summary.append('### Errors ❌')
    for error in LOG['errors']:
      summary.append(f"- {error}")

  if len(LOG['warnings']) > 0:
    summary.append('### Warnings ⚠️')
    for warning in LOG['warnings']:
      summary.append(f"- {warning}")

  summary.append('### Infos ✅')
  for info in LOG['infos']:
    summary.append(f"- {info}")

  return summary

def print_summary(pipe: str=None):
  if pipe is not None:
    for entry in get_log_summary():
      print(f"echo \"{entry}\" {pipe}")
  else:
    for entry in get_log_summary():
      print(f"{entry}")

if __name__ == '__main__':
  parser = argparse.ArgumentParser(description="Package AddOn for release")
  parser.add_argument('--name', help='AddOn title for version and zip name', default="FurnitureCatalogue")
  parser.add_argument('--exclude_filename', help='Will be excluded from package', default="Custom.lua")
  args = parser.parse_args()

  package_addon(args.name, args.exclude_filename)
