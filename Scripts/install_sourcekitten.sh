#!/bin/bash

# Taken from: https://alexplescan.com/posts/2016/03/03/setting-up-swiftlint-on-travis-ci/
# And adapted for sourcekitten

# Installs the SourceKitten package.
# Tries to get the precompiled .pkg file from Github, but if that
# fails just recompiles from source.

set -e

SOURCEKITTEN_PKG_PATH="/tmp/SourceKitten.pkg"
SOURCEKITTEN_PKG_URL="https://github.com/jpsim/SourceKitten/releases/download/0.17.3/SourceKitten.pkg"

wget --output-document=$SOURCEKITTEN_PKG_PATH $SOURCEKITTEN_PKG_URL

if [ -f $SOURCEKITTEN_PKG_PATH ]; then
  echo "SourceKitten package exists! Installing it..."
  sudo installer -pkg $SOURCEKITTEN_PKG_PATH -target /
else
  echo "SourceKitten package doesn't exist. Compiling from source..." &&
  git clone https://github.com/jspim/SourceKitten.git /tmp/SourceKitten &&
  cd /tmp/SourceKitten &&
  sudo make install
fi
