#!/usr/bin/env python3

import argparse
import json
import os
import requests

"""ESOUI API related utilities.

Refer to api_esoui.yml for definitions. You can preview it like (might have to change path to .yml in the URL):
https://petstore.swagger.io/?url=https://raw.githubusercontent.com/manavortex/FurnitureCatalogue/master/.scripts/esoui_api.yml
"""

ADDON_ID = 1617
ADDON_MANIFEST_FILE = 'FurnitureCatalogue.txt'

API_BASE = "https://api.esoui.com/addons"

API_TOKEN = os.getenv('ESOUI_API_TOKEN')
HEADERS = {'x-api-token': API_TOKEN}

PROP_LIVE_ID = 'id'
PROP_LIVE_VERSION = 'version'
PROP_LIVE_CHANGELOG = 'changelog'
PROP_LIVE_COMPATIBLE = 'compatible'
PROP_LIVE_UPDATEFILE = 'updatefile'


def get_addon_details(addon_id: int=ADDON_ID) -> dict[any]:
  """Get details of our AddOn from ESOUI
    - PROP_LIVE_ID
    - PROP_LIVE_VERSION
    - LIVE_CHANGELOG
  """
  endpoint_details = f"{API_BASE}/details/{addon_id}.json"
  print(f"Getting AddOn Details from: {endpoint_details}")
  response = requests.get(endpoint_details, headers=HEADERS)
  response.raise_for_status()
  response_json = response.json()[0]

  # skip 'title', 'filename', 'updated', 'created', 'description', 'compatible', 'update'
  keep = [PROP_LIVE_ID, PROP_LIVE_VERSION, PROP_LIVE_CHANGELOG]
  return {k: v for k,v in response_json.items() if k in keep}


def get_addon_version(addon_id: int) -> str:
  addon_details = get_addon_details(addon_id)
  return addon_details[PROP_LIVE_VERSION]


def send_update_request(data: dict, archivename: str) -> dict[any]:
  """Sends an update request with the supplied data.
  Gets required fields from the data dict, which must have the same names like in the API.

  Args:
      data (dict): Expects {id, version, [changelog], compatible, updatefile}

  Raises:
      ValueError: Missing data

  Returns:
      dict[any]: Response from the API like {'status': <STATUSCODE>, 'response': <DATA>}
  """
  #endpoint_update = f"{API_BASE}/update" # TODO: Switch when workflow process is finalised
  endpoint_update = f"{API_BASE}/updatetest"

  print(f"Sending update request to: {endpoint_update}")
  if not data or not archivename: raise ValueError("got no body to send")

  # make sure the request is in the desired format
  form_data = {
    PROP_LIVE_ID: (None, data[PROP_LIVE_ID]),
    PROP_LIVE_VERSION: (None, data[PROP_LIVE_VERSION]),
    PROP_LIVE_CHANGELOG: (None, data[PROP_LIVE_CHANGELOG]),
    PROP_LIVE_COMPATIBLE: (None, data[PROP_LIVE_COMPATIBLE]),
    # application/zip fails, fallback to generic stream
    PROP_LIVE_UPDATEFILE: (archivename, data[PROP_LIVE_UPDATEFILE], 'application/octet-stream')
  }

  response = requests.post(endpoint_update, headers=HEADERS, files=form_data)
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
      return {'status': response.status_code}

  return {'status': response.status_code, 'response': response_json}


def get_compatible(apiversion: str) -> str:
  """Get compatible ESO patch versions from APIVersion

  Args:
      apiversion (str): like '101038' or '101037 101038'

  Returns:
      str: returns comma separated Patch versions like 8.0,8.1,8.2
  """
  endpoint = f"{API_BASE}/compatible.json"
  if not apiversion: raise ValueError('No APIVersion given, AddOn manifest might be broken!')

  print(f"Getting patch versions for {apiversion} from {endpoint}")

  try:
    response = requests.get(endpoint, headers=HEADERS)
    response.raise_for_status()
    response_json = response.json()

    # Take largest APIVersion if multiple like '101037 101038'
    max_compatibility = max(apiversion.split(' '))
    compatible_with = []

    for entry in response_json:
      if max_compatibility >= entry['interface']:
        compatible_with.append(entry['id'])
    return ','.join(compatible_with)

  except requests.exceptions.JSONDecodeError as ex:
    print(f"Could not process JSON response: {ex}")
  except requests.exceptions.RequestException as ex:
    print(f"Received error from server: {ex}")


if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='ESOUI API utility functions.')
  subparsers = parser.add_subparsers(dest='command')

  prs_get_info = subparsers.add_parser('info', help='Get info about the AddOn from ESOUI')
  prs_get_info.add_argument('--id', default=ADDON_ID, help='The AddOn ID')

  prs_get_liveversion = subparsers.add_parser('version', help='Get the current version on ESOUI')
  prs_get_liveversion.add_argument('--id', default=ADDON_ID, help='The AddOn ID')

  args = parser.parse_args()
  if args.command == 'info':
    print(get_addon_details(args.id))
  elif args.command == 'version':
    print(get_addon_version(args.id))
  else:
    parser.print_help()
