#!/usr/bin/env python3

import os
import shutil
import zipfile
import argparse
import fnmatch

'''WIP, more or less copy pasted and converted from batch file, untested, don't use yet'''

def find_manifests(directory):
    manifests = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".txt"):
                manifests.append(os.path.join(root, file))
    return manifests

def parse_manifest(manifest):
    files = []
    with open(manifest, 'r') as file:
        lines = file.readlines()
        for line in lines:
            if not line.startswith("#") and not line.startswith(";"):
                files.append(line.strip())
    return files

def package_addon(name, version, target_directory=None, delete_custom_filename=None):
    archive = f"{name}-{version}.zip"
    print(f"* Packaging {archive}...")
    basefolder = f".package/{name}"
    os.makedirs(basefolder, exist_ok=True)

    # parse and copy all files mentioned in detected AddOn manifests
    for manifest in find_manifests('.'):
        print(f"Manifest detected: {manifest}")

        # get directory relative to manifest
        filepath = os.path.dirname(manifest)

        # parse file names in current AddOn manifest
        for file in parse_manifest(manifest):
            file = file.replace('$(language)', '*')

            # copy parsed file to the package
            src = os.path.join(filepath, file)
            for match in fnmatch.filter(os.listdir(filepath), file):
                shutil.copy(os.path.join(filepath, match), os.path.join(basefolder, match))

    # copy additional files (assets etc.) from package.manifest
    if os.path.exists('package.manifest'):
        print('package.manifest detected')
        with open('package.manifest', 'r') as file:
            files = file.readlines()
            for file in files:
                file = file.strip()
                shutil.copy(file, os.path.join(basefolder, file))

    # zip it
    with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(basefolder):
            for file in files:
                if file != delete_custom_filename:
                    zipf.write(os.path.join(root, file))

    # clean up
    shutil.rmtree(basefolder)

    # move zip to target directory
    if target_directory is not None:
        print(f"* Moving {archive} to {target_directory}...")
        shutil.move(archive, os.path.join(target_directory, archive))

    print("* Done^^!\n")

if __name__ == '__main__':
    # kwargs for ease of use
    parser = argparse.ArgumentParser(description="Package your ESO add-on ready for distribution.")
    parser.add_argument('--name', required=True, help='Name of your add-on')
    parser.add_argument('--version', required=True, help='Version of your add-on')
    parser.add_argument('--target_directory', default=None, help='Target directory to move the zip file')
    parser.add_argument('--delete_custom_filename', default=None, help='Custom filename to be deleted')
    args = parser.parse_args()

    package_addon(args.name, args.version, args.target_directory, args.delete_custom_filename)
