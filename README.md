# Kafka-Connect from maven
Build Kafka Connect from mvn so it's effortless to add extra plugin by mvn dependency plugin.
All dependencies written in `pom.xml` will be packaged, and running `docker build .` will include those jars so that you can deploy and use.

## Test locally
after `mvn clean package`, run `docker-compose up --build`

docker-compose prepares the related components. Additionally mirror maker copies data from your production env to local kafka for 10 seconds,
if configured `src/test/config/kafka-init/consumer.config`.

You can add more in `src/test/config/kafka-init/start.sh`, and adapt the `consumer.config` accordingly.


use-case:
- test JDBC sink
- test custom transform

You can ignore prometheus client by using the container provided by confluent. It's especially convenient when using the helm chart
https://github.com/confluentinc/cp-helm-charts/tree/master/charts/cp-kafka-connect
