# Spin-docker base dockerfile
# Use this dockerfile as a template to build your own spin-docker images
# https://github.com/atbaker/spin-docker

# Use phusion/baseimage as base image
FROM phusion/baseimage:0.9.8

# Add yourself as the maintainer
# MAINTAINER John Doe <john@example.com>

# Set correct environment variables
ENV HOME /root

# This command instructs your image to use Phusion's insecure key. This is a
# a bad idea for production. Read here to learn about using your own keys: 
# https://github.com/phusion/baseimage-docker#using_your_own_key
RUN /usr/sbin/enable_insecure_key

# Add instructions to install your app here
# See the PostgreSQL example if you need an idea

# Create a runit entry for your app
RUN mkdir /etc/service/myapp
ADD run_myapp.sh /etc/service/myapp/run
RUN chown root /etc/service/myapp/run

# Optionally add the spin-docker client to report on container activity
# NOTE: If you skip this step, be sure to disable activity monitoring
# in your spin-docker configuration
ADD sd_client.py /opt/sd_client.py
ADD sd_client_crontab /var/spool/cron/crontabs/root
RUN chown root /opt/sd_client.py /var/spool/cron/crontabs/root

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Spin-docker currently supports exposing port 22 for SSH and
# one additional application port
EXPOSE 22 ##

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
