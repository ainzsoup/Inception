FROM alpine:3.14

RUN apk update && apk add --no-cache mariadb mariadb-client pwgen

COPY tools/setupsql.sh /setupsql.sh
RUN chmod +x /setupsql.sh

ENTRYPOINT ["sh", "/setupsql.sh"]
