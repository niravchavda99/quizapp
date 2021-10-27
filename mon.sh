# Move to that directory

# cd `git rev-parse --show-toplevel`
cd WEB-INF/classes
pwd



# Compile all files

STR=sudo cat /etc/environment | grep CLASSPATH
echo $STR
# javac -cp $CLASSPATH models/*.java
# javac -cp $CLASSPATH utils/*.java
# javac -cp $CLASSPATH controllers/*.java

# Restart Tomcat
# sudo systemctl restart tomcat