# 🚀 VPN Manager CLI (L2TP/IPsec Ubuntu)

Tool sederhana berbasis Bash untuk mengelola koneksi **VPN L2TP/IPsec** di Ubuntu Server dengan tampilan menu interaktif di terminal.

---

## ✨ Fitur

* 🎛️ Menu interaktif (CLI GUI)
* 🔄 Ganti / setup server VPN dengan mudah
* 🔌 Connect & Disconnect VPN
* 📊 Cek status koneksi (ppp0)
* 🧹 Reset semua konfigurasi
* 💾 Auto save konfigurasi
* ⚡ Full otomatis (install + config + connect)

---

## 📦 Requirement

* Ubuntu Server 20.04 / 22.04 / 24.04
* Akses root / sudo

---

## ⚙️ Instalasi

```bash
git clone https://github.com/username/vpn-manager.git
cd vpn-manager
chmod +x vpn-manager.sh
sudo ./vpn-manager.sh
```

---

## 🖥️ Tampilan Menu

```
============================
   VPN MANAGER TERMINAL
============================
1. Setup / Ganti VPN
2. Connect VPN
3. Disconnect VPN
4. Status VPN
5. Reset Config
0. Exit
============================
```

---

## 🧩 Cara Pakai

### 1. Setup VPN

Masukkan data:

* Server IP
* Username
* Password
* PSK (IPsec)

Tool akan otomatis:

* install package
* konfigurasi IPsec
* konfigurasi L2TP
* konfigurasi PPP

---

### 2. Connect VPN

Pilih menu:

```
2. Connect VPN
```

---

### 3. Cek Status

```
4. Status VPN
```

Output:

```
VPN: CONNECTED
```

atau

```
VPN: DISCONNECTED
```

---

### 4. Disconnect

```
3. Disconnect VPN
```

---

### 5. Reset Config

Menghapus semua konfigurasi VPN:

```
5. Reset Config
```

---

## 📁 Struktur Config

| File                          | Fungsi              |
| ----------------------------- | ------------------- |
| /etc/ipsec.conf               | Konfigurasi IPsec   |
| /etc/ipsec.secrets            | PSK                 |
| /etc/xl2tpd/xl2tpd.conf       | Konfigurasi L2TP    |
| /etc/ppp/options.l2tpd.client | PPP option          |
| /etc/ppp/chap-secrets         | Username & Password |
| /etc/vpn-manager.conf         | Config tersimpan    |

---

## ⚠️ Catatan Penting

* Menggunakan mode **client (LAC)**:

```
[lac vpn]
```

* Bukan mode server:

```
[lns default] ❌
```

* Error umum:

```
lns not valid in this context
```

➡️ Penyebab: salah mode config

---

## 🔧 Troubleshooting

### ❌ Tidak muncul `ppp0`

Cek:

```bash
ip a
```

### ❌ L2TP gagal

```bash
journalctl -u xl2tpd -n 50
```

### ❌ IPsec gagal

```bash
journalctl -u strongswan -n 50
```

---

## 🔥 Tips

Jika internet tidak jalan setelah connect:

```bash
sudo ip route add default dev ppp0
```

---

## 🚀 Roadmap (Next Update)

* 🎨 Tampilan berwarna (UI CLI)
* 🔁 Auto reconnect
* 📋 Multi server list
* 📊 Monitoring real-time
* 🔐 Support VPN lain (WireGuard, OpenVPN)

---
---

## ⭐ Support

Kalau project ini membantu:

* ⭐ Star repo ini
* 🍴 Fork & modifikasi
* 🐛 Laporkan bug

---

## 📜 License

Free to use & modify 🚀
