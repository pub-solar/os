#! /usr/bin/env python2
import os
import subprocess

def get_env(key):
    return os.getenv(key)

def get_secret(*attributes):
    return subprocess.check_output(["secret-tool", "lookup"] + list(attributes))
