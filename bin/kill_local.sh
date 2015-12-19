#!/usr/bin/env bash

source `dirname ${BASH_SOURCE[0]}`/include/shared.sh

kill `cat ${CATALINA_PID}`