FROM ruby:2.5.8
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /borderbot
COPY Gemfile /borderbot/Gemfile
COPY Gemfile.lock /borderbot/Gemfile.lock

# Install the borderbot gem
# RUN cd /tmp &&\
#     git clone https://github.com/gavargas22/borderbot.git &&\
#     cd borderbot &&\
#     gem build borderbot.gemspec &&\
#     cd /borderbot &&\
#     bundle install
RUN bundle install

COPY . /borderbot
ENV PATH "$PATH:/borderbot"
# Add a script to be executed every time the container starts.

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

# EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rdebug-ide", "--debug", "--host", "0.0.0.0", "--port", "1234"]