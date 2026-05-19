#!/bin/bash

#Kontrollerar ifall man är root.
if [ "$EUID" -ne 0 ]; then
      echo "Du måste vara root för att kunna köra scriptet"
      exit 1
fi

#kollar ifall ett namn skickas in
if [ -z "$1" ]; then
      echo "Du har glömt lägga till ett namn."
      exit 1
fi

#Lista på användare.
for anvandare in "$@"; do
      
      #kollar om användare finns i listan
      
      echo "Skapar användare: $anvandare"

      #Skapar användare med hemkatalog.
      useradd -m -s /bin/bash "$anvandare"

done
