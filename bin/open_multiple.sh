#!/usr/bin/env bash

source `dirname ${BASH_SOURCE[0]}`/include/shared.sh

usage() {
	echo "$0 <url>"
	echo "	url		url to open"
}

if [ x"$1" == "x" ]; then
	usage
	exit
fi

url=$1

open $url && open $url && open $url && open $url && open $url