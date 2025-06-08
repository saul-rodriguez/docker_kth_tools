export USERNAME=dockeruser
export USERPASSWORD=dummypsw

#Configure vnc
mkdir -p /home/$USERNAME/.vnc
echo "irFtOvonFXCFMHCfoHmiY2sVfIOLH1E5" | vncpasswd -f > /home/$USERNAME/.vnc/passwd
chown -R $USERNAME:$USERNAME /home/$USERNAME/.vnc
chmod 600 /home/$USERNAME/.vnc/passwd
dbus-uuidgen | tee /var/lib/dbus/machine-id
printf "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4 &" > /home/$USERNAME/.vnc/xstartup
chmod +x /home/$USERNAME/.vnc/xstartup

# start ssh and vnc
/usr/sbin/sshd
rm -rf /tmp/.X*
su - $USERNAME -c "vncserver :1 -geometry 1280x1024 -depth 24 -SecurityTypes None"
rm /run/nologin
tail -f /dev/null
