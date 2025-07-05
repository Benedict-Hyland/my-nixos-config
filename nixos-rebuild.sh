#!/usr/bin/env bash

# Fail script on error
set -e

# Go to configuration directory
pushd ~/System

# Only continue if any tracked .nix file has changed
if git diff --quiet -- '**/*.nix'; then
  echo "No .nix changes detected, exiting."
  popd
  exit 0
fi

# Format all .nix files recursively (alejandra handles directories)
if ! alejandra .; then
  echo "Formatting failed!"
  popd
  exit 1
fi

# Show .nix diffs (minimized diff for clarity)
git diff -U0 -- '*.nix'

echo "NixOS Rebuilding..."

# Rebuild and capture output
if ! sudo nixos-rebuild switch &> nixos-switch.log; then
  grep --color error nixos-switch.log || cat nixos-switch.log
  echo "❌ nixos-rebuild failed"
  popd
  exit 1
fi

# Commit if there are changes after formatting and rebuilding
if ! git diff --quiet; then
  current=$(nixos-rebuild list-generations | grep current)
  git commit -am "$current"
fi

# Return to previous directory
popd

# Notify success
notify-send -e "✅ NixOS Rebuilt OK!" --icon=software-update-available
