FROM amazonlinux:2
RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/config
RUN mkdir -p /opt/app/bin/

WORKDIR /opt/app
COPY ./*.py /opt/app/
COPY requirements.txt /opt/app/requirements.txt

RUN yum update -y
RUN yum install -y cpio python3-pip yum-utils zip unzip less
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN pip3 install -r requirements.txt
RUN rm -rf /root/.cache/pip

WORKDIR /opt/app
RUN zip -r9 /opt/app/config/exif.zip *.py bin

WORKDIR /usr/local/lib64/python3.7/site-packages/
RUN  zip -r9 /opt/app/config/exif.zip *
WORKDIR /opt/app

