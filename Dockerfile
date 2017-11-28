FROM ubuntu:16.04

LABEL maintainer "Alpeware <info@alpeware.com>"

EXPOSE 9222

RUN apt-get update -qqy \
  && apt-get -qqy install libnss3 libnss3-tools libfontconfig1 wget ca-certificates apt-transport-https inotify-tools \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV CHROME_VERSION=62.0.3202.94

# Install chrome headless
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable=${CHROME_VERSION}-1 \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install curl (mandatory to install nodejs)
RUN apt-get install --yes curl

# Install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

# Install yarn
RUN wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qqy \
    && apt-get install yarn \
    && rm /etc/apt/sources.list.d/yarn.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt-get install yarn

RUN google-chrome-stable --version

COPY start.sh /usr/bin/

RUN mkdir /data
VOLUME /data
ENV HOME=/data DEBUG_ADDRESS=0.0.0.0 DEBUG_PORT=9222

RUN mkdir /var/www
COPY index.js /var/www

CMD ["/usr/bin/start.sh"]
