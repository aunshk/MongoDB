#!/bin/bash
# shell script to setup mongodb 3.6.9  setup in ubuntu

if [ -f /usr/bin/mongod ]
then
        echo "MongoDB is installed on your machine."
        mongo_version=$(mongo --version)
        echo "$mongo_version"
else
      
          echo "------------  checking for dependencies------------"
             
             libssl_pkg=libssl1.0.0
             chk_libssl=$(sudo apt list libssl1.0.0 | grep libssl1.0.0  | cut -d "/" -f 1)

               if [[ "$libssl_pkg" == "$chk_libssl" ]]
               then
                    echo "libssl1.0.0 is installed"
               else
                     
                     echo "deb http://security.ubuntu.com/ubuntu xenial-security main" | sudo tee -a /etc/apt/sources.list
                     sudo apt update -y
                     sudo apt install libssl1.0.0
               fi



           echo "----------  importing the MongoDB Public GPG key -----------"

           curl -fsSL https://www.mongodb.org/static/pgp/server-3.6.asc | sudo apt-key add -

           echo "--------- adding repository for mongoDB server 3.6.9 -----------"

           echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

           echo "---------- updating server’s local package index --------------"

           sudo apt update -y

           echo "----------- installing MongoDB packages --------------"

                sudo apt install mongodb-org-server=3.6.9 -y
                sudo apt install mongodb-org-shell=3.6.9 -y 
                sudo apt install mongodb-org-mongos=3.6.9 -y
                sudo apt install mongodb-org-tools=3.6.9 -y

         
               echo "--------- start/enable the updated systemd service for your MongoDB instance -------------"

                sudo systemctl start mongod
                sudo systemctl enable mongod
                echo
                echo "---------------------- mongodb installation completed ------------------------ "

fi
  echo
  echo "-----Completed--------"
