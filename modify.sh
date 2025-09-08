#!/usr/bin/env bash
set -euo pipefail
echo "Run started: $(date)" | tee output.txt
echo "Hello from Jenkins on commit: ${GIT_COMMIT:-unknown}" 
echo "Run finished: $(date)" | tee -a output
