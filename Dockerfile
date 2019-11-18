FROM ubuntu:16.04

# install Ansible
RUN apt update
RUN apt install software-properties-common -y
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt install ansible -y
 
# Install SSHD and fix SSH login (Otherwise user is kicked off after login)
RUN apt update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Install EVE-NG (future use labs)
#RUN echo exit 0 > /usr/sbin/policy-rc.d
#RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
#RUN wget -O - http://www.eve-ng.net/repo/eczema@ecze.com.gpg.key | apt-key add - # Blergh
#RUN apt-add-repository "deb [arch=amd64] http://www.eve-ng.net/repo xenial main"
#RUN apt-get update
#RUN apt-get install -f
#RUN apt-get upgrade -y
#RUN apt-get install -y eve-ng

# Root password
RUN echo 'root:root' | chpasswd

# House Keeping
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Networking
#EXPOSE 22

# Run SSHD and do not detach/demonize
CMD ["/usr/sbin/sshd", "-D"]