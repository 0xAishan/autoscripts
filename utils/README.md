# `virtualdisk.sh` Usage Guide

The `virtualdisk.sh` script is a command-line tool for creating and managing virtual disks on Linux systems. It allows you to create a virtual disk with a custom size and mount it to a specified directory. The script also automatically adds the mount configuration to `/etc/fstab` so that the virtual disk is automatically mounted upon system reboot.

**Script Link:** [https://raw.githubusercontent.com/0xAishan/autoscripts/refs/heads/main/utils/virtualdisk.sh](https://raw.githubusercontent.com/0xAishan/autoscripts/refs/heads/main/utils/virtualdisk.sh)

## Requirements

*   Linux operating system
*   `sudo` privileges to execute the script
*   `wget` or `curl` to download the script

## Quick Start

**Download and run the script in one command:**

```bash
wget -qO- https://raw.githubusercontent.com/0xAishan/autoscripts/refs/heads/main/utils/virtualdisk.sh | sudo bash -s -- -p /mnt -s 8
```
** or using curl**
```bash
curl -s https://raw.githubusercontent.com/0xAishan/autoscripts/refs/heads/main/utils/virtualdisk.sh | sudo bash -s -- -p /mnt -s 8
```
If you don't provide the -p or -s arguments, the script uses default values:
Path: `/mnt`
Storage size: `10TB`
