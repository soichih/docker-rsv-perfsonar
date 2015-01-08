FROM opensciencegrid/esmond

MAINTAINER Soichi Hayashi <hayashis@iu.edu>

RUN yum -y install yum-priorities
RUN yum -y localinstall http://repo.grid.iu.edu/osg/3.2/osg-3.2-el6-release-latest.rpm
RUN yum -y install --enablerepo=osg-development rsv-perfsonar
RUN /sbin/chkconfig condor-cron on
EXPOSE 80

CMD \
    service httpd start && \
    service condor-cron start && \
    service rsv start && \
    sleep 5 && \
    rsv-control --enable org.osg.local.network-monitoring-local --host esmond && \
    rsv-control --on org.osg.local.network-monitoring-local --host esmond && \
    sleep 2 && \
    tail -f /var/log/condor-cron/* /var/log/rsv/metrics/* /var/log/httpd/*

