FROM openjdk:11.0.6-jre

ENV USER kafka-connect
RUN useradd -m ${USER}

ARG APP_PATH=/opt/kafka-connect

# Expose rest port and JMX
EXPOSE 8083 9400

# Installing envsubst
RUN apt-get update && apt-get install -y gettext && rm -rf /var/lib/apt/lists/*

# Prepare the app path
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

# Java settings
ENV JAVA_TOOL_OPTIONS="-XX:+UseG1GC -Duser.timezone=UTC"
ENV STORAGE_REPLICATION_FACTOR=3
ENV EXTRA_ARGS="-javaagent:libs/jmx_prometheus_javaagent-0.12.0.jar=9400:jmx_exporter.yaml "

# Copy libs
COPY target/dependency $APP_PATH/libs/

# Copy config
COPY src/main/config $APP_PATH/

ENTRYPOINT ["/bin/sh"]

CMD ["-c", "envsubst < connect-kafka.template.properties > connect-kafka.properties && java ${EXTRA_ARGS} ${DOCKER_JAVA_OPTS} -Dlog4j.configuration=file:log4j.properties -cp 'libs/*' org.apache.kafka.connect.cli.ConnectDistributed connect-kafka.properties "]
