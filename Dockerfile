FROM ruby:2.6.4-stretch

COPY . /application

WORKDIR /application
RUN bundle install --deployment --without development test

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt install -y nodejs

ENV RAILS_ENV production
ENTRYPOINT [ "./entrypoint.sh" ]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
