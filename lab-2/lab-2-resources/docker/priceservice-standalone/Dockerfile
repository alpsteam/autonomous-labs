FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl default-jdk git maven gnupg gnupg-agent software-properties-common vim openssh-server sudo unzip

#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# add lab user and enable sudo
RUN useradd -U -m -s /bin/bash --groups sudo lab  && \
    echo "lab:lab" | chpasswd && \
    bash -c 'echo "lab ALL=(ALL:ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'

USER lab

WORKDIR /home/lab

# install oci cli
RUN wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh 
RUN bash install.sh --accept-all-defaults 
RUN echo "export LC_ALL=C.UTF-8 && export LANG=C.UTF-8" >> /home/lab/.bashrc
RUN rm ~/install.sh

# install docker & kubernetes
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
   sudo touch /etc/apt/sources.list.d/kubernetes.list && \ 
   echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
   sudo apt-get update && \
   sudo apt-get install -y kubectl docker-ce docker-ce-cli containerd.io

RUN sudo usermod -aG docker lab

RUN sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*




