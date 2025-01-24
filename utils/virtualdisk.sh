#!/bin/bash

# Set default values
path="/mnt"
storage=10

# Process command-line arguments
while getopts "p:s:" opt; do
  case $opt in
    p)
      path="$OPTARG"
      ;;
    s)
      storage="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 [-p <path>] [-s <storage_size_TB>]" >&2
      exit 1
      ;;
  esac
done

# Convert storage to MB
storage_mb=$((storage * 1000000))

# Display the parameters
echo "Path: $path"
echo "Storage: $storage TB ($storage_mb MB)"

# Create the directory
sudo mkdir -p "$path"

# Check if the image file exists, if not, create it
if [ ! -f "$path/virtualdisk.img" ]; then
    echo "Creating virtual disk image with ${storage}TB..."
    sudo dd if=/dev/zero of="$path/virtualdisk.img" bs=1M count=0 seek="$storage_mb"
else
    echo "Image file already exists."
fi

# Check if the filesystem has been created on the image file
if ! sudo file -s "$path/virtualdisk.img" | grep -q ext4; then
    echo "Creating ext4 filesystem on the image file..."
    sudo mkfs.ext4 "$path/virtualdisk.img"
else
    echo "Filesystem already created."
fi

# Mount the image file to the directory
if ! mount | grep -q "$path"; then
    echo "Mounting the image file to $path..."
    sudo mount -o loop "$path/virtualdisk.img" "$path"
else
    echo "$path is already mounted."
fi
# Check and add the entry to /etc/fstab if it does not exist
if ! grep -q "$path/virtualdisk.img" /etc/fstab; then
    echo "Adding automatic mount configuration to /etc/fstab..."
    echo "$path/virtualdisk.img $path ext4 loop 0 0" | sudo tee -a /etc/fstab > /dev/null
else
    echo "fstab entry already exists."
fi

echo "Finished!"
