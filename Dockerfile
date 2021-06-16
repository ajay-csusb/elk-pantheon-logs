FROM ubuntu 

RUN apt-get update && apt-get -y install cron

# set a directory for the app
WORKDIR /usr/src/app

# copy all the files to the container
COPY . .

# https://stackoverflow.com/questions/37458287/how-to-run-a-cron-job-inside-a-docker-container
# Copy logs-cron file to the cron.d directory
COPY logs-cron /etc/cron.d/logs-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/logs-cron

# Apply cron job
RUN crontab /etc/cron.d/logs-cron

# run the command
CMD ["cron", "-f"]