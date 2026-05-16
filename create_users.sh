#!/bin/bash

#kontrollerar ifall man är root.
if [ "$EUID" -ne 0 ]; then
      echo "Du måste vara root för att använda scriptet"
fi
