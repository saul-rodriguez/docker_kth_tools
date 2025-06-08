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
  python3-pip 
  
 
# xfce fixes
RUN update-alternatives --set x-terminal-emulator /usr/bin/xfce4-terminal.wrapper

# root account
RUN echo "root:rootpsw" | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config 

# VNC and SSH 
ARG USER=root
ENV USER=${USER}

ARG VNCPORT=5900
ENV VNCPORT=${VNCPORT}
EXPOSE ${VNCPORT}

ARG SSHPORT=22
ENV SSHPORT=${SSHPORT}
EXPOSE ${SSHPORT}

ARG VNCPWD=changeme
ENV VNCPWD=${VNCPWD}

ARG VNCDISPLAY=1920x1080
ENV VNCDISPLAY=${VNCDISPLAY}

ARG VNCDEPTH=24
ENV VNCDEPTH=${VNCDEPTH}

# setup VNC
RUN mkdir -p /root/.vnc/
RUN echo ${VNCPWD} | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd
RUN echo "#!/bin/sh \n\
xrdb $HOME/.Xresources \n\
xsetroot -solid grey \n\
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" & \n\
#x-window-manager & \n\
# Fix to make GNOME work \n\
export XKL_XMODMAP_DISABLE=1 \n\
/etc/X11/Xsession \n\
startxfce4 & \n\
" > /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

CMD [ "/bin/bash", "-c", " \
  echo 'Welcome to KTH EDA tools container'; \  
  vncserver :0 -rfbport ${VNCPORT} -geometry $VNCDISPLAY -depth $VNCDEPTH; \
  tail -f /dev/null \
" ]

