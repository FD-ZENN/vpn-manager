#!/bin/bash

CONFIG_FILE="/etc/vpn-manager.conf"

# ================================

# LOAD CONFIG

# ================================

load_config() {
if [ -f "$CONFIG_FILE" ]; then
source $CONFIG_FILE
fi
}

# ================================

# SAVE CONFIG

# ================================

save_config() {
cat > $CONFIG_FILE <<EOF
VPN_SERVER="$VPN_SERVER"
VPN_USER="$VPN_USER"
VPN_PASS="$VPN_PASS"
VPN_PSK="$VPN_PSK"
EOF
}

# ================================

# SETUP VPN

# ================================

setup_vpn() {
echo "=== INPUT DATA VPN ==="
read -p "Server IP: " VPN_SERVER
read -p "Username : " VPN_USER
read -p "Password : " VPN_PASS
read -p "PSK      : " VPN_PSK

```
save_config

echo "[+] Installing package..."
apt update -y
apt install strongswan xl2tpd ppp -y

echo "[+] Config IPsec..."
cat > /etc/ipsec.conf <<EOF
```

config setup
charondebug="ike 1, knl 1, cfg 0"

conn l2tp-ipsec
keyexchange=ikev1
authby=secret
type=transport
left=%defaultroute
right=$VPN_SERVER
ike=aes128-sha1-modp1024!
esp=aes128-sha1!
auto=add
EOF

```
cat > /etc/ipsec.secrets <<EOF
```

: PSK "$VPN_PSK"
EOF

```
echo "[+] Config L2TP..."
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
```

[global]
listen-addr = 0.0.0.0

[lac vpn]
lns = $VPN_SERVER
pppoptfile = /etc/ppp/options.l2tpd.client
redial = yes
redial timeout = 5
max redials = 3
EOF

```
echo "[+] Config PPP..."
cat > /etc/ppp/options.l2tpd.client <<EOF
```

ipcp-accept-local
ipcp-accept-remote
refuse-eap
noccp
noauth
mtu 1400
mru 1400
noipdefault
defaultroute
usepeerdns
connect-delay 5000

name $VPN_USER
password $VPN_PASS
EOF

```
echo "$VPN_USER * $VPN_PASS *" > /etc/ppp/chap-secrets
chmod 600 /etc/ppp/chap-secrets

systemctl restart strongswan-starter
systemctl restart xl2tpd

echo "[✓] Setup selesai!"
```

}

# ================================

# CONNECT

# ================================

connect_vpn() {
load_config
echo "[+] Connecting..."
ipsec up l2tp-ipsec
sleep 3
echo "c vpn" > /var/run/xl2tpd/l2tp-control
}

# ================================

# DISCONNECT

# ================================

disconnect_vpn() {
echo "[+] Disconnecting..."
echo "d vpn" > /var/run/xl2tpd/l2tp-control
ipsec down l2tp-ipsec
}

# ================================

# STATUS

# ================================

status_vpn() {
echo "=== STATUS VPN ==="
ip a | grep ppp0 && echo "VPN: CONNECTED" || echo "VPN: DISCONNECTED"
}

# ================================

# RESET

# ================================

reset_vpn() {
echo "[!] Reset semua config VPN..."
rm -f /etc/ipsec.conf
rm -f /etc/ipsec.secrets
rm -f /etc/xl2tpd/xl2tpd.conf
rm -f /etc/ppp/options.l2tpd.client
rm -f /etc/ppp/chap-secrets
rm -f $CONFIG_FILE
systemctl restart strongswan-starter
systemctl restart xl2tpd
echo "[✓] Reset selesai!"
}

# ================================

# MENU

# ================================

menu() {
clear
echo "============================"
echo "   VPN MANAGER TERMINAL"
echo "============================"
echo "1. Setup / Ganti VPN"
echo "2. Connect VPN"
echo "3. Disconnect VPN"
echo "4. Status VPN"
echo "5. Reset Config"
echo "0. Exit"
echo "============================"
read -p "Pilih menu: " pilihan

```
case $pilihan in
    1) setup_vpn ;;
    2) connect_vpn ;;
    3) disconnect_vpn ;;
    4) status_vpn ;;
    5) reset_vpn ;;
    0) exit ;;
    *) echo "Pilihan tidak valid" ;;
esac

read -p "Tekan ENTER untuk kembali..."
menu
```

}

menu
