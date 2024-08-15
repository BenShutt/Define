#!/usr/bin/env bash

#
# Script: sort-xcode-project.sh
# Usage: ./sort-xcode-project.sh
#
# Sorts the ".pbxproj" project file in the ".xcodeproj" 
# directory alphabetically.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# URL of the remote perl script on GitHub
REMOTE_URL="https://raw.githubusercontent.com/WebKit/webkit/main/Tools/Scripts/sort-Xcode-project-file"

# Get directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Path to ".pbxproj" project file in the ".xcodeproj" directory
PROJECT_FILE="${SCRIPT_DIR}/../Define.xcodeproj/project.pbxproj"

# Perl script to sort the file alphabetically
PERL_SCRIPT="${SCRIPT_DIR}/alphabetically-sort-xcode-project.pl"

# Update the local file
curl -fsS -o "${PERL_SCRIPT}" "${REMOTE_URL}"

# Run the script
perl "${PERL_SCRIPT}" "${PROJECT_FILE}"