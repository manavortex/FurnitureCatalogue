#!/usr/bin/env python3

import argparse
import json
import os
import requests

import furc_utils as FU

"""Connects to ESOUI API and updates our AddOn. All API calls should be handled in here.

Refer to api_esoui.yml for definitions. You can preview it like (might have to change path to .yml in the URL):
https://petstore.swagger.io/?url=https://raw.githubusercontent.com/manavortex/FurnitureCatalogue/master/.scripts/api_esoui.yml
"""

ADDON_ID = 1617
ADDON_MANIFEST_FILE = 'FurnitureCatalogue.txt'

_DATA: dict = {}

API_TOKEN = os.getenv('ESOUI_API_TOKEN')
HEADERS = {'x-api-token': API_TOKEN}

CHANGELOG_FILE = 'CHANGELOG'
CHANGELOG_HEADER_DELIM = '---'
CHANGELOG_HEADER_DEFAULT =f'''If you don't find change notes, it's because it's Luxury Furnisher. Booooring.

Speaking of boring: if you're really bored you can find the full changelog [URL="https://github.com/manavortex/FurnitureCatalogue/blob/master/{CHANGELOG_FILE}"]here[/URL] and all undocumented changes [URL="https://github.com/manavortex/FurnitureCatalogue/commits/master"]here[/URL].
'''

RELEASE_NOTE_DEFAULT = '''
[//]: # (⬆️⬆️⬆️ ABOVE WILL BE SENT TO ESOUI CHANGELOG ⬆️⬆️⬆️)
[//]: # (DO NOT DELETE THESE COMMENTS MARKED WITH ARROWS)
[//]: # (⬇️⬇️⬇️ STUFF BELOW WONT BE SENT TO ESOUI ⬇️⬇️⬇️)
'''
RELEASE_NOTE_DELIM = "[//]:"

API_BASE = "https://api.esoui.com/addons"
API_COMPATIBLE_LIST = f"{API_BASE}/compatible.json"
API_ADDON_DETAILS = f"{API_BASE}/details/{ADDON_ID}.json"
#API_UPDATE = f"{API_BASE}/update" # TODO: Switch when actions are functioning
API_UPDATE = f"{API_BASE}/updatetest"


def get_addon_details_from_api() -> dict[any]:
  """Get details of our AddOn from ESOUI as JSON"""

  print(f"Getting AddOn Details from: {API_ADDON_DETAILS}")
  response = requests.get(API_ADDON_DETAILS, headers=HEADERS)
  response.raise_for_status()
  response_json = response.json()[0]

  return response_json


def send_update_request(data: dict) -> dict[any]:
  print(f"Sending update request to: {API_UPDATE}")
  if not data: FU.crash_and_burn("no body to send")

  # make sure the request is in the desired format
  form_data = {key: (None, value) for key, value in data.items()}
  # autodetected application/zip does not work, fallback to application/octet-stream
  form_data['updatefile'] = (data['updatefile_name'], data['updatefile'], 'application/octet-stream')
  del form_data['updatefile_name']

  response = requests.post(API_UPDATE, headers=HEADERS, files=form_data)
  response.raise_for_status()

  # The test API returns invalid JSON like [{COMPATIBILITY LISTS}]{REAL TESTRESPONSE}
  # catch this, in case this is also a problem for the production API
  try:
    response_json = response.json()
  except requests.exceptions.JSONDecodeError:
    response_json  = f"{response.content.decode()}".split('}]{', 1)[-1]
    try:
      # second try
      response_json = json.loads('{' + response_json)
    except json.JSONDecodeError:
      # let's just give up on the response, no error status, so it probably worked
      response_json = {'status': response.status_code}

  return response_json


def get_addon_data() -> dict:
  """Gets AddOnData from ESOUI and the Manifest file"""
  global _DATA
  if _DATA: return _DATA # fetch only once

  manifest = FU.get_manifest_data(ADDON_MANIFEST_FILE)
  _DATA['manifest_version'] = manifest['Version']
  _DATA['archive_name'] = f"{manifest['Title']}-{manifest['Version']}"
  compatible_versions = get_compatible_eso_versions(manifest['APIVersion'])

  current_addon_details = get_addon_details_from_api()
  _DATA['live_id'] = ADDON_ID
  _DATA['live_version'] = current_addon_details['version']
  _DATA['live_changelog'] = current_addon_details['changelog']
  _DATA['live_compatible'] = ",".join(compatible_versions)

  return _DATA


