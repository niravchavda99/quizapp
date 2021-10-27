#!/bin/bash
# Move to that directory

# cd `git rev-parse --show-toplevel`
cd WEB-INF/classes/


# Compile all files

STR=`set | grep CLASSPATH`
pth=`cut -c 11- <<< $STR`
javac -cp $pth models/*.java
javac -cp $pth utils/*.java
javac -cp $pth controllers/*.java

# Restart Tomcat
sudo systemctl restart tomcat