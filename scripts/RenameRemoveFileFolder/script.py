#!/opt/nfv/bin/python3.8
import sys
import os
from SystemConfiguration import SCDynamicStoreCopyConsoleUser
import shutil

# Variables
userspace = ''

# Add error handling
file_path = sys.argv[1]
user_space = sys.argv[2]
rename_remove = sys.argv[3]
newfilename = sys.argv[4]

# Get Logged in user

def getLoggedInUser():
    username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]
    username = [username,""][username in [u"loginwindow", None, u""]]
    return(username)

def validateFilePath(path):
    if os.path.exists(path):
        return True
    else:
        return False

def fileOrDir(path):
    if os.path.isdir(path):
        return('file')
    else:
        return('dir')

def renameFile(path, newname):
    os.rename(path, newname)

def removeFile(path):
    if fileOrDir(path) == 'file':
        shutil.rmtree(path)
    if fileOrDir(path) == 'dir':
        os.rmdir(path)
        
if user_space:
    userspace = True
    loggedInUser =  getLoggedInUser()
    userpath = os.path.join('/home', loggedInUser, file_path)
    if validateFilePath(userpath):
        if rename_remove == 'rename':
            renameFile(path, newfilename)
        if rename_remove == 'remove':
            removeFile(path)
    else:
        print('File does not exist')
        exit 1
        
if not user_space:
