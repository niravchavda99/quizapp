#!/bin/bash

# Move to that directory
cd WEB-INF/classes/

# Compile all files
javac models/*.java
javac utils/*.java
javac controllers/*.java
javac controllers/socket/*.java