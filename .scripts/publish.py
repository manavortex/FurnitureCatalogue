#!/usr/bin/env python3

import argparse

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

CL_LIVE_MAX_LINES = 10
CL_LIVE_HEADER_DELIM = '---'
CL_LIVE_HEADER_DEFAULT =f'''If you don't find change notes, it's because it's Luxury Furnisher. Booooring.

Speaking of boring: if you're really bored you can find the full changelog [URL="https://github.com/manavortex/FurnitureCatalogue/blob/master/{FU.CL_FILE}"]here[/URL] and all undocumented changes [URL="https://github.com/manavortex/FurnitureCatalogue/commits/master"]here[/URL].
'''

RELEASE_NOTE_DELIM = "[//]:"

def validate_versions(live:str, local:str, tag:str):
  """Aborts the script if something is wrong."""
  if tag and FU.compare_versions(local, tag) != 0:
    FU.crash_and_burn(f"Version mismatch! Release Tag:{tag}, Manifest:{local}")
  if FU.compare_versions(local, live) <= 0:
    FU.crash_and_burn(f"Version not increased! Our version:{local}, Online version:{live}")


def publish_to_esoui(optional_params: dict = {}):
  manifest = FU.get_manifest_data(ADDON_MANIFEST_FILE)
  archivename = f"{manifest[FU.PROP_MF_TITLE]}-{manifest[FU.PROP_MF_VERSION]}.zip"

  # Get AddOn details from API
  body = EU.get_addon_details(ADDON_ID)
  # generate compatibility list, because APIVersion might have been updated
  body[EU.PROP_LIVE_COMPATIBLE] = EU.get_compatible(manifest[FU.PROP_MF_APIVERSION])

  # Check versions before proceeding
  version = optional_params['tag'] or manifest[FU.PROP_MF_VERSION]
  validate_versions(body[EU.PROP_LIVE_VERSION], manifest[FU.PROP_MF_VERSION], version)
  # The new version seems fine, we can replace it in the request body
  body[EU.PROP_LIVE_VERSION] = version

  # Get content of zip file, abort if too smol
  try:
    archive_content = FU.file_to_binary_string( optional_params['archive_file'] or archivename )
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
  max_entries = params['changelog_max_notes'] or CL_LIVE_MAX_LINES
  new_kids_on_the_log.extend(FU.get_latest_log_entries(changelog_file, max_entries))
  body[EU.PROP_LIVE_CHANGELOG] = '\n'.join(new_kids_on_the_log)

  response = EU.send_update_request(body, archivename)
  print(f"Done, received status code: {response.get('status', '0')}")

  # todo-maybe: call a verify function (only if we have automated PR->Release cycles)
  #       we might want to crash here to alert maintainers that something went wrong
  #       for instance query add on infos after the update and verify they are the ones we sent
  #       compare zip file hashes or at least sizes


if __name__ == '__main__':
  parser = argparse.ArgumentParser(description='Publish a new release.')
  parser.add_argument('--version', help='Version like 1.234, used to compare with manifest')
  parser.add_argument('--notes-file', type=str, help='Release or PR notes file')
  parser.add_argument('--note-delimiter', default=f"{RELEASE_NOTE_DELIM}", help='Text before the delim is added to the ESOUI changelog.')
  parser.add_argument('--changelog-file', default='CHANGELOG', help='Path to the changelog file')
  parser.add_argument('--changelog-max-notes', default=10, help='Truncate the ESOUI changelog to the x latest notes')
  parser.add_argument('--archive-file', type=str, help='Path to the release archive file')

  params = {}
  args = parser.parse_args()
  params['version'] = args.version
  params['notes_file'] = args.notes_file
  params['note_delimiter'] = args.note_delimiter
  params['changelog_file'] = args.changelog_file
  params['changelog_max_notes'] = args.changelog_max_notes
  params['archive_file'] = args.archive_file

  try:
    publish_to_esoui(params)
  except Exception as ex:
    # Abort for safety reasons
    FU.crash_and_burn(f"Error: {ex}")
