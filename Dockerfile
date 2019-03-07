FROM centos:7

RUN yum update -y
RUN yum install -y gcc mariadb mariadb-devel make mariadb-server

ADD https://netcologne.dl.sourceforge.net/project/mydns-ng/mydns/1.2.8.31/mydns-1.2.8.31.tar.gz /src/mydns.tgz
WORKDIR /src
RUN tar zxvf mydns.tgz
WORKDIR mydns-1.2.8.31

RUN  ./configure --with-mysql-lib=/usr/lib64/mysql/ --with-zlib=/usr/lib64
RUN make && make install && make conf

RUN chown mysql.mysql /var/lib/mysql
RUN mysql_install_db --user=mysql
RUN /usr/bin/mysqld_safe --nowatch && sleep 5 && mysqladmin -v create mydns && mysql -e "create user mydns@localhost identified by 'mydns'" && mysql -e "grant all on mydns.* to mydns@localhost" && mydns --create-tables | mysql mydns
ADD mydns.conf /etc/mydns.conf

WORKDIR /
ADD entrypoint.sh /
CMD /entrypoint.sh

VOLUME /var/lib/mysql
EXPOSE 53


