# base image
FROM stfnltnr/hadoop:3.2.0
# vars
ARG OOZIE_VERSION=5.1.0
ARG HADOOP_VERSION=3.2.0
ARG SQL_CONNECTOR_VERSION=5.1.48
# env vars
ENV OOZIE_HOME=/opt/oozie
# copy oozie build
COPY oozie-${OOZIE_VERSION}-distro-${HADOOP_VERSION}.tar.gz /
# install
RUN tar -xzf oozie-${OOZIE_VERSION}-distro-${HADOOP_VERSION}.tar.gz && \
    mv oozie-${OOZIE_VERSION} /opt/oozie && \
    mkdir /opt/oozie/libext && \
    wget http://archive.cloudera.com/gplextras/misc/ext-2.2.zip && \
    mv ext-2.2.zip $OOZIE_HOME/libext/ && \
    wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$SQL_CONNECTOR_VERSION.tar.gz && \
    tar -xzf mysql-connector-java-$SQL_CONNECTOR_VERSION.tar.gz && \
    cp mysql-connector-java-$SQL_CONNECTOR_VERSION/mysql-connector-java-$SQL_CONNECTOR_VERSION.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/common/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/common/lib/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/hdfs/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/hdfs/lib/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/mapreduce/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/mapreduce/lib/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/yarn/*.jar $OOZIE_HOME/libext/ && \
    cp $HADOOP_HOME/share/hadoop/yarn/lib/*.jar $OOZIE_HOME/libext/ && \
    echo "PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$OOZIE_HOME/bin:$PATH" >> ~/.bashrc && \
    rm -rf oozie-${OOZIE_VERSION}-distro-${HADOOP_VERSION}.tar.gz mysql-connector-java-$SQL_CONNECTOR_VERSION.tar.gz mysql-connector-java-$SQL_CONNECTOR_VERSION /var/lib/apt/lists/* /tmp/* /var/tmp/*
# ports
EXPOSE 10000 10001
# workdir
WORKDIR /opt/oozie
# entrypoint
ENTRYPOINT [ "bash" ]