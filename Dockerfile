FROM tomcat
ENTRYPOINT ["catalina.sh","run",">>","./logs/catalina.out","2>&1"]
