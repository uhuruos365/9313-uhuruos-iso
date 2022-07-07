#
# Uhuru OS shell script
#
# infoengine1337
# Twitter: @infoengine1337

# Enable some Services

_safe_systemctl mask systemd-timesyncd.service
_safe_systemctl enable iptables.service macspoof.service NetworkManager.service dnsmasq.service secure-time-sync.service onion-grater.service kloak.service
_safe_systemctl mask tor.service

# Tor Initializer

chmod +x /usr/lib/obscurix/obscurix-startup
