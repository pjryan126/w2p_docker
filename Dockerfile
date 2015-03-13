
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

## Build virtual environment
RUN virtualenv /usr/share/env

## Activate virtual environment
RUN . /usr/share/env/bin/activate

##To Establish ODBC Connection, uncomment the following lines:
#RUN apt-get install -y unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc
#RUN pip install --allow-all-external --allow-unverified pyodbc pyodbc
#COPY odbc.ini /etc/
#COPY odbcinst.ini /etc/
#COPY freetds.conf /etc/freetds/

## Clone web2py directory
RUN git clone --recursive http://github.com/web2py/web2py.git /usr/share/web2py

## Change directory ownership 
RUN chown -R www-data /usr/share/web2py

## Set default working directory where CMD will execute
WORKDIR /usr/share/web2py

## Set web2py administrative password
RUN sudo -u www-data python -c "from gluon.main import save_password; save_password('<YOUR PWD>', 8443)"

## Expose ports
EXPOSE 80
EXPOSE 443

## Set the default command to execute when creating a new container
CMD . /usr/share/env/bin/activate
CMD python anyserver.py -s gunicorn -i 0.0.0.0 -p 80