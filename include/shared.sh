pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

absPathToScript()
{
	pushd . > /dev/null
	SCRIPT_PATH="${BASH_SOURCE[0]}";
	while([ -h "${SCRIPT_PATH}" ]); do
	    cd "`dirname "${SCRIPT_PATH}"`"
	    SCRIPT_PATH="$(readlink "`basename "${SCRIPT_PATH}"`")";
	done
	cd "`dirname "${SCRIPT_PATH}"`" > /dev/null
	SCRIPT_PATH="`pwd`";
	popd  > /dev/null
	echo ${SCRIPT_PATH}
}

export BASE=`absPathToScript`
export ETC_BASE=${BASE}/../etc/
export ETC_DEFAULT=${ETC_BASE}/default
export ETC=${ETC_BASE}/$(pwd)

if [ -f "$BASE/setenv.local.sh" ]; then
	echo "Loading from setenv.local.sh"
	source "$BASE/setenv.local.sh"
	echo
fi

notify_vars()
{
	echo "Using JAVA_HOME=$JAVA_HOME"
	echo "Using CATALINA_HOME=$CATALINA_HOME"
	echo "Using CATALINA_BASE=$CATALINA_BASE"
	if [ ! -z "$CATALINA_PID" ]; then
		echo "Using CATALINA_PID=$CATALINA_PID"
	fi
}

check_vars()
{
	if [ ! -f $JAVA_HOME/bin/java ]; then
		echo "Invalid JAVA_HOME=$JAVA_HOME"
		exit
	fi
	if [ ! -f $CATALINA_HOME/bin/startup.sh ]; then
		echo "Invalid CATALINA_HOME=$CATALINA_HOME"
		exit
	fi
}

export APP_HAVE_PORT=`cat ${ETC_BASE}/ports.txt | grep ${PWD} | wc -l`
export APP_PORT_BASE=`cat ${ETC_BASE}/ports.txt | grep ${PWD} | cut -d" " -f1`
export CATALINA_PID=$(pwd)/target/tomcat/catalina.pid
export CATALINA_BASE=$(pwd)/target/tomcat
check_vars
echo

