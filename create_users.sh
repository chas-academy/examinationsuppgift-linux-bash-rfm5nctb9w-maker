#!/bin/bash

#Kontrollerar ifall man är root.
if [ "$EUID" -ne 0 ]; then
      echo "Du måste vara root för att kunna köra scriptet"
      exit 1
fi

#lista på alla användare som skickas in
A_anvandare=("$@")

#Lista på användare.
for anvandare in "$@"; do
      
      #kollar om användare finns i listan
      if id "$anvandare" &>/dev/null; then
            echo "Användaren finns redan"
            continue
      fi

      #Skapar användare med hemkatalog.
      echo "Skapar användare: $anvandare"
      useradd -m -s /bin/bash "$anvandare"
      
  #Skapa mappar med Documents, Downloads och Work.
      mkdir /home/$anvandare/Documents
      mkdir /home/$anvandare/Downloads
      mkdir /home/$anvandare/Work

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
      for user in "${A_anvandare[@]}"; do
            echo "$user" >> /home/$anvandare/welcome.txt
      done
      
      #ändrar så att användaren äger welcome.txt
      chown $anvandare:$anvandare /home/$anvandare/welcome.txt

      mkdir /home/$anvandare/.ssh
      chmod 700 /home/$anvandare/.ssh
      cat /home/chas/.ssh/id_ed25519.pub > /home/$anvandare/.ssh/authorized_keys
      chmod 600 /home/$anvandare/.ssh/authorized_keys
      chown -R $anvandare:$anvandare /home/$anvandare/.ssh

done

echo "Användarna är färdiga"

