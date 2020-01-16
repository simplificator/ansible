#!/bin/bash

# SOURCE: https://gist.github.com/oneohthree/f528c7ae1e701ad990e6
echo "$1" | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z
