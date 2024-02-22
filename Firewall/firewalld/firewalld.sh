# firewalld service ubuntu

# Make sure iptables is stopped, disabled and mask, This is also a firewall
# mask command will prevent service for start by third party app/service
systemctl stop iptables
systemctl disable iptables
systemctl mask iptables

# Install firewalld service
apt update -y
apt install firewalld -y
systemctl status firewalld

# Check the rule of firewalld
firewall-cmd --list-all

# Get the listing of all services firewalld is aware of:
firewall-cmd --get-services

# The firewalld has multiple zone, to get a list of all zones
firewall-cmd --get-zones

# To get a list of active zones
firewall-cmd --get-active-zones

# To get firewall rules for public zone
firewall-cmd --zone=public --list-all
OR
firewall-cmd --list-all

# To add a service (http)
firewall-cmd --add-service=http

# To remove a service
firewall-cmd --remove-service=http

# To reload the firewalld configuration, This will remove temporary added services or reload the configuration.
firewall-cmd --reload

# To add or remove a service permanently
firewall-cmd --add-service=http --permanent
firewall-cmd --remove-service=http --permanent

# To add a service that is not pre-defined by firewalld
cd /usr/lib/firewalld/services/allservices.xml

=> Simply cp any .xml file sap.xml and change the service and port number (32)
=> systemctl restart firewalld
=> firewall-cmd --get-services (to verify new service)
=> Firewall-cmd --add-service=sap

# To add a port
firewall-cmd --add-port=1110/tcp

# To remove a port
firewall-cmd --remove-port=1110/tcp

# To reject incoming traffic from an IP address
firewall-cmd --add-rich-rule='rule family="ipv4" source address=“192.168.0.25" reject'

# To block and unblock ICMP incoming traffic
firewall-cmd --add-icmp-block-inversion
firewall-cmd --remove-icmp-block-inversion

# To block/ubblock outgoing traffic to a specific website/IP address
host -t a www.facebook.com # For find IP address, or ping the website for get IP
firewall-cmd --direct --add-rule ipv4 filter OUTPUT 0 -d 31.13.71.36 -j DROP
firewall-cmd --direct --remove-rule ipv4 filter OUTPUT 0 -d 31.13.71.36 -j DROP

