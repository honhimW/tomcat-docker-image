# tomcat-docker-image
将catalina.out输出到/usr/local/tomcat/logs/下，同时能保证容器内PID1进程为JAVA进程，docker stop &lt;container> 可以快速关闭容器，容器本身关闭慢除外。
```
docker build -t xxx/xxx .
```
运行方式与普通的tomcat镜像一样
默认的是运行```catalina.sh run```该命令会在前台运行，日志输出在前台，运行/usr/lcoal/tomcat/bin/startup.sh则会在后台运行并将日志信息输出到/usr/local/tomcat/logs/catalina.out，不过因为是后台运行，docker启动会脚本为PID1进程，进程结束直接退出容器，使用```&& tail -f /dev/null```可以时容器保持运行，但/bash/sh会成为PID1进程，无法接受容器关闭信号SIGTERM，虽然可手动添加，但多数容器的启动脚本较复杂，不建议，而且效果也不好。 
该Dockerfile只是将原来输出到前台的日志重定向到一个文件里
```
docker run -dp xxxx:8080 -v $PWD/logs:/usr/local/tomcat/logs -v $PWD/webapps:/usr/local/tomcat/webapps xxx/xxx(镜像) 
```
