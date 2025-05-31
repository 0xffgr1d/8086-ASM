#!/bin/bash
PROJECT_PATH=$1
EMULATED_PATH=$2
FILENAME=$3
shift
shift
shift
ARGUMENTS=$@
cd "$PROJECT_PATH"
dosbox-x --noautoexec -c "mount C ./Tasm" -c "PATH=%PATH%;C:\\" -c "mount D ./Prog" -c "D:" -c "cd $EMULATED_PATH" -c "tasm $FILENAME" -c "tlink $FILENAME" -c "$FILENAME $ARGUMENTS"
