# docker build -t carpoolers .
# docker network create --subnet=172.20.0.0/16 carpoolers_net
# docker run -it -p 80:80 -p 443:443 --name=app01 --net carpoolers_net --add-host=db-server:10.0.0.21 --ip 172.20.0.2 carpoolers bash
# docker run -it -d -p 80:80 -p 443:443 --name=app01 --net carpoolers_net --add-host=db-server:10.0.0.21 --ip 172.20.0.2 carpoolers sudo /opt/nginx/sbin/nginx

FROM ubuntu
MAINTAINER Marcelo Ribeiro

RUN apt-get update
RUN apt-get install sudo
RUN adduser ubuntu
RUN passwd -d ubuntu
RUN echo "ubuntu ALL=(ALL) ALL" >> /etc/sudoers

USER ubuntu
RUN sudo apt-get update
RUN sudo apt-get install git nodejs curl libqt4-dev libqtwebkit-dev imagemagick -y
RUN sudo apt-get install mysql-client net-tools wget xvfb libssl-dev -y
RUN ["/bin/bash", "-l", "-c", "echo Switching to bash"]
SHELL ["/bin/bash", "-l", "-c"]
RUN \curl -sSL https://get.rvm.io | bash
RUN source /home/ubuntu/.rvm/scripts/rvm
RUN rvm requirements
RUN rvm install 2.5.1
RUN gem install bundler
RUN sudo apt-get install libpq-dev -y
RUN rvm use 2.5.1
RUN gem install passenger
RUN sudo apt-get install libcurl4-openssl-dev  -y
RUN rvmsudo passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx
RUN sudo apt-get install libqt5webkit5-dev libmysqlclient-dev libmagickwand-dev telnet mysql-client -y
COPY ./ /home/ubuntu/carpoolers
COPY ./config/docker.database.yml /home/ubuntu/carpoolers/config/database.yml
RUN sudo chown ubuntu:ubuntu /home/ubuntu/carpoolers -R
WORKDIR /home/ubuntu/carpoolers
RUN bundle
RUN gem install tzinfo-data
COPY docker_files/nginx.conf /opt/nginx/conf/
RUN sudo mkdir -p /opt/nginx/conf/sites-available
COPY docker_files/sites-available/01-app.conf /opt/nginx/conf/sites-available
RUN sudo mkdir -p /opt/nginx/conf/sites-enabled
RUN sudo ln -s /opt/nginx/conf/sites-available/01-app.conf /opt/nginx/conf/sites-enabled
COPY ./docker_files/tzdata_installer.sh /home/ubuntu
RUN sudo chmod +x /home/ubuntu/tzdata_installer.sh
RUN sudo /home/ubuntu/tzdata_installer.sh
EXPOSE 80
EXPOSE 443
