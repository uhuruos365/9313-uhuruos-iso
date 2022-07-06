#!/usr/bin/env bash
#
# Yamada Hayao
# Twitter: @Hayao0819
# Email  : hayao@fascode.net
#
# (c) 2019-2021 Fascode Network.
#

# Replace wallpaper.
#if [[ -f /usr/share/backgrounds/xfce/xfce-verticals.png ]]; then
#    remove /usr/share/backgrounds/xfce/xfce-verticals.png
#    ln -s /usr/share/backgrounds/arch-logo-dark/ALDark1.png /usr/share/backgrounds/xfce/xfce-verticals.png
#fi
#[[ -f /usr/share/backgrounds/arch-logo-dark/ALDark1.png ]] && chmod 644 /usr/share/backgrounds/arch-logo-dark/ALDark1.png


# Replace right menu
if [[ "${language}" = "ja" ]]; then
    remove "/etc/skel/.config/Thunar/uca.xml"
    remove "/home/${username}/.config/Thunar/uca.xml"

    mv "/etc/skel/.config/Thunar/uca.xml.jp" "/etc/skel/.config/Thunar/uca.xml"
    mv "/home/${username}/.config/Thunar/uca.xml.jp" "/home/${username}/.config/Thunar/uca.xml"
else
    remove "/etc/skel/.config/Thunar/uca.xml.jp"
    remove "/home/${username}/.config/Thunar/uca.xml.jp"
fi

# Create Zeronet user.
useradd --system --user-group -m --home /var/lib/zeronet zeronet
usermod -a -G tor zeronet

# Enable some Services

_safe_systemctl mask systemd-timesyncd.service
_safe_systemctl enable iptables.service macspoof.service NetworkManager.service dnsmasq.service secure-time-sync.service onion-grater.service

#mask tor and zeronet
_safe_systemctl mask tor.service zeronet.service

# Change Theme

#sed -i -E 's@(^    <property name="theme" type="string" value=").*("/>$)@\1Midnight-BlueNight\2@g' "/home/${username}/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"
#sed -i -E 's@(^    <property name="ThemeName" type="string" value=").*("/>$)@\1Midnight-BlueNight\2@g' "/home/${username}/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"