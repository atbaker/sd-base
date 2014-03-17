#!/usr/bin/python
from urllib2 import Request, urlopen

import subprocess

# Get the docker0 interface IP address.
result = subprocess.check_output("ip route show", shell=True)
docker_ip = result.split()[2]

# Add some code here to determine if your container is active or not.
# By default, this script is called every 10 minutes. Change that in the crontab file.

# For this example, we'll set active_connections to always be 1
active_connections = 1

# POST the active connections to the spin-docker client
req = Request('http://%s/v1/check-in' % docker_ip, data='active-connections=%s' % active_connections)
try:
    resp = urlopen(req)
except Exception:
    pass
