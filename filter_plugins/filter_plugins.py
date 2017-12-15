#!/usr/bin/python
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

def get_mongo_src(arg, family, os_version, mongo_version):
    result = ''
    if family == "RedHat":
        family = "rhel" 
    family_os = family+os_version       
    for i in arg:
    	if family_os in i and mongo_version in i:
            return i 
    #         result = i
    #         break
    # return result

class FilterModule(object):
    def filters(self):
        return {
            'get_mongo_src': get_mongo_src
        }
