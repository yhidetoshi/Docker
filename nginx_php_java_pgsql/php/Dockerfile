FROM centos:centos6

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN yum -y install wget epel-release
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN rpm -Uvh ./remi-release-6.rpm
RUN sed -i '4a priority=1' /etc/yum.repos.d/remi-php71.repo
RUN yum -y install --enablerepo=remi-php71 php.x86_64 php-cli.x86_64 php-fpm.x86_64 php-json.x86_64 php-mbstring.x86_64 php-pdo.x86_64 php-xml.x86_64

ADD
ADD start.sh /bin/start.sh
RUN chmod u+x /bin/start.sh
CMD ["/bin/start.sh"]
