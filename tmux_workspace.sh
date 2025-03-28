#!/bin/sh

SESSION="8086-ASM"

if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux new-session -d -s "$SESSION" -n "Workspace"
  tmux send-keys -t "$SESSION:Workspace" "cd Prog && vim .; exit" C-m
  tmux split-window -h -t "$SESSION:Workspace"
  tmux send-keys -t "$SESSION:Workspace" "source aliases && cd Prog && clear && ls" C-m
fi
exec tmux attach-session -t "$SESSION"
