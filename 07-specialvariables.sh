#!/bin/bash

echo "print the arguments passed to the script :: $@"
echo "print tha aruments passed to the script as one single word :: $*"
echo "Number of arguments passed :: $#"
echo "first argument passed :: $1"
echo "script name :: $0"
echo "Real path of this script :: $(realpath $0)"
echo "Directory of the current script :: $PWD"
echo "Current user running the script :: $USER"
echo "Home directory of the current user :: $HOME"
echo  "PID of the currrent script runnning :: $$"
sleep 10 &
echo "PID of the command running in the background now :: $!"
wait $!
echo "Line number $LINENO"
echo "Previous command exit status :: $?"
echo "Total time executed for this script :: $SECONDS"
