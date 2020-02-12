# Kafka-Connect from maven
Build Kafka Connect from mvn to add extra plugins. All dependencies written in `pom.xml` are packaged, and running `docker build .` includes those jars so that you can deploy and use.

## Test locally
after `mvn clean package`, run `docker-compose up --build`

docker-compose prepares the related components. Additionally mirror maker copies data from your production env to local kafka for 10 seconds using `src/test/config/kafka-init/consumer.config`.

You can add more in `src/test/config/kafka-init/start.sh`, and adapt the `consumer.config` accordingly.


use-case:
- test JDBC sink
- test custom transform

You can ignore prometheus client by using the container provided by confluent helm chart
https://github.com/confluentinc/cp-helm-charts/tree/master/charts/cp-kafka-connect


Check `/connector-plugins` to see available plugins after kafka-connect is ready
