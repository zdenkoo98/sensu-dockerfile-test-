FROM centos:7
RUN yum install epel-release -y
COPY sensu.repo  /etc/yum.repos.d/
RUN yum install sensu -y
RUN yum install git -y
WORKDIR /etc/sensu/conf.d
RUN git clone https://github.com/zdenkoo98/sensu-server.git
WORKDIR /etc/sensu/conf.d/sensu-server
RUN mv uchiwa.json /etc/sensu/
RUN yum install redis -y
COPY rabbitmq-earlang.repo /etc/yum.repos.d/
RUN curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
RUN yum install rabbitmq-server-3.7.7-1.el7.noarch -y
RUN yum install uchiwa -y 
RUN rm -f /etc/sensu/uchiwa.json.rpmnew
WORKDIR /etc/sensu/
RUN mv uchiwa.json config.json
COPY script.sh /etc/sensu/
RUN yum install nmap -y
ENTRYPOINT ["/usr/bin/bash"]
EXPOSE 25 4567 3000 5672 8080
