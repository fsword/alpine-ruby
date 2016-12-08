FROM frolvlad/alpine-glibc:alpine-3.4

RUN apk add -U build-base ca-certificates nano bash zlib-dev git && \
  update-ca-certificates && \
  apk add -U ruby-dev ruby-io-console ruby-rdoc ruby-irb ruby-bigdecimal && \
  rm -rf /var/cache/apk/*

RUN gem install rubygems-update && update_rubygems

ENV PATH=/usr/local/bundle/bin:$PATH
ENV GEM_HOME=/usr/local/bundle

RUN mkdir -p /usr/src/app /usr/local/bundle
WORKDIR /usr/src/app

RUN gem install bundler

CMD ["irb"]

