#!/bin/sh

SESSION="main"

tmux start-server

CLIENTS=$(tmux display-message -t $SESSION -p "#{session_attached}" 2>/dev/null)

if [ -z "$CLIENTS" ] || [ "$CLIENTS" -eq 0 ]; then
  tmux new-session -A -s $SESSION
else
  tmux new-session
fi
