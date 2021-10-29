#!/bin/bash

# Move to that directory
cd WEB-INF/classes/

# Compile all files
javac models/*.java
javac utils/*.java
javac controllers/*.java
javac controllers/socket/*.java

# Restart Tomcat
C:/xampp/tomcat/bin/shutdown.sh
C:/xampp/tomcat/bin/startup.sh