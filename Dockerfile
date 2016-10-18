FROM fsword/docker-alpine-glibc:3.4

RUN apk add -U build-base ca-certificates nano bash zlib-dev && \
  update-ca-certificates && \
  apk add -U ruby-dev ruby-io-console ruby-rdoc ruby-irb ruby-bigdecimal && \
  rm -rf /var/cache/apk/*

RUN gem install rubygems-update && update_rubygems

ENV PATH=/usr/local/bundle/bin:$PATH
ENV GEM_HOME=/usr/local/bundle

RUN mkdir -p /usr/src/app /usr/local/bundle
WORKDIR /usr/src/app

RUN gem install bundler
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.org

ONBUILD COPY Gemfile /usr/src/app
ONBUILD COPY Gemfile.lock /usr/src/app
ONBUILD RUN bundle install
ONBUILD COPY . /usr/src/app

CMD ["irb"]

