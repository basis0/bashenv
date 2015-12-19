#!/usr/bin/env bash

source `dirname ${BASH_SOURCE[0]}`/include/shared.sh

echo $((${APP_PORT_BASE} + 8))