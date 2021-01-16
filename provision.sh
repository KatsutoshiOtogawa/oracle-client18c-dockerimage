dnf -y update

# install firewalld. firewalld is rhel,centos default dynamic firewall.
dnf -y install firewalld

# enabla firewalld.
systemctl enable firewalld
systemctl start firewalld

# if you are want to port forwarding, you write below 


# reload firewall settings.
firewall-cmd --reload

# add OL7 AND OL7 instantclient repository install for oracle instant client
dnf config-manager --add-repo https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/
dnf config-manager --add-repo https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/

# dependency oracle-instantclient18.5-basic
dnf -y install libaio libnsl

# install oracle instant client libraly. this package is nosignature.
dnf download oracle-instantclient18.5-devel oracle-instantclient18.5-basic oracle-instantclient18.5-sqlplus
rpm -ivh oracle-instantclient18.5-devel*.rpm oracle-instantclient18.5-basic*.rpm oracle-instantclient18.5-sqlplus*.rpm --nosignature

echo /usr/lib/oracle/18.5/client64/lib > /etc/ld.so.conf.d/oracle-instantclient18.5.conf && ldconfig

# for use oracle instant client

echo '# oracle instant client' >> ~/.bash_profile
echo PATH=\$PATH:/usr/lib/oracle/18.5/client64/bin >> ~/.bash_profile

su - vagrant -c "echo '# oracle instant client' >> ~/.bash_profile"
su - vagrant -c "echo PATH=\$PATH:/usr/lib/oracle/18.5/client64/bin >> ~/.bash_profile"

# add setting connecting to XEPDB1 pragabble dababase.
# cat << END >> $ORACLE_HOME/network/admin/tnsnames.ora
# XEPDB1 =
#   (DESCRIPTION =
#     (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
#     (CONNECT_DATA =
#       (SERVER = DEDICATED)
#       (SERVICE_NAME = XEPDB1)
#     )
#   )
# END


# clean container
rm oracle-instantclient18.5-devel*.rpm oracle-instantclient18.5-basic*.rpm oracle-instantclient18.5-sqlplus*.rpm
dnf clean packages

