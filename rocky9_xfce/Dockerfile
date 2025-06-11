FROM rockylinux:9.3

#OS tools including XFCE4
RUN dnf install -y epel-release && \
    dnf update -y --allowerasing && \
    dnf groupinstall -y "Server with GUI" --allowerasing && \
    dnf install -y xfce4-panel xfce4-session xfce4-settings xfce4-appfinder xfdesktop xfwm4 \
                   tigervnc-server novnc openssh-server passwd sudo xterm xorg-x11-server-Xvfb

#Other tools
RUN dnf install -y nano mc

#Libraries for ngpsice
RUN dnf install -y gcc perl perl-XML-LibXML-Common libxml2-devel libxml2 perl-XML-LibXML libXaw \
                    libXaw-devel readline readline-devel libX11 libX11-devel

#Libraries for xschem
RUN dnf install -y libX11 libX11-devel libXrender libXrender-devel libX11-xcb cairo cairo-devel tcl tcl-devel tk tk-devel flex bison libXpm libXpm-devel libjpeg-turbo libjpeg-turbo-devel

#libraries for QUCS
RUN dnf install -y gcc-c++ cmake git flex bison gperf dos2unix qt6-qtbase-devel cmake qt6-qtsvg-devel qt6-qttools-devel qt6-qtcharts-devel

RUN dnf clean all

# root account
RUN echo "root:myEdaTools25" | chpasswd
#RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Expose the SSH and VNC port
EXPOSE 22
EXPOSE 5903

# Copy precompiled free EDA tools
RUN mkdir /tools
COPY ngspice.tgz /tools 
COPY xschem.tgz /tools 
COPY qucs-s.tgz /tools 

###### CMD ["/usr/sbin/sshd","-D"]

COPY run.sh /run.sh
CMD ["/bin/sh", "/run.sh"]