# Dockerfile for build dubbo

FROM centos:centos6

MAINTAINER Zhang Peihao (zhangpeihao@gmail.com)

RUN yum -y --noplugins --verbose update
RUN yum -y --noplugins --verbose install git wget tar

RUN wget http://www.apache.org/dist//maven/binaries/apache-maven-3.2.2-bin.tar.gz && \
    tar zxvf apache-maven-3.2.2-bin.tar.gz && \
    mv ./apache-maven-3.2.2 /usr/local/ && \
    ln -s /usr/local/apache-maven-3.2.2/bin/mvn /bin/mvn && \
    cd /usr/local && \
    git clone https://github.com/alibaba/dubbo.git dubbo && \
    cd dubbo && \
    git checkout -b dubbo-2.4.11 && \
    mvn clean install -Dmaven.test.skip

ENV DUBBO_HOME /usr/local/dubbo

CMD cd /usr/local/dubbo/dubbo-admin && mvn jetty:run -Ddubbo.registry.address=zookeeper://127.0.0.1:2181

EXPOSE 8080