#!/usr/bin/env bash

#
# Script:
# clean.sh
#
# Usage: 
# ./clean.sh
#
# Description:
# Removes the following files:
# - Build directory of AppIcon package
# - SwiftPM caches
# - Xcode derived data
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Remove Swift package build directory
rm -rf "${SCRIPT_DIR}/../AppIcon/.build"

# Remove SPM cache
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/org.swift.swiftpm

# Remove Xcode DerivedData
rm -rf "${HOME}/Library/Developer/Xcode/DerivedData"
