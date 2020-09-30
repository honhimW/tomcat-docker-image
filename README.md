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
### Docker缺点
Linux下PID1为init进程，stop命令会传递SIGTERM到容器内PID1进程，LinuxPID 1-5为特殊进程  
> pid=1 ：init进程，系统启动的第一个用户级进程，是所有其它进程的父进程，引导用户空间服务。  
> pid=2 ：kthreadd：用于内核线程管理。  
> pid=3 ：migration，用于进程在不同的CPU间迁移。  
> pid=4 ：ksoftirqd，内核里的软中断守护线程，用于在系统空闲时定时处理软中断事务。  
> pid=5 ：watchdog，此进程是看门狗进程，用于监听内核异常。当系统出现宕机，可以利用watchdog进程将宕机时的一些堆栈信息写入指定文件，用于事后分析宕机的原因。  
进行JVM调优时用到的jmap、jinfo、jstat、jstack均不能访问PID 1-5的进程。

### 默认tomcat镜像未开启链接池，使用nio1
修改server.xml文件下connector标签，添加连接池，改用nio2。
