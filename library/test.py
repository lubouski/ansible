#!/usr/bin/python


import vagrant

parameter = {}

v = vagrant.Vagrant(root='/home/student/cm/ansible/day-3')
result = (v.ssh_config()).split('\n\n')
for i in range(len(result)-1):
    name1 = ((result[i].split('\n')[0]).split(' '))[1]
    #print name1
    
    parameter.update(host=name1)    

print result
#print parameter
