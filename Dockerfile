FROM ubuntu:16.04
MAINTAINER Zi Shen Lim <zlim.lnx@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb [trusted=yes] http://repo.iovisor.org/apt/xenial xenial-nightly main" > /etc/apt/sources.list.d/iovisor.list
RUN apt-get update -y
RUN apt-get install -y libelf1
RUN apt-get install -y bcc-tools libbcc-examples

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
