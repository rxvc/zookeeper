FROM rxvc/kafka-base:1.0.0

MAINTAINER Rodrigo Vallejo  <rxvallejocj@gmail.com>

ENV COMPONENT=zookeeper
ENV KAFKA_VERSION=2.1.0
ENV SCALA_VERSION=2.12

RUN wget http://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && tar -xvzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && rm -rf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /usr/lib/${COMPONENT} \
    && echo "===> Setting up ${COMPONENT} dirs..." \
    && mkdir -p /var/lib/${COMPONENT}/log /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets \
    && chmod -R ag+w /var/lib/${COMPONENT}/log /etc/${COMPONENT} /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets


COPY docker/config_templates /etc/${COMPONENT}/docker/config
COPY docker/scripts /usr/lib/${COMPONENT}/docker/bin/

EXPOSE 2181 2888 3888

CMD ["/usr/lib/zookeeper/docker/bin/run"]
