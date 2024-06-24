#!/usr/bin/env bash

#
# Script: generate-images.sh
# Usage: ./generate-images.sh
# Build and run the Swift Package Executable.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# Get directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Move into Swift Package
cd "${SCRIPT_DIR}/../AppIcon"

# Build the Swift Package
echo "Building Swift Package Executable..."
swift build --configuration release

# Move into build directory
cd .build/release/

# Run the Executable
./AppIconGenerator --directory "~/Desktop/DefineImages"