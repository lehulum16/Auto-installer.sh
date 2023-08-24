#!/bin/bash

# Check if the user has sudo privileges
if [ ! -z "$(sudo -n true)" ]; then
  echo "You do not have sudo privileges."
  exit 1
fi

# Get the name of the Linux distribution
echo "What Linux distribution are you using?"
read distribution

# Get the list of tools to install
echo "What tools do you want to install?"
read tools

# Install the tools
for tool in ${tools}; do
  case "${distribution}" in
    debian|ubuntu)
      sudo apt-get install -y ${tool}
      ;;
    centos|fedora)
      sudo yum install -y ${tool}
      ;;
    alpine)
      sudo apk add ${tool}
      ;;
    *)
      echo "The ${distribution} distribution is not supported."
      exit 1
      ;;
  esac
done

# Verify that the tools are installed
for tool in ${tools}; do
  if ! command -v ${tool} >/dev/null; then
    echo "The ${tool} tool is not installed."
    exit 1
  fi
done

echo "All tools are installed."

