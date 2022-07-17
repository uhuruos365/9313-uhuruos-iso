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

VERSION_WHO='16.0.5.3'

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

# Whonix gateway download & install

URL="https://download.whonix.org/ova/$VERSION_WHO/Whonix-XFCE-$VERSION_WHO.ova" 
filename="./Whonix-XFCE-$VERSION_WHO.ova"

wget $URL
vboxmanage import $filename --vsys 0 --eula accept --vsys 1 --eula accept
rm $filename


# Change Theme

#sed -i -E 's@(^    <property name="theme" type="string" value=").*("/>$)@\1Midnight-BlueNight\2@g' "/home/${username}/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml"
#sed -i -E 's@(^    <property name="ThemeName" type="string" value=").*("/>$)@\1Midnight-BlueNight\2@g' "/home/${username}/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml"