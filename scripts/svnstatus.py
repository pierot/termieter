#!/usr/bin/python
import os
import os.path
import hashlib
import subprocess
import shutil
import time
import sys
import traceback

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

    def disable(self):
        self.HEADER = ''
        self.OKBLUE = ''
        self.OKGREEN = ''
        self.WARNING = ''
        self.FAIL = ''
        self.ENDC = ''

def main(argv):
	try:
		print "Scanning folder for repositories..."
		if(len(argv) > 1):
			tmp = os.listdir(argv[1])
			recurse_path(argv)
		else:
			recurse_path('.')
	except (IOError, os.error):
		print "ERROR, probably invalid parameter (invalid directory)"
		return;

def recurse_path(path, **kwargs):
	names = os.listdir(path)
	errors = []
	returnvals = []
	
	for name in names:
			pathname = os.path.join(path, name)
			try:
					if os.path.isdir(pathname):
						if not _has_file(pathname):
							returnvals.extend(recurse_path(pathname, **kwargs))
						else:
							# print "Found repo, checking status (", pathname, ")"
							_get_svn_status(pathname)
			except (IOError, os.error), why:
				errors.append((pathname, why))
	if errors:
			print "raise errors"
			raise os.error, errors
	return returnvals

def _has_file(path):
	for dirname, dirnames, filenames in os.walk(path):
			for subdirname in dirnames:
				if subdirname == ".svn":
					return True
			return False

def _get_svn_status(path):
	abs_path = os.path.abspath(path)
	abs_path = abs_path.replace(' ', '\ ')
	command = "svn st " + abs_path
	proc = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
	
	proc.wait()
	
	if proc.returncode == 0:
		data = proc.stdout.readline() #block / wait
		if len(data):
			print bcolors.OKBLUE + "\tCOMMIT REPO: " + abs_path + bcolors.ENDC
		time.sleep(.1)
	else:
		print "svn status failed for ", path

main(sys.argv)