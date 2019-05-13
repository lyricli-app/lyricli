#!/bin/bash

# Installs SwiftLint from source (Intended to be used with
# swift docker image)

set -e

git clone https://github.com/realm/SwiftLint.git /tmp/SwiftLint &&
cd /tmp/SwiftLint &&
git submodule update --init --recursive &&
make install
