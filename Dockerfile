FROM golang:bullseye AS easy-novnc-build
WORKDIR /src

RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM debian:bullseye

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
RUN printf '..%s..' "I'm building for TARGETPLATFORM=${TARGETPLATFORM}" \
    && printf '..%s..' ", TARGETARCH=${TARGETARCH}" \
    && printf '..%s..' ", TARGETVARIANT=${TARGETVARIANT} \n" 

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu cron && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

RUN if [ "${TARGETARCH}" = "arm64" ]; then \
        wget -q -O /tmp/oscar.deb https://www.apneaboard.com/OSCAR/1.5.3/oscar_1.5.3-RasPiOS-12_arm64.deb; \
        
    else \
        wget -q -O /tmp/oscar.deb https://www.apneaboard.com/OSCAR/1.5.3/oscar_1.5.3-RasPiOS-12_armhf.deb; \
    fi

RUN apt-get update -y && \
    apt install -y /tmp/oscar.deb && \
    rm /tmp/oscar.deb && \
    rm -rf /var/lib/apt/lists

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY menu.xml /etc/xdg/openbox/
COPY supervisord.conf /etc/

# Adding Script to download from ezShare and setting up th Cron
COPY ezShareDownloader.sh /opt/src/scripts/ezShareDownloader.sh
RUN chmod 777 /opt/src/scripts/ezShareDownloader.sh
COPY create_cron.sh /opt/src/scripts/create_cron.sh
RUN chmod 777 /opt/src/scripts/create_cron.sh
 
EXPOSE 8080

RUN groupadd --gid 1000 app && \
    useradd --home-dir /data --shell /bin/bash --uid 1000 --gid 1000 app && \
    mkdir -p /data \
    mkdir -p /SDCARD

#VOLUME /data

CMD ["sh", "-c", "/opt/src/scripts/create_cron.sh && chown app:app /data /dev/stdout /SDCARD && exec gosu app supervisord"]
