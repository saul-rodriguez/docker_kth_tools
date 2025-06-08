export USERNAME=dockeruser
export USERPASSWORD=dummypsw
export VNCPASSWORD=changeme
#export VNCPORT=5900

mkdir -p /var/run/sshd
ssh-keygen -A

#Create a user and give ssh access
useradd -m $USERNAME  
echo "$USERNAME:$USERPASSWORD" | chpasswd
chown -R $USERNAME:$USERNAME /home/$USERNAME
chmod 700 /home/$USERNAME
mkdir -p /home/$USERNAME/.ssh
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
chmod 700 /home/$USERNAME/.ssh

#give the user sudo privileges
usermod -aG wheel $USERNAME

#Configure vnc
mkdir -p /home/$USERNAME/.vnc
echo "changeme" | vncpasswd -f > /home/$USERNAME/.vnc/passwd
chown -R $USERNAME:$USERNAME /home/$USERNAME/.vnc
chmod 600 /home/$USERNAME/.vnc/passwd
#dbus-uuidgen | tee /var/lib/dbus/machine-id
#printf "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4 &" > /home/$USERNAME/.vnc/xstartup
echo "#!/bin/sh \n\
xrdb /home/$USERNAME/.Xresources \n\
xsetroot -solid grey \n\
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" & \n\
#x-window-manager & \n\
# Fix to make GNOME work \n\
export XKL_XMODMAP_DISABLE=1 \n\
/etc/X11/Xsession \n\
startxfce4 & \n\
" > /home/$USERNAME/.vnc/xstartup
chmod +x /home/$USERNAME/.vnc/xstartup

# start ssh and vnc
/usr/sbin/sshd
rm -rf /tmp/.X*
su - $USERNAME -c "vncserver :0  -rfbport ${VNCPORT} -geometry ${VNCDISPLAY} -depth 24"
rm /run/nologin
echo 'Welcome to KTH EDA tools container';
tail -f /dev/null
