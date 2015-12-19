#!/usr/bin/env bash

source `dirname ${BASH_SOURCE[0]}`/include/shared.sh

open "http://${MACHINE_LOCAL_NAME}:${APP_PORT_BASE}/"