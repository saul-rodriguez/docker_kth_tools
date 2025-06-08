FROM ubuntu:24.04

# prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# update dependencies
RUN apt update
RUN apt upgrade -y

# install xfce desktop
RUN apt install -y xfce4 xfce4-goodies

# install openssh, vnc, and Xserver
RUN apt install -y openssh-server tightvncserver x11-xserver-utils xorg xserver-xorg dbus-x11 

# install packages
RUN apt install -y \  
  net-tools \
  nano \
  vim \
  mc \  
  curl \
  wget \
  firefox \
  git \
  python3 \
  python3-pip \
  bash-completion \
  xterm \
  ksh \
  csh
 
# xfce fixes
RUN update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

# root account
RUN echo "root:rootpsw" | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config 

ARG VNCPORT=5900
ENV VNCPORT=${VNCPORT}
EXPOSE ${VNCPORT}

ARG SSHPORT=22
ENV SSHPORT=${SSHPORT}
EXPOSE ${SSHPORT}

ARG VNCDEPTH=24
ENV VNCDEPTH=${VNCDEPTH}

COPY run.sh /run.sh
CMD ["/bin/sh", "/run.sh"]

