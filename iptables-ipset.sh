# iptables -t raw -F

ipset create knocked hash:ip \
  timeout 120 \
  maxelem 2000

iptables \
  -t raw --append PREROUTING \
  -m set --match-set knocked src \
  -j ACCEPT

iptables \
  -t raw --append PREROUTING \
  -p udp --dport 30000 \
  -m string --string "OpenSesame" --algo bm \
  -j SET --add-set knocked src --exist

iptables \
  -t raw --append PREROUTING \
  -j DROP


# watch -n1 ipset list knocked
# watch -n1 iptables -t raw -nvL
