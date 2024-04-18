FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -yq mariadb-server && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

COPY ./conf/start.sh .
RUN chmod 777 ./start.sh

EXPOSE 3306

ENTRYPOINT ./start.sh
