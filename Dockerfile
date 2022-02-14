FROM node:17
LABEL "repository"="https://github.com/sugerio/nuxt-vue-s3-action"
LABEL "maintainer"="Suger Inc"
LABEL "version"="1.0.0"

#Install utilities
RUN apt update && \
	apt upgrade -y && \
    apt install -y zip && \
    apt install -y awscli && \
    apt autoremove && \
	apt autoclean && \
	apt clean

ADD entrypoint.sh /entrypoint.sh
#Make entrypoint file executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]