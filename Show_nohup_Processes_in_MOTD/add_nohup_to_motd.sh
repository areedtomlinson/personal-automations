cp /etc/motd_BASE /etc/motd
echo "\nCommands currently running under nohup:\n" >> /etc/motd
lsof | grep nohup.out | awk '{print $2}' | sort -u | while read i; do ps -o args= $i; done | grep -v "no pwd entry for UID" | awk '$0="  --> "$0' >> /etc/motd
echo "\n\n" >> /etc/motd
