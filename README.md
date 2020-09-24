# tomcat-docker-image
将catalina.out输出到/usr/local/tomcat/logs/下，同时能保证容器内PID1进程为JAVA进程，docker stop &lt;container> 可以快速关闭容器，容器本身关闭慢除外。
