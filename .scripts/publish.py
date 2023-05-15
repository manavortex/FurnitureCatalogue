#!/usr/bin/env python3

import argparse
import json

import furc_utils as FU
import esoui_utils as EU

"""Perform all steps required for Publishing.
    - get AddOn data from manifest
    - get AddOn data from API
    - prepare request body
    - save GitHub release note to CHANGELOG
    - get truncated version of CHANGELOG
"""

ADDON_ID = 1617
ADDON_MANIFEST_FILE = 'FurnitureCatalogue.txt'

ARCHIVE_MIN_SIZE_IN_BYTES = 1024
"""Minimum size in bytes the archive needs for a release
  For orientation a test with max zip compression:
    - no database
    - no textures
    - no embedded AddOns (Devtools, Exporter)
    - most lua files missing
    - added only:
        1. FurnitureCatalogue.txt
        2. Main xml files
        3. all locale files
        4. startup.lua, FurCEvents.lua, FurCUtil.lua

  `Result: 40960 bytes`
"""

CL_LIVE_MAX_ENTRIES = 15
CL_LIVE_HEADER_DELIM = '---'
CL_LIVE_HEADER_DEFAULT =f'''If you don't find change notes, it's because it's Luxury Furnisher. Booooring.

Speaking of boring: if you're really bored you can find the full changelog [URL="https://github.com/manavortex/FurnitureCatalogue/blob/master/{FU.CL_FILE}"]here[/URL] and all undocumented changes [URL="https://github.com/manavortex/FurnitureCatalogue/commits/master"]here[/URL].
'''

RELEASE_NOTE_DELIM = "[//]:"

def publish_to_esoui(optional_params: dict = {}):
  manifest = FU.get_manifest_data(ADDON_MANIFEST_FILE)

  # Get AddOn details from API
  body = EU.get_addon_details(ADDON_ID)
  # generate compatibility list, because APIVersion might have been updated
  body[EU.PROP_LIVE_COMPATIBLE] = EU.get_compatible(manifest[FU.PROP_MF_APIVERSION])

  # Check versions before proceeding
  new_version = manifest[FU.PROP_MF_VERSION]
  current_version = body[EU.PROP_LIVE_VERSION]
  if FU.compare_versions(new_version, current_version) < 1:
    FU.crash_and_burn(f"Not an update, our new version ({new_version}) is not higher than on ESOUI (${current_version})")
  # The new version seems fine, we can replace it in the request body
  body[EU.PROP_LIVE_VERSION] = FU.to_semver(new_version)

  # Get content of zip file, abort if too smol
  try:
    archivename = f"{manifest[FU.PROP_MF_TITLE]}-{manifest[FU.PROP_MF_VERSION]}.zip"
    archive_content = FU.file_to_binary_string(optional_params['archive_file'] or archivename)
  except Exception:
    FU.crash_and_burn('no zip, no live')

  if len(archive_content) < ARCHIVE_MIN_SIZE_IN_BYTES:
    FU.crash_and_burn(f"Zip archive is too small ({len(archive_content)}B), something must be wrong or compression algorithms have gotten way better")
  body[EU.PROP_LIVE_UPDATEFILE] = archive_content

  # ESOUI: Extract and save changelog comment
  esoui_cl_comment = FU.extract_header(body[EU.PROP_LIVE_CHANGELOG], CL_LIVE_HEADER_DELIM)
  if esoui_cl_comment:
    esoui_cl_comment = f"{esoui_cl_comment}\n{CL_LIVE_HEADER_DELIM}\n"
  else:
    esoui_cl_comment = CL_LIVE_HEADER_DEFAULT
  new_kids_on_the_log = [esoui_cl_comment]

  # Pick latest x changes to show in the ESOUI CL
  changelog_file = optional_params['changelog_file'] or FU.CL_FILE
  max_entries = params['changelog_max_entries'] or CL_LIVE_MAX_ENTRIES
  new_kids_on_the_log.extend(FU.get_log_entries(changelog_file, max_entries))
  body[EU.PROP_LIVE_CHANGELOG] = '\n'.join(new_kids_on_the_log)

  response = EU.send_update_request(body, archivename)
  print(f"Done, received status code: {response.get('status', '0')}")
  if optional_params['print_response']:
    print(json.dumps(response, indent=2))

  # todo-maybe: (only for fully automated PR->Release cycles)
  #      - verify that the changes are live (add optional --verify flag to this script)
  #      - crash here to alert maintainers if something went wrong
  #      - compare zip file hashes or at least sizes


if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Publish a new release.')
  parser.add_argument('--changelog-file', help='Path to the changelog file')
  parser.add_argument('--changelog-max-entries', type=int, help='Send only the latest X entries to the ESOUI changelog')
  parser.add_argument('--archive-file', help='Path to the release archive file')
  parser.add_argument('--print-response', action='store_true', default=False,  help='Prints the full ESOUI response to the terminal')

  params = {}
  args = parser.parse_args()
  params['changelog_file'] = args.changelog_file
  params['changelog_max_entries'] = args.changelog_max_entries
  params['archive_file'] = args.archive_file
  params['print_response'] = args.print_response

  try:
    publish_to_esoui(params)
  except Exception as ex:
    # Abort for safety reasons
    FU.crash_and_burn(f"Error: {ex}")
