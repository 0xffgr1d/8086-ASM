#!/bin/bash

SESSION="8086-ASM"
SESSIONEXISTS=$(tmux list-session | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]
then

	tmux new-session -d -s $SESSION

	tmux rename-window -t 0 'Workspace'

	tmux send-keys -t 'Workspace' 'cd Prog' C-m 'vim .; exit' C-m
	tmux split-window -h
	tmux send-keys -t 'Workspace' 'source aliases' C-m 'cd Prog' C-m C-l 'ls' C-m

fi

tmux attach-session -t $SESSION:0
