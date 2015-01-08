FROM opensciencegrid/esmond

MAINTAINER Soichi Hayashi <hayashis@iu.edu>

RUN yum -y install yum-priorities python-pip
RUN yum -y localinstall http://repo.grid.iu.edu/osg/3.2/osg-3.2-el6-release-latest.rpm
RUN yum -y install --enablerepo=osg-development rsv-perfsonar condor-cron

#http://stackoverflow.com/questions/12601316/how-to-make-python-requests-work-via-socks-proxy
#this maybe needed to get python request to work with socks5:// proxy
#RUN pip install requesocks

RUN /sbin/chkconfig condor-cron on

#Listen on 8080
COPY httpd.conf /etc/httpd/conf/httpd.conf
EXPOSE 8080

CMD \
    service httpd start && \
    service condor-cron start && \
    service rsv start && \
    sleep 5 && \
    rsv-control --enable org.osg.local.network-monitoring-local --host esmond && \
    rsv-control --on org.osg.local.network-monitoring-local --host esmond && \
    rsv-control --off gratia-consumer && \
    sleep 2 && \
    tail -f /var/log/condor-cron/* /var/log/rsv/metrics/* /var/log/httpd/*

