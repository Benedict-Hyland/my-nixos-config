#!/usr/bin/env bash

set -e

# Go to data tab
pushd ~/Documents/data

# Create a directory for today if it doesn't exist
today=$(date)
mkdir -p $today + "%Y-%m-%d"

base_loc="https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs/($today + '%Y%m%d')/00/atmos/"


