FROM node:6.2.0-wheezy
MAINTAINER zhouxin@day-one.cn

#update eveything
RUN rm -rf /var/lib/apt/lists
RUN apt-get update -q --fix-missing
RUN apt-get -y upgrade
RUN rm -rf /var/lib/apt/lists/*

#get ehterpad
RUN mkdir /var/lib/etherpad
WORKDIR /var/lib/etherpad
RUN curl -L https://github.com/ether/etherpad-lite/tarball/master | tar -xz --strip-components=1

# Add startup script
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

RUN ./bin/installDeps.sh
RUN npm i graceful-fs@latest

# A few workarounds so we can run as non-root on openshift
RUN mkdir /.npm
COPY fix-permissions.sh ./
RUN chmod a+x fix-permissions.sh
RUN  ./fix-permissions.sh /.npm
RUN  ./fix-permissions.sh /var/lib/etherpad

# Run as a random user. This happens on openshift by default so we
# might as well always run as a random user
USER 1001

# Listens on 9001 by default
EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
