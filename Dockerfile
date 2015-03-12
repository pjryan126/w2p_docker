
##################################################
## Dockerfile to build Python WSGI application 
## containers in Ubuntu using the latest verion 
## of the web2py framework and gunicorn as 
## an application server.
##################################################

## Set base image to Ubuntu 14.04.2
FROM ubuntu:14.04.2

## File Author / Maintainer
MAINTAINER Patrick Ryan <pjryan126@gmail.com>


## Add application resources URL to sources list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

## Update the sources list
RUN apt-get update

## Install basic Python tools
RUN apt-get install -y python python-dev python-setuptools python-pip

## Install git
RUN apt-get install -y git

## Install gunicorn
RUN apt-get install -y gunicorn

## Install virtualenv
RUN pip install virtualenv

## Build directory for web2py app
RUN mkdir /var/www

## Build virtual environment
RUN virtualenv /var/www/env

## Clone web2py directory
RUN git clone --recursive http://github.com/web2py/web2py.git /var/www/web2py

## Expose ports
EXPOSE 80

## Set default working directory where CMD will execute
WORKDIR /var/www/web2py

## Set the default command to execute when creating a new container
CMD . /var/www/env/bin/activate
CMD python anyserver.py -s gunicorn -i 0.0.0.0 -p 80