# iptables -F -t raw

iptables \
  -t raw --append PREROUTING \
  -m recent --name knocked --rcheck --seconds 600 \
  -j ACCEPT

iptables \
  -t raw --append PREROUTING \
  -p udp --dport 30000 \
  -m string --string "OpenSesame" --algo bm \
  -m recent --name knocked --set \
  -j DROP

iptables \
  -t raw --append PREROUTING \
  -j DROP

# cat /proc/net/xt_recent/knocked
