#!/usr/bin/env bash

# I sincerely apologize for the imperative commands.
# Please do not confiscate my nix-chan.
# Seriously, though, if I find 1-2 more instances of these imperative secrets...
# maybe i'll use sops...maybe...

# Generate SSH key
EMAIL=$(git config user.email)
yes "" | ssh-keygen -N '' -t ed25519 -C "${EMAIL}"

# Show key
echo "Copy the following public key and add it to your GitHub account:"
cat ~/.ssh/id_ed25519.pub

# Show where to find the key
echo "Alternatively, run \`cat ~/.ssh/id_ed25519.pub\`"

