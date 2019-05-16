FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN gem install bundler
RUN git clone https://github.com/Artemmkin/reddit.git

COPY mongod.conf /etc/mongod.conf
COPY db_config /app/db_config
COPY start.sh /start.sh

RUN gem install puma -v '3.10.0' --source 'https://rubygems.org/'
RUN gem install bson_ext -v '1.5.1' --source 'https://rubygems.org/'
RUN gem install bson -v '4.2.2' --source 'https://rubygems.org/'
RUN gem install bcrypt -v '3.1.11' --source 'https://rubygems.org/'
RUN cd /reddit && bundle install
RUN mkdir -p /data/db
RUN chmod 0777 /start.sh

CMD ["/start.sh"]