#!/bin/sh

# Waiting for Kafka
while ! nc -z kafka 9092; do
  sleep 1
done

# Create target topics

kafka-topics.sh --zookeeper zookeeper:2181 --create --if-not-exists --replication-factor 1 --partitions 3 --topic events

kafka-topics.sh --zookeeper zookeeper:2181 --create --if-not-exists --replication-factor 1 --partitions 3 --topic notifications

# Get sample data to play with
timeout 10s kafka-mirror-maker.sh --consumer.config /etc/kafka-init/consumer.config --num.streams 1 --producer.config /etc/kafka-init/producer.config --whitelist="events,notifications"
