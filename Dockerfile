# Dockerfile for build dubbo

FROM centos:centos6

MAINTAINER Zhang Peihao (zhangpeihao@gmail.com)

RUN yum -y --noplugins --verbose update
RUN yum -y --noplugins --verbose install git wget tar

RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.rpm -O /tmp/jdk-7u80-linux-x64.rpm && \
    rpm -i /tmp/jdk-7u80-linux-x64.rpm && \
    rm /tmp/jdk-7u80-linux-x64.rpm
ENV JAVA_HOME /usr/java/latest

#RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.rpm -O /tmp/jdk-8u20-linux-x64.rpm && \
#    rpm -i /tmp/jdk-8u20-linux-x64.rpm && \
#    rm /tmp/jdk-8u20-linux-x64.rpm
#ENV JAVA_HOME /usr/java/latest

#RUN yum -y install wget && \
#	wget --no-cookies \
#         --no-check-certificate \
#         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#         "http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jre-6u45-linux-x64-rpm.bin" \
#         -O /tmp/jre-6u45-linux-x64-rpm.bin  && \
#	chmod a+x /tmp/jre-6u45-linux-x64-rpm.bin && \
#    /tmp/jre-6u45-linux-x64-rpm.bin -x && \
#    rm /tmp/jre-6u45-linux-x64-rpm.bin && \
#    yum -y localinstall /jre-6u45-linux-amd64.rpm && \
#    rm /jre-6u45-linux-amd64.rpm && \
#    yum clean all
#ENV JAVA_HOME /usr/java/default

RUN wget http://www.apache.org/dist//maven/binaries/apache-maven-3.2.2-bin.tar.gz && \
    tar zxvf apache-maven-3.2.2-bin.tar.gz && \
    mv ./apache-maven-3.2.2 /usr/local/ && \
    ln -s /usr/local/apache-maven-3.2.2/bin/mvn /bin/mvn && \
    cd /usr/local && \
    git clone https://github.com/alibaba/dubbo.git dubbo && \
    cd dubbo && \
    mvn clean install -Dmaven.test.skip
	
ENV DUBBO_HOME /usr/local/dubbo

CMD cd /usr/local/dubbo/dubbo-admin && mvn jetty:run -Ddubbo.registry.address=zookeeper://127.0.0.1:2181

EXPOSE 8080