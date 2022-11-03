#!/bin/bash

#2.1.4.1
command=$(apt purge ntp -y)
command1=$(apt install ntp -y)
command2=$(sed -i -e 's/restrict -4 default kod notrap nomodify nopeer noquery limited/restrict -4 default kod notrap nomodify nopeer noquery/g'  /etc/ntp.conf)
command3=$(sed -i -e 's/restrict -6 default kod nomodify notrap nopeer noquery/restrict -6 default kod notrap nomodify nopeer noquery/g'  /etc/ntp.conf)
command4=$(systemctl unmask ntp.service)
command5=$(systemctl --now enable ntp.service)



#2.2 & 2.3 need to check which services are used by ACTUAL raspberry pi

#while user need to login on raspberry pi, this authentication can already be done by the OS no need for additional service
cmdd=$(apt purge xserver-xorg* -y)

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



#3.1 & 3.2 need to check which network interface/ network features used


#3.1.2 cannot be disabled

#3.1.4
comp=$(bash 3-1-4.sh)

#3.1.5
comp1=$(bash 3-1-5.sh)

#3.1.6
comp2=$(bash 3-1-6.sh)




#3.2.1 Disabled as raspberry pi is not suppose to provide information for routing information as it is not a counter 
#just configured as an end device
#Not sure if this method is correct
comp3=$(bash 3-2-1.sh)

#cmd20=$(echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf)
#cmd21=$(echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf)


comp4=$(bash 3-2-2.sh 2> /dev/null)

#3.2.2 As it is an end device it is not supposed to tell a system if it can forward packets to it or not
#cmd22=$(echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf)
#cmd23=$(echo "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.conf)
#cmd24=$(sysctl -p)



#STOPPED HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




#3.3.1 Not sure if these commands work

#cmd25=$(sysctl -w net.ipv4.conf.all.accept_source_route=0)
#cmd26=$(sysctl -w net.ipv4.conf.default.accept_source_route=0)

#cmd27=$(sysctl -w net.ipv6.conf.all.accept_source_route=0)
#cmd28=$(sysctl -w net.ipv6.conf.default.accept_source_route=0)
#cmd29=$(sysctl -w net.ipv4.route.flush=1)
#cmd30=$(sysctl -w net.ipv6.route.flush=1)
cmd25=$(bash 3-3-1.sh)
cmd26=$(bash 3-3-2.sh)
cmd27=$(bash 3-3-3.sh)
cmd28=$(bash 3-3-4.sh)
cmd29=$(bash 3-3-5.sh)
cmd30=$(bash 3-3-6.sh)
comp5=$(bash 3-3-7.sh)
comp6=$(bash 3-3-8.sh)
comp7=$(bash 3-3-9.sh)






#Skipped till now 3.5.1.1 UFW 
cmd31=$(apt install ufw -y)
cmd32=$(apt purge iptables-persistent -y)
cmd33=$(systemctl unmask ufw.service)
cmd34=$(systemctl --now enable ufw.service)
cmd35=$(ufw enable)
cmd36=$(ufw allow in on lo)
cmd37=$(ufw allow out on lo)
cmd38=$(ufw deny in from 127.0.0.0/8)
cmd39=$(ufw deny in from ::1)
cmd40=$(ufw allow out on all)
cmdssh=$(sudo ufw allow OpenSSH)
cmdvnc=$(ufw allow from 192.168.215.0/24 to any port 5900)


#3.5.1.6 creating ufw for open ports (5900,8081,22) 631 not inside as it used for CUPS service which has been removed

cmd41=$(ufw default deny incoming)
cmd42=$(ufw default allow outgoing)
cmd43=$(ufw default deny routed)

#3.5.2.1 As UFW has already been configured nftables is not configured as it could cause errors due to both of the services running simultaneously
#comp8=(apt install nftables -y)




#3.5.3.1.1 As UFW has already been configured nftables is not configured as it could cause errors due to both of the services running simultaneously
#comp8=$(




#done in run_after_hardening.sh

#4.1.4.1 is in 2nd script
