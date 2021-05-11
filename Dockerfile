FROM centos:8
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt /app/
RUN yum install -y gcc-c++ cmake
RUN yum install -y python3 python3-pip
RUN yum install -y python3-devel make libXext libSM libXrender mesa-libGLU
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN yum clean all
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/.wants/;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/udev; \
rm -f /lib/systemd/system/sockets.target.wants/initctl; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN yum remove -y  gcc-c++ cmake python3-devel
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
