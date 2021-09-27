FROM debian:buster

RUN apt-get update && \
	apt-get install -y openssh-server sudo curl wget git && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get clean

RUN useradd -rm -d /home/test -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test' | chpasswd
RUN mkdir -p /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
