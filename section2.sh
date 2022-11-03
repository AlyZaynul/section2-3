#!/bin/bash

#2.1.4.1
command=$(apt purge ntp -y)
command1=$(apt install ntp -y)
command2=$(sed -i -e 's/restrict -4 default kod notrap nomodify nopeer noquery limited/restrict -4 default kod notrap nomodify nopeer noquery/g'  /etc/ntp.conf)
command3=$(sed -i -e 's/restrict -6 default kod notrap nomodify nopeer noquery limited/restrict -6 default kod notrap nomodify nopeer noquery/g'  /etc/ntp.conf)
command4=$(systemctl unmask ntp.service)
command5=$(systemctl --now enable ntp.service)



#2.2 & 2.3 need to check which services are used by ACTUAL raspberry pi

#while user need to login on raspberry pi, this authentication can already be done by the OS no need for additional service
cmdd=$(apt purge xserver-xorg* -y)

cmmd1=$(systemctl stop avahi-daaemon.service)
cmmd2=$(systemctl stop avahi-daemon.socket)
cmmd3=$(apt purge avahi-daemon)

#as the purpose of the raspberry pi is used for camera streaming and not printing this service can be removed
cmdd1=$(apt purge cups -y)

#not a dhcp server which allocates ip addresses to end devices
cmdd2=$(apt purge isc-dhcp-server -y)

#not a LDAP server
cmdd3=$(apt purge slapd -y)

#raspberry pi is not configured to export NFS shares
cmdd4=$(apt purge nfs-kernel-server -y)

#not a DNS server
cmdd5=$(apt purge bind9 -y)

#not a FTP server
cmdd6=$(apt purge vsftpd -y)

#HTTP server is hosted by client VM not raspberry pi
cmdd7=$(apt purge apache2 -y)

#not a POP3 or IMAP server
cmdd8=$(apt purge dovecot-imapd dovecot-pop3d -y)

#No need the use of SAMBA as there is no mounting on Windows systems happening on the raspberry pi
cmdd9=$(apt purge samba -y)

#no need for a HTTP proxy server
cmdd10=$(apt purge squid -y)

#no need for SNMP server
cmdd11=$(apt purge snmp -y)

#not a NIS server
cmdd12=$(apt purge nis -y)

#2.2.15 NOT sure if need to be done

#2.2.16
cmdd13=$(systemctl stop rsync)
cmdd14=$(systemctl mask rsync)

#not using nis client
cmdd15=$(apt purge nis -y)

#not using rsh rather using a more secure ssh to remote into raspberry pi
cmdd16=$(apt purge rsh-client -y)


#not using talk client
cmdd17=$(apt purge talk -y)

#not using telnet using ssh instead
cmdd18=$(apt purge telnet -y)

#not using LDAP client
cmdd19=$(apt purge ldap-utils -y)

#not using RPC
cmdd20=$(apt purge rpcbind -y)