def get_compatible_eso_versions(apiversion: str) -> list[str]:
  """Determine the compatibility level of our AddOn."""

  print('Getting versions our AddOn is compatible with')
  try:
    response = requests.get(API_COMPATIBLE_LIST, headers=HEADERS)
    response.raise_for_status()
    response_json = response.json()

    # Take largest APIVersion if multiple like '101037 101038'
    max_compatibility = max(apiversion.split(' '))
    compatible_with = []

    for entry in response_json:
      if max_compatibility >= entry['interface']:
        compatible_with.append(entry['id'])
    return compatible_with

  except requests.exceptions.JSONDecodeError as ex:
    print(f"Could not process JSON response: {ex}")
  except requests.exceptions.RequestException as ex:
    print(f"Received error from server: {ex}")


def validate_versions(live:str, local:str, tag:str):
  """Aborts the script if something is wrong."""
  if tag and FU.compare_versions(local, tag) != 0:
    FU.crash_and_burn(f"Version mismatch! Release Tag:{tag}, Manifest:{local}")
  if FU.compare_versions(local, live) <= 0:
    FU.crash_and_burn(f"Version not increased! Our version:{local}, Online version:{live}")


def publish_to_esoui(optional_params: dict = {}):
  """Perform all steps required for Publishing.
    - prepare request body
    - get AddOn data from API
    - get AddOn data from manifest
    - save GitHub release note to CHANGELOG
    - get truncated version of CHANGELOG
  """
  body = {}
  meta = {}

  # it puts the data in its body
  addon_data = get_addon_data()

  # we only use: id, version, compatible, changelog, updatefile
  body['id'] = addon_data['live_id']
  body['version'] =  addon_data['live_version']
  body['compatible'] = addon_data['live_compatible']
  body['changelog'] = addon_data['live_changelog']

  # Check versions before proceeding
  meta['version'] =  addon_data['manifest_version']
  version_tag = optional_params['tag']
  validate_versions(body['version'], meta['version'], version_tag)
  # The new version seems fine, we can replace it in the request body
  body['version'] = version_tag

  # Get content of zip file, abort if too smol
  try:
    archive_path = optional_params['archive_file']
    archive_content = FU.file_to_binary_string( archive_path )
  except KeyError:
    FU.crash_and_burn('no zip, no live')
  except ValueError as ve:
    FU.crash_and_burn(ve)

  if len(archive_content) < 1024:
    FU.crash_and_burn(f"Zip archive is too small ({len(archive_content)}B), something must be wrong or compression algorithms have gotten way better")
  body['updatefile'] = archive_content
  body['updatefile_name'] = f"{addon_data['archive_name']}.zip"

  # Prepare changelog
  meta['changelog_file'] = optional_params.get('changelog_file', CHANGELOG_FILE)
  change = FU.extract_header(optional_params.get('note', ''), RELEASE_NOTE_DELIM) # Get change from release note
  FU.prepend_str_to_file(change, meta['changelog_file']) # REPO: add release notes to changelog
  # ESOUI: Save changelog comment
  esoui_cl_comment = FU.extract_header(body['changelog'], CHANGELOG_HEADER_DELIM)
  if esoui_cl_comment:
    esoui_cl_comment = f"{esoui_cl_comment}\n{CHANGELOG_HEADER_DELIM}\n"
  else:
    esoui_cl_comment = CHANGELOG_HEADER_DEFAULT
  new_kids_on_the_log = [esoui_cl_comment]
  max_entries = params.get('changelog_max_notes', 10)
  new_kids_on_the_log.extend(FU.get_latest_log_entries(meta['changelog_file'], entries=max_entries))
  body['changelog'] = '\n'.join(new_kids_on_the_log)

  response = send_update_request(body)


if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Publish a new release.')
  parser.add_argument('--tag', help='Release tag like 1.234, used to compare with manifest')
  parser.add_argument('--note', type=str, default=f"{RELEASE_NOTE_DEFAULT}", help='Release notes')
  parser.add_argument('--note-delimiter', default="[//]:", help='Text before the delim is added to the ESOUI changelog.')
  parser.add_argument('--changelog-file', default='CHANGELOG', help='Path to the changelog file')
  parser.add_argument('--changelog-max-notes', default=10, help='Truncate the ESOUI changelog to the x latest notes')
  parser.add_argument('--archive-file', type=str, help='Path to the release archive file')

  params = {}
  args = parser.parse_args()
  params['tag'] = args.tag
  params['note'] = args.note
  params['note_delimiter'] = args.note_delimiter
  params['changelog_file'] = args.changelog_file
  params['changelog_max_notes'] = args.changelog_max_notes
  params['archive_file'] = args.archive_file

  try:
    publish_to_esoui(params)
  except Exception as ex:
    # Abort for safety reasons
    FU.crash_and_burn(f"Error: {ex}")
