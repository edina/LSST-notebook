#! /bin/bash

set -e

source scl_source enable devtoolset-6 && source /home/docmaf/stack/loadLSST.bash && setup sims_maf -t sims

exec "$@"

