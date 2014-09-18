
#let's use my hostcert as rsvcert -- I shouldn't be need this.. but just to get rsv installed..
docker run -it --rm \
    -v /etc/grid-security/hostcert.pem:/etc/grid-security/rsv/rsvcert.pem \
    -v /etc/grid-security/hostkey.pem:/etc/grid-security/rsv/rsvkey.pem \
    rsv bash

