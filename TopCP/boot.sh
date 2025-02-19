#!/bin/bash
source /release_setup.sh
source /TopCPToolkit/build/x86_64-el9-gcc13-opt/setup.sh
unset PYTHONHOME

echo "Arguments received: $@"
exec "$@"