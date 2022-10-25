docker exec alluxio-master /etc/init.d/ssh start
docker exec alluxio-worker1 /etc/init.d/ssh start
docker exec alluxio-worker2 /etc/init.d/ssh start
docker cp alluxio-master:/opt/alluxio/client/alluxio-2.8.0-client.jar ./
docker cp alluxio-2.8.0-client.jar coordinator:/opt/presto-server/plugin/hive-hadoop2/
docker cp alluxio-2.8.0-client.jar worker1:/opt/presto-server/plugin/hive-hadoop2/
docker cp alluxio-2.8.0-client.jar worker2:/opt/presto-server/plugin/hive-hadoop2/
docker cp alluxio-2.8.0-client.jar hive-metastore:/opt
docker exec hive-metastore bash -c  "echo 'export HIVE_AUX_JARS_PATH=/opt/alluxio-2.8.0-client.jar:\${HIVE_AUX_JARS_PATH}' >> /opt/hive/conf/hive-env.sh"
docker exec hive-metastore bash -c  "echo 'export HIVE_AUX_JARS_PATH=/opt/alluxio-2.8.0-client.jar:\${HIVE_AUX_JARS_PATH}' >> /opt/hive/conf/hive-env.sh"
docker exec coordinator bash -c  "/opt/presto-server/bin/launcher restart"
docker exec worker1 bash -c  "/opt/presto-server/bin/launcher restart "
docker exec worker2 bash -c  "/opt/presto-server/bin/launcher restart "
docker start coordinator
docker start worker1
docker start worker2