FROM centos:7.2.1511

RUN yum install -y sudo

COPY entrypoint.sh /
RUN  chmod -v +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
