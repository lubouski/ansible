#!/bin/bash

source $1
#static = ${state:-deployed}
if [ -z "$war" ]; then
    printf '{"failed": true, "msg": "missing required arguments: war"}'    
    exit 1 
fi

if [ -z "$username" ]; then
    printf '{"failed": true, "msg": "missing required arguments: username"}'    
    exit 1 
fi

if [ -z "$password" ]; then
    printf '{"failed": true, "msg": "missing required arguments: password"}'    
    exit 1 
fi


sudo cd vagrant; tar -zxvf pipeline-alubouski.tar.gz
sudo echo "Deployment time: $(date)" > /var/lib/tomcat/webapps/deploy-info.txt
sudo echo "Deploy user: Lubouski" >> /var/lib/tomcat/webapps/deploy-info.txt
sudo echo "Deployment Job: Deploy Artefact" >> /var/lib/tomcat/webapps/deploy-info.txt

sudo curl --upload-file $war "http://127.0.0.1:8080/manager/text/deploy?path=/mnt-lab" --user $username:$password
printf '{"changed": true, "msg": "deployed app"}'
#sudo curl --upload-file /home/student/cm/ansible/day-4/target/mnt-lab.war http://192.168.56.10:8080/manager/text/deploy?path=/mnt-lab --user admin:password

exit 0
