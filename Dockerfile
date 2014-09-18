
#rsv-perfsonar uses esmond 
#[edgar] .. No the probes that read info out of the personar boxes actually need the esmond libraries to do their work.
FROM opensciencegrid/esmond

MAINTAINER Soichi Hayashi <hayashis@iu.edu>

#install repos (for osg)
RUN yum -y install yum-priorities
RUN yum -y localinstall http://repo.grid.iu.edu/osg/3.2/osg-3.2-el6-release-latest.rpm

RUN yum -y install --enablerepo=osg-development rsv-perfsonar

#you have to create some self-signed cert just to silence osg-configure complaining
ADD rsvkey.pem /etc/grid-security/rsv/rsvkey.pem
ADD rsvcert.pem /etc/grid-security/rsv/rsvcert.pem
RUN osg-configure -c

#start rsv (you need to link esmond instance with the name "esmond")
CMD \
    rsv-control --enable org.osg.local.network-monitoring-local --host esmond \
    /etc/init.d/condor-cron start \
    service rsv start \
    rsv-control --on org.osg.local.network-monitoring-local \
    tail -f /var/log/condor-cron/*

