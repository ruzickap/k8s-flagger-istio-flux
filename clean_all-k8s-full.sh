#!/bin/bash -eu

# export LETSENCRYPT_ENVIRONMENT="production"
sed -n '/^```bash.*/,/^```$/p' docs/part-06/README.md | sed '/^```*/d' | sh -x
