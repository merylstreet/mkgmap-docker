#!/bin/bash
set -x

echo "Updating sea file..."
(cd sea && ./sea.sh)

echo "Updating dem1 files..."
(cd dem/dem1 && ./dem1.sh)

echo "Updating dem3 files..."
(cd dem/dem3 && ./dem3.sh)