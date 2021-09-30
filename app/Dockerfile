FROM ruby:2.3-slim

# Create a dedicated user for running the application
RUN adduser sinatra-user
USER sinatra-user

WORKDIR /usr/src/app
COPY . ./
ENV BUNDLE_FROZEN=true
RUN bundle install

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "3000"]