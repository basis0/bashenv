#!/usr/bin/env bash

source `dirname ${BASH_SOURCE[0]}`/include/shared.sh

copyFromHome()
{
	if [ -f $TEMPLATES/$1 ]; then
		echo "Found override $1 in $TEMPLATES"
		cp $TEMPLATES/$1 $CATALINA_BASE/$1
	elif [ -f $TEMPLATES_DEFAULT/$1 ]; then
		echo "Found default override $1 in $TEMPLATES_DEFAULT"
		cp $TEMPLATES_DEFAULT/$1 $CATALINA_BASE/$1
	elif [ -f $CATALINA_HOME/$1 ]; then
		cp $CATALINA_HOME/$1 $CATALINA_BASE/$1
	fi
}

initialize_base()
{
	if [ ! -d $CATALINA_BASE/bin ]; then
		echo "Initializing $CATALINA_BASE"
		mkdir -p $CATALINA_BASE/{bin,conf,logs,temp,webapps,work}
		copyFromHome bin/setenv.sh
		copyFromHome conf/server.xml
		copyFromHome conf/web.xml
	fi
}

startup()
{
	if [ -f $CATALINA_BASE/webapps/ROOT.war ]; then
		$CATALINA_HOME/bin/startup.sh
	fi
}

if [ $APP_HAVE_PORT -ne 1 ]; then
	echo "No port found, exiting"
	exit
fi

export READY=`ls -c1 target/*.war 2>/dev/null | wc -l`

if [ $READY -eq 1 ]; then
	echo "Deploying to target"
	initialize_base
	cp target/*.war $CATALINA_BASE/webapps/ROOT.war
	startup
else
	echo "No target built, exiting"
	exit
fi

