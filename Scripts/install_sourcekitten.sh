#!/bin/bash

# Installs SourceKitten from source (Intended to be used with
# swift docker image)

set -e

git clone https://github.com/jpsim/SourceKitten.git /tmp/SourceKitten &&
cd /tmp/SourceKitten &&
make install
