FROM scratch 

ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ADD 2e5ac55d.0 /etc/ssl/certs/2e5ac55d.0
ADD https://repo.voidlinux.eu/static/xbps-static-latest.x86_64-musl.tar.xz  /

RUN ["/usr/bin/xbps-install","-Syu","-R","https://repo.voidlinux.eu/current","busybox-static"]
#create tmp folder
RUN ["/usr/bin/busybox.static","mkdir","-p","/tmp"]
RUN ["/usr/bin/busybox.static","ln","-sf","busybox.static","/usr/bin/sh"]


RUN ["/usr/bin/busybox.static","ln","-sf","/usr/bin","/bin"]
RUN ["/usr/bin/busybox.static","ln","-sf","/usr/lib","/lib"]

RUN ["/usr/bin/xbps-install","-Syu","-R","https://repo.voidlinux.eu/current","xbps-triggers"]

RUN ["/usr/bin/busybox.static","ln","/usr/bin/busybox.static","/usr/bin/chmod"]
RUN ["/usr/bin/xbps-install","-Syu","-R","https://repo.voidlinux.eu/current","dash"]

RUN ["/usr/bin/xbps-alternatives","-g","sh","-s","dash"]
RUN xbps-remove -y busybox-static &&  /usr/bin/xbps-install -Syu -R https://repo.voidlinux.eu/current coreutils base-files glibc-locales bash grep xbps iana-etc tzdata sed && rm -rf /var/cache/xbps/ /usr/bin/*.static
