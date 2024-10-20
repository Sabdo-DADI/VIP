#!/bin/bash
# Proxy MOD BY NEWBIE
systemctl stop ws ws-ovpn
file_path="/etc/handeling"

# Cek apakah file ada
if [ ! -f "$file_path" ]; then
    # Jika file tidak ada, buat file dan isi dengan dua baris
    echo -e "SPS Server Connected\nGreen" | sudo tee "$file_path" > /dev/null
    echo "File '$file_path' berhasil dibuat."
else
    # Jika file ada, cek apakah isinya kosong
    if [ ! -s "$file_path" ]; then
        # Jika file ada tetapi kosong, isi dengan dua baris
        echo -e "SPS Server Connected\nGreen" | sudo tee "$file_path" > /dev/null
        echo "File '$file_path' kosong dan telah diisi."
    else
        # Jika file ada dan berisi data, tidak lakukan apapun
        echo "File '$file_path' sudah ada dan berisi data."
    fi
fi

# Cek apakah python3 terinstal
if ! command -v python3 &> /dev/null; then
    echo "Python 3 belum terinstal. Menginstal Python 3 sekarang..."
    sudo apt update
    sudo apt install python3 -y
else
    echo "Python 3 sudah terinstal."
fi

# Cek apakah python3-pip terinstal
if ! command -v pip3 &> /dev/null; then
    echo "pip3 belum terinstal. Menginstal pip3 sekarang..."
    sudo apt update
    sudo apt install python3-pip -y
else
    echo "pip3 sudah terinstal."
fi

# Cek dan install requests pada Python 3
if python3 -c "import requests" &> /dev/null; then
    echo "Library 'requests' sudah terinstal untuk Python 3."
else
    echo "Library 'requests' belum terinstal, menginstal sekarang..."
    sudo pip3 install requests
fi

# Link Hosting Kalian
wget -O /usr/local/bin/ws "https://raw.githubusercontent.com/Sabdo-DADI/VIP/main/sshws/ws"
chmod +x /usr/local/bin/ws

# Installing Service
cat > /etc/systemd/system/ws.service << END
[Unit]
Description=Proxy Mod By Newbie Store 
Documentation=https://t.me/newbie_store24
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ws
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws.service
systemctl start ws.service
systemctl restart ws.service

wget -O /usr/local/bin/ws-ovpn "https://raw.githubusercontent.com/Sabdo-DADI/VIP/main/sshws/ws"
chmod +x /usr/local/bin/ws-ovpn

# Installing Service
cat > /etc/systemd/system/ws-ovpn.service << END
[Unit]
Description=Proxy Mod By NEWBIE STORE
Documentation=https://t.me/newbie_store24
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ws-ovpn 2086
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-ovpn
systemctl start ws-ovpn
systemctl restart ws-ovpn

rm insshws.*
