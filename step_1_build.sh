#!/bin/bash

# Below you must perform the building of all
# the run frameworks that you make use of.
#
# This should only be running build and run scripts.
# External dependencies (e.g., from the Internet) should
# have already been retrieved in the setup_env.sh call.

# Max-min fair allocation (mmfa)
cd frameworks/mmfa || exit 1
python3 test_mmfa.py || exit 1
cd ../.. || exit 1
