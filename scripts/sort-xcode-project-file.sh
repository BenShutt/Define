#!/usr/bin/env bash

#
# Script: sort-xcode-project-file.sh
# Usage: ./sort-xcode-project-file.sh
#
# Sorts the Xcode .pbxproj file alphabetically.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Xcode project file
XCODE_PROJECT_FILE_NAME="Define.xcodeproj"

# Get directory of script
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

# Name of script to sort files
SORT_SCRIPT_NAME="reorder-xcode-project-file-alphabetically.pl"

# Path to project file
PROJECT_FILE_PATH="${SCRIPT_DIR}/../${XCODE_PROJECT_FILE_NAME}/project.pbxproj"

# Run the script
"${SCRIPT_DIR}/${SORT_SCRIPT_NAME}" "${PROJECT_FILE_PATH}"

