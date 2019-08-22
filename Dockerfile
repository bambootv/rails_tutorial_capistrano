FROM ruby:2.5.3
LABEL author="hoanki2212@gmail.com"
RUN apt-get update && \
    apt-get install -y nodejs nano vim

# Set the timezone.
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV APP_PATH /blog
WORKDIR $APP_PATH
COPY Gemfile Gemfile.lock $APP_PATH/
RUN bundle install --without production \
    --retry 2 \
    --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1`
COPY . $APP_PATH

# Add a script to be executed every time the container starts.
COPY docker/boot.sh /usr/bin/
RUN chmod +x /usr/bin/boot.sh
ENTRYPOINT ["boot.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
