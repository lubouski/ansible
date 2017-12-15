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

#sudo mkdir -p /var/lib/tomcat/webapps
#cd ~; touch deploy-info.txt; echo "Time: $(date)" "Deploy: Lubouski" >> deploy-info.txt; sudo cp ~/deploy-info.txt /var/lib/tomcat/webapps/deploy-info.txt

sudo echo "Deployment time: $(date)" > /var/lib/tomcat/webapps/deploy-info.txt
sudo echo "Deploy user: Lubouski" >> /var/lib/tomcat/webapps/deploy-info.txt

sudo curl --upload-file $war "http://192.168.56.10:8080/manager/text/deploy?path=/mnt-lab" --user $username:$password
printf '{"changed": true, "msg": "deployed app"}'
#sudo curl --upload-file /home/student/cm/ansible/day-4/target/mnt-lab.war http://192.168.56.10:8080/manager/text/deploy?path=/mnt-lab --user admin:password
#cd /var/lib/tomcat/webapps/
#sudo touch deploy-info.txt
sudo touch /var/lib/tomcat/webapps/deploy-info.txt
sudo chmod 777 /var/lib/tomcat/webapps/deploy-info.txt

exit 0
