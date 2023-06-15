FROM golang:bullseye AS easy-novnc-build
WORKDIR /src

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT
RUN printf '..%s..' "I'm building for TARGETPLATFORM=${TARGETPLATFORM}" \
    && printf '..%s..' ", TARGETARCH=${TARGETARCH}" \
    && printf '..%s..' ", TARGETVARIANT=${TARGETVARIANT} \n" 
    
# RUN go mod init build && \
#     go get github.com/geek1011/easy-novnc@v1.1.0 && \
#     go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

# FROM debian:bullseye

# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu && \
#     rm -rf /var/lib/apt/lists && \
#     mkdir -p /usr/share/desktop-directories

# RUN apt-get update -y && \
#     apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync ca-certificates xdg-utils htop tar xzip gzip bzip2 zip unzip && \
#     rm -rf /var/lib/apt/lists


RUN if [ "$TARGETARCH" = "arm64" ]; then \
        wget -q -O /tmp/oscar.deb https://www.apneaboard.com/OSCAR/oscar_1.4.0-RasPiOS-11_arm64.deb; \
    else \
        wget -q -O /tmp/oscar.deb https://www.apneaboard.com/OSCAR/oscar_1.4.0-RasPiOS-11_armhf.deb; \
    fi

# RUN apt-get update -y && \
#     wget -q -O /tmp/oscar.deb https://www.apneaboard.com/OSCAR/oscar_1.4.0-RasPiOS-11_arm64.deb &&  \
#     apt install -y /tmp/oscar.deb && \
#     rm /tmp/oscar.deb && \
#     rm -rf /var/lib/apt/lists


# COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
# COPY menu.xml /etc/xdg/openbox/
# COPY supervisord.conf /etc/
# EXPOSE 8080

# RUN groupadd --gid 1000 app && \
#     useradd --home-dir /data --shell /bin/bash --uid 1000 --gid 1000 app && \
#     mkdir -p /data

# #VOLUME /data

# CMD ["sh", "-c", "chown app:app /data /dev/stdout && exec gosu app supervisord"]
