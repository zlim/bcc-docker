FROM ubuntu:trusty
LABEL maintainer="Zi Shen Lim <zlim.lnx@gmail.com>"

RUN set -ex; \
  echo "deb [trusted=yes] http://repo.iovisor.org/apt/trusty trusty-nightly main" > /etc/apt/sources.list.d/iovisor.list; \
  apt-get update -y; \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
    bcc-tools \
    libbcc-examples \
    libelf1;

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
