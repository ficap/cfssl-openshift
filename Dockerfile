FROM docker.io/cfssl/cfssl:1.3.2
RUN go get bitbucket.org/liamstask/goose/cmd/goose

RUN mkdir -p /var/lib/cfssl/data && \
    useradd blah && \
    chown blah /var/lib/cfssl /var/lib/cfssl/data && \
    chmod a+rwx /var/lib/cfssl

COPY dbconf.yml /go/src/github.com/cloudflare/cfssl/certdb/pg/dbconf.yml
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod a+x /bin/entrypoint.sh

USER blah
ENTRYPOINT ["entrypoint.sh"]
