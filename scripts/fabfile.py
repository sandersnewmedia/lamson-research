#!/usr/bin/env python

from fabric.api import *
from fabric.contrib.files import exists

import datetime
import os
import sys
import time

def sanderslabs():
    env.hosts = [ 'sanderslabs.us' ]
    env.user = 'elijah'
    env.group = 'developer'
    env.app_user = 'root'
    env.app_group = 'developer'
    env.repo = '/sites/lamson-research/'

def deploy():
    start_time = datetime.datetime.now()

    with cd(env.repo):
        # set to git permissions
        sudo('chown {user}:{group} . -R'.format(**env))

        run('git pull origin master'.format(**env))

        # install the pyenv if it does not exist
        if not exists('pyenv'):
            run('./scripts/install.sh')

        env.pyenv = 'source {repo}/pyenv/bin/activate &&'.format(**env)

        # install any new required packages
        run('{pyenv} pip install -r {repo}/scripts/requirements.txt'.format(**env))

        # set to app permissions
        sudo('chown {app_user}:{app_group} . -R'.format(**env))

    end_time = datetime.datetime.now()
    total_time = end_time - start_time
    print 'Deployed in %s seconds' % total_time.seconds
