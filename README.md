# mydns-ng-docker
> Don't use this in production. In fact, don't use mydns-ng in production.

mydns-ng was an authoritative DNS server that used a MySQL backend. It was once fairly popular,
but the latest release dates from 2010.

Only use this Docker image to simulate existing environments that need to be upgraded to a more recent
and more modern DNS server such as PowerDNS, Bind or unbound.

## Loading a SQL dump

This image supports loading a SQL dump if you mount it as /load.sql inside your container.

Eg:
```
 docker container run -v /Users/frank/Downloads/mydns_2019-03-03_22h00m.Sunday.sql:/load.sql -it -p 5353:53 franklouwers/mydns-ng
```
