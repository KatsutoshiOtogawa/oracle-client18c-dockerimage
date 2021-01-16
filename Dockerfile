FROM fedora:34

RUN dnf -y update

# install for using dnf config-manager
RUN dnf -y install dnf-plugins-core

# add OL7 AND OL7 instantclient repository install for oracle instant client
RUN dnf config-manager --add-repo https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/
RUN dnf config-manager --add-repo https://yum.oracle.com/repo/OracleLinux/OL7/oracle/instantclient/x86_64/

# dependency oracle-instantclient18.5-basic
RUN dnf -y install libaio libnsl

# install oracle instant client libraly. this package is nosignature.
RUN dnf download oracle-instantclient18.5-devel oracle-instantclient18.5-basic oracle-instantclient18.5-sqlplus
RUN rpm -ivh oracle-instantclient18.5-devel*.rpm oracle-instantclient18.5-basic*.rpm oracle-instantclient18.5-sqlplus*.rpm --nosignature

RUN echo /usr/lib/oracle/18.5/client64/lib > /etc/ld.so.conf.d/oracle-instantclient18.5.conf && \
     ldconfig

# for use oracle instant client
ENV PATH=$PATH:/usr/lib/oracle/18.5/client64/bin

# clean container
RUN rm oracle-instantclient18.5-devel*.rpm oracle-instantclient18.5-basic*.rpm oracle-instantclient18.5-sqlplus*.rpm
RUN dnf clean packages
# dnf -y install http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-libcap1-1.10-7.el7.x86_64.rpm
# dnf -y install http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-libstdc++-33-3.2.3-72.el7.x86_64.rpm

