# OCS Inventory Agent — Automated Installer

Bash script that automates installing the OCS Inventory Unix Agent on Ubuntu machines, including answering the installer's interactive prompts via `expect`. Without it, installation means manually answering six prompts from `perl Makefile.PL` on every single machine.

## Why

Installing the OCS Inventory agent by hand across multiple machines is repetitive and error-prone — the upstream installer only ships as an interactive CLI. This script wraps the whole process: dependencies, download, `expect`-driven configuration, and compilation, so it can run unattended.

## Prerequisites

- Ubuntu 22.04 (tested on this version)
- A running OCS Inventory server reachable over the network
- Root/sudo access on the target machine

## Usage

1. Edit the OCS server URL inside `install-ocs-agent.sh` before running (look for `http://your.ocs.server/ocsinventory`)
2. Make it executable: `chmod +x install-ocs-agent.sh`
3. Run it: `./install-ocs-agent.sh`

## What it does

1. Updates system packages
2. Installs `expect` and generates `expect.exp`, which auto-answers the OCS installer's prompts
3. Installs the Perl/system dependencies required to compile the agent
4. Downloads Unix Agent v2.10.2 from the official OCS Inventory repository
5. Compiles and installs the agent

## Note

The server URL is hardcoded in the script, not a command-line argument — edit it before running in production.
