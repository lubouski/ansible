#!/usr/bin/python

from ansible.module_utils.basic import *
import subprocess
import vagrant

parameter = {}

def main():

    fields = {
        "path_to_vagrant": {"required": True, "type": "str"},
            "state": {
            "default": "started", 
            "choices": ['started', 'stopped', 'destroyed'],  
            "type": 'str' 
        },
    }    
    module = AnsibleModule(argument_spec=fields)
    v = vagrant.Vagrant(root=module.params['path_to_vagrant'])
    b = (subprocess.check_output('[ -f '+module.params['path_to_vagrant']+'/Vagrantfile ] && echo "Found" || echo "Not found"',shell=True)).split('\n')[0]
    if b != "Found":
        module.fail_json(msg="No Vagrant file detected", meta=b)
    if module.params['state'] == 'started':
        v.up()

        result = v.conf()
        parameter["Name"]=result["User"]
        parameter["Status"]=v.status()[0][1]
        parameter["IP"]=result["HostName"]
        parameter["Port"]=result["Port"]
        parameter["Path_to_key"]=result["IdentityFile"]
        parameter['OS']=(v.ssh(None, "cat /etc/redhat-release").split(' '))[0]
        parameter['RAM']=(v.ssh(None, "cat /proc/meminfo | grep MemTotal | awk '{print $2}'").split('\n'))[0]

    module.exit_json(changed=False, meta=parameter)

if __name__ == '__main__':  
    main()