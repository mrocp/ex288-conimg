FROM registry.access.redhat.com/ubi8/ubi:8.0

MAINTAINER Red Hat Training <training@redhat.com>


RUN yum install -y --nodocs --disableplugin=subscription-manager httpd  &&  \
yum clean all --disableplugin=subscription-manager -y  && \

# Allows child images to inject their own content into DocumentRoot

EXPOSE 8080

# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd
RUN chgrp -R 0 /var/run/httpd /var/log/httpd && chmod -R g=u /var/run/httpd /var/log/httpd
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
# Run as the root user
USER 1001

# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
