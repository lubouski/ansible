# Some usefull ansible notes and examples

## HOW TO
- [Ansible docs](http://docs.ansible.com/)

```
$ yum install python-pip
$ pip install ansible==2.4.3
...
```
## HANDLER TASKS
- Handlers are special tasks that run at the end of a play if notified by another task.
If a configuration file gets changed it will trigger to notify a service that will for example restart task. It will runs only once if triggered no metter how many times it was used.

## VARS EXAMPLE
```
[all:vars]
ansible_user=vagrant
ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key
``` 

## MODULES
* script:
Runs a local script on a remote node after transfering it

* raw:
Executes a command without going throught the Ansible module subsystem. (f.e wrap your PowerShell commands in a raw invocation and push them to host via ssh). Also applicable if you have an older python version on your target host.

