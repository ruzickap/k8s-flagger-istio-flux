#!/bin/bash -eu

sed -n '/^```bash.*/,/^```$/p' docs/part-06/README.md | sed '/^```*/d' | sh -x
