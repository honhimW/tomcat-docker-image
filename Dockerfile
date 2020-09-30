FROM tomcat
COPY server.xml /usr/local/tomcat/conf/server.xml
ENTRYPOINT ["catalina.sh","run",">>","./logs/catalina.out","2>&1"]

