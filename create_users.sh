#!/bin/bash

#Kontrollerar ifall man är root.
if [ "$EUID" -ne 0 ]; then
      echo "Du måste vara root för att kunna köra scriptet"
      exit 1
fi

#Lista på användare.
for anvandare in "$@"
do
      #Skapar användare med hemkatalog.
      echo "Skapar användare: $anvandare"
      useradd -m "$anvandare"

      #Skapa mappar med Documents, Downloads och Work.
      mkdir /home/$anvandare/Documents
      mkdir /home/$anvandare/Downloads
      mkdir /home/$anvandare/Work

      #ägare får alla rättigheter till mapparna.
      chmod 700 /home/$anvandare/Documents
      chmod 700 /home/$anvandare/Downloads
      chmod 700 /home/$anvandare/Work

      #Skapa välkomstmeddelande med lista på användare
      echo "Välkommen $anvandare" > /home/$anvandare/welcome.txt
      echo "Andra användare: " >> /home/$anvandare/welcome.txt
      echo "$@" >> /home/$anvandare/welcome.txt
      
done

echo "Användaren är färdig"
