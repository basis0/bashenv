APP_HOME=${PWD}/target/tomcat
APP_ENV=dev
APP_NAME=${PWD##*/}
APP_PORT_BASE=`cat ~/templates/ports.txt | grep ${PWD} | cut -d" " -f1`

APP_PORT_HTTP=${APP_PORT_BASE}
APP_PORT_HTTPS=$((${APP_PORT_BASE} + 3))
APP_PORT_SHUTDOWN=$((${APP_PORT_BASE} + 5))
APP_PORT_JMX=$((${APP_PORT_BASE} + 7))
APP_PORT_DEBUG=$((${APP_PORT_BASE} + 8))
APP_PORT_AJP=$((${APP_PORT_BASE} + 9))

if [ x"$DEBUG" != "x" ]; then
	export JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=${APP_PORT_DEBUG}"
fi

export JAVA_OPTS="$JAVA_OPTS -Dtomcat.port.http=${APP_PORT_HTTP} -Dtomcat.port.https=${APP_PORT_HTTPS} -Dtomcat.port.shutdown=${APP_PORT_SHUTDOWN} -Dtomcat.port.jmx=${APP_PORT_JMX} -Dtomcat.port.ajp=${APP_PORT_AJP}"