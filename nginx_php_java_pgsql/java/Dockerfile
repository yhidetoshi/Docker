FROM store/oracle/serverjre:8

ADD hogefuga_plus-0.0.1-SNAPSHOT.conf /bin/hogefuga_plus-0.0.1-SNAPSHOT.conf
RUN chmod u+r /bin/hogefuga_plus-0.0.1-SNAPSHOT.conf

ADD hogefuga_plus-0.0.1-SNAPSHOT.jar /bin/hogefuga_plus-0.0.1-SNAPSHOT.jar
RUN chmod u+x /bin/hogefuga_plus-0.0.1-SNAPSHOT.jar
CMD ["/bin/hogefuga_plus-0.0.1-SNAPSHOT.jar"]
