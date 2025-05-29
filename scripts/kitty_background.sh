#!/usr/bin/env bash
opacity=$(kitten @ ls | jaq ".[].background_opacity")
if [[ "$opacity" == "1.0" ]]; then
  kitten @ set-background-opacity 0.5
else
  kitten @ set-background-opacity 1
fi
