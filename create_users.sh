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

temp="12345678"

#Lista på användare.
for anvandare in "$@"; do
      
      #kollar om användare finns i listan
      
      echo "Skapar användare: $anvandare"

      #Skapar användare med hemkatalog.
      useradd -m -s /bin/bash "$anvandare"
      
  #Skapa mappar med Documents, Downloads och Work.
      mkdir -p /home/$anvandare/Documents
      mkdir -p /home/$anvandare/Downloads
      mkdir -p /home/$anvandare/Work

      #ägare får alla rättigheter till mapparna.
      chmod 700 /home/$anvandare/Documents
      chmod 700 /home/$anvandare/Downloads
      chmod 700 /home/$anvandare/Work

      #Ändrar så att användaren äger mapparna
      chown $anvandare:$anvandare /home/$anvandare/Documents
      chown $anvandare:$anvandare /home/$anvandare/Downloads
      chown $anvandare:$anvandare /home/$anvandare/Work

      #Skapa välkomstmeddelande med lista på användare
      echo "Välkommen $anvandare" > /home/$anvandare/welcome.txt
      echo "Andra användare: " >> /home/$anvandare/welcome.txt
      echo "$A_anvandare" >> /home/$anvandare/welcome.txt
      
      #ändrar så att användaren äger welcome.txt
      chown $anvandare:$anvandare /home/$anvandare/welcome.txt


      echo "Användaren är färdig"

done
