#!/usr/bin/env bash

#
# Script: 
# generate-images.sh
#
# Usage: 
# ./generate-images.sh
#
# Description:
# Build and run the AppIconGenerator swift package executable.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Get directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Directory of the swift package
PACKAGE_DIR="${SCRIPT_DIR}/../AppIcon"

# Run the Executable
swift run \
    --configuration release \
    --package-path "${PACKAGE_DIR}" \
    AppIconGenerator --directory "~/Desktop/DefineImages"

