#!/bin/bash

set -e

# Create temporary build directory
mkdir /tmp/build
cd /tmp/build

# Find the latest font version if the font version environment variable is not
# set. The `-n` operator checks if the length of the string is nonzero.
if [ ! -n "$FONT_VERSION" ]; then
    FONT_VERSION=$(curl -s https://github.com/be5invis/Iosevka/releases/latest \
        | grep -Po '(?<=tag/v)[0-9.]*')
fi

echo "Downloading and checking the validity of the source code..."

# Download source code
if [ "$FONT_VERSION" == "dev" ]; then
    curl -sSLo vdev.tar.gz --proto '=https' --tlsv1.2 https://github.com/be5invis/Iosevka/tarball/dev
else
    curl -sSLO --proto '=https' --tlsv1.2 https://github.com/be5invis/Iosevka/archive/v${FONT_VERSION}.tar.gz
fi

#  Check for valid downloaded file (build can fail here with exit code 1)
file "v${FONT_VERSION}.tar.gz" | grep 'gzip compressed data' > /dev/null

# Extract downloaded source code
tar -xf v${FONT_VERSION}.tar.gz
cd *Iosevka-*

# Copy the build plan
cp /build/private-build-plans.toml .

# Build!
echo "Commencing build of version ${FONT_VERSION}..."
npm install

if [ $# -eq 0 ]; then
    # Get the name of the first build plan when the user does not provide
    # custom build arguments (automatic mode)
    PLAN_NAME=$(grep -Po -m 1 '(?<=buildPlans.)[^\]]*' private-build-plans.toml)

    npm run build -- contents::$PLAN_NAME
else
    # User knows what they are doing and provides custom build arguments
    # (manual mode)
    npm run build -- "$@"
fi

# Copy the dist folder back to the mounted volume
cp -r dist /build/
