export USERNAME=dockeruser
export USERPASSWORD=dummypsw

mkdir -p /var/run/sshd
ssh-keygen -A
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config


# start ssh and vnc
/usr/sbin/sshd
rm -rf /tmp/.X*
su - $USERNAME -c "vncserver :1 -geometry 1280x1024 -depth 24 -SecurityTypes None"
rm /run/nologin
tail -f /dev/null
