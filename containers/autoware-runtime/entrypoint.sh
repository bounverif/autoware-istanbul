#!/bin/bash
# Trigger an error if non-zero exit code is encountered
set -e

# Source Autoware environment
source /opt/autoware/humble/setup.bash

# Execute the command
exec ros2 launch "${@}"
