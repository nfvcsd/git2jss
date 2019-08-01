#!/usr/bin/python2.7
import plistlib
import subprocess

data = subprocess.check_output(['/usr/sbin/system_profiler', 'SPSoftwareDataType', '-xml', '-detailLevel', 'mini'])
plist = plistlib.readPlistFromString(data)
uptime_string = plist[0]['_items'][0]['uptime']
time_list = uptime_string.split('up ')[1].split(':')
time_stamp = '{} d {} h {} m {} s'.format(*time_list)

print("<result>{}</result>".format(time_stamp))