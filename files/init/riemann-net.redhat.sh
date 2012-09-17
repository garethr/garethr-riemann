#! /bin/sh
#
# Start/Stop riemann net
#
# chkconfig: 345 99 99
# description: Riemann Network Statistics
# processname: riemann-net

riemann_bin="/usr/bin/riemann-net"
riemann_conf=""
riemann_log="/var/log/riemann/riemann-net.log"

find_riemann_process () {
    PIDTEMP=`ps ux | grep riemann-net | grep ruby | awk '{ print $2 }'`
    # Pid not found
    if [ "x$PIDTEMP" = "x" ]; then
        PID=-1
    else
        PID=$PIDTEMP
    fi
}

start () {
    LOG_DIR=`dirname ${riemann_log}`
    if [ ! -d $LOG_DIR ]; then
      echo "Log dir ${LOG_DIR} doesn't exist. Creating"
      mkdir $LOG_DIR
    fi
    nohup ${riemann_bin} ${riemann_conf} >  ${riemann_log} &
}

stop () {
    find_riemann_process
    if [ $PID -ne -1 ]; then
        kill $PID
    fi
}

case $1 in
start)
        start
        ;;
stop)
        stop
        exit 0
        ;;
reload)
        stop
        start
        ;;
restart)
        stop
        start
        ;;
status)
        find_riemann_process
    if [ $PID -gt 0 ]; then
        echo "Riemann net running"
            exit 0
        else
        echo "Riemann net not running"
            exit 1
    fi
        ;;
*)
        echo $"Usage: $0 {start|stop|restart|reload|status}"
        RETVAL=1
esac
exit 0
