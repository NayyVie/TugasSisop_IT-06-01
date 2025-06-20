#!/bin/bash

while true; do
 clear
 toilet -f big -F border -F metal "MENUUWW" 
 
echo
echo "1. Tampilkan Tanggal dan Waktu Kehidupan Saat Ini"
echo "2. Tampilkan Daftar Direktori"
echo "3. Informasi Jaringan"
echo "4. Tampilkan Detail OS"
echo "5. Tampilkan Waktu Install Pertama"
echo "6. Informasi User"
echo "7. Keluar"
echo

read -p $'\e[36mPilih Opsi [1-7] : ' opsi
echo

case $opsi in
	1)
	  clear
	  jam=$(date +%H)
	  tanggal=$(date '+%A, %d %B %Y')
	  waktu=$(date '+%r')
	  
	  if (( jam >= 5 && jam < 11 )); then
	  	salam="GOOD MORNING🌄️"
	  elif (( jam >= 11 && jam < 13 )); then
	  	salam="NOONTIME🌞️"
	  elif (( jam >= 13 && jam < 15 )); then
	  	salam="GOOD AFTERNOON🌇️"
	  elif (( jam >= 15 && jam < 19 )); then
	  	salam="GOOD EVENING🌅️"
	  else
	  	salam="GOOD NIGHT🌝️"
	  fi
	  echo -e "\e[35m======= 🗓️ Tanggal dan Waktu Kehidupan Saat Ini =======\e[31m"
	  echo -e "\e[0m$salam"
	  echo "Tanggal : $tanggal"
	  echo "Waktu   : $waktu"
	  ;;
	2)
	  echo -e "\e[32m======= 📄️Daftar Direktori Anda ======= \e[0m"
	  ls -lah
	  ;;
	3)
	  clear
	  ip_local=$(hostname -I | awk '{print $1}')
	  gateway=$(ip r | grep default | awk '{print $3}')
	  subnet=$(ip a | grep inet | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)
	  dns_server=$(nmcli dev show | grep 'IP4.DNS' | awk '{print $2}' | head -n 1)
	  status_net=$(ping -c 1 8.8.8.8 &> /dev/null && echo "Terhubung Ke Internet" || echo "Tidak Terhubung")
	  network_status=$(nmcli device status)
	  lokasi_ip=$(curl -s ipinfo.io | jq -r '.city + "," + .region + "," + .country')
	  
	  echo -e "\e[36m======= 🌐️Informasi Jaringan Anda ======= \e[0m"
	  echo "Alamat IP Lokal  : $ip_local"
	  echo "Gateway          : $gateway"
	  echo "Netmask/Subnet   : $subnet"
	  echo "DNS Server       : $dns_server"
	  echo ""
	  echo -e "\e[36mStatus Koneksi ke Internet : \e[0m"
	  echo "$status_net"
	  echo ""
	  echo -e "\e[36mStatus Koneksi LAN/WIFI    : \e[0m"
	  echo "$network_status"
	  echo ""
	  echo -e "\e[36mLokasi IP : \e[0m"
	  echo "$lokasi_ip"
	  echo ""         
	  ;;
	4)
	  echo -e "\e[33m======= 💻️Detail OS =======\e[0m"
	  echo "Nama OS    : $(lsb_release -i | awk '{print $3}')"
	  echo "Versi      : $(lsb_release -d | cut -f2-)"
	  echo "ID         : $(lsb_release -i | awk '{print tolower($3)}')"
	  echo "Keterangan : $(lsb_release -d | cut -f2-)"
	  echo ""
	  echo -e "\e[33mInformasi Kernel :\e[0m"
	  uname -r
	  echo ""
	  
	  echo -e "\e[33mProses CPU Terakhir :\e[0m"
	  top -bn1 | grep "%Cpu" | head -n1
	  echo ""
	  
	  echo -e "\e[33m💾️Pemakaian Disk :\e[0m"
	  df -h | grep "^/dev"
	  echo ""
	  
	  echo -e "\e[33mPemakaian Memori :\e[0m"
	  free -h
	  ;;
	5)
	  echo -e "\e[34m======= Waktu Install Pertama Anda ======= \e[0m"
	  sudo tune2fs -l /dev/sda2 | grep 'Filesystem created'
	  ;;
	6)
	  echo -e "\e[35m======= 👤️Informasi User ======="
	  Full_Name=$(getent passwd "$(whoami)" | cut -d ':' -f 5 | cut -d ',' -f 1)
	  echo -e "\e[35mUsername  :\e[31m$(whoami)"
	  echo -e "\e[35mFull Name :\e[31m$Full_Name"
	  echo -e "\e[31mUser ID   :\e[31m$(id -u)"
	  echo -e "\e[31mGroup ID  :\e[31m$(id -g)"
	  echo -e "\e[35mHome Direktori :\e[31m"$HOME
	  echo -e "\e[35mShell :\e[31m"$SHELL
	  ;;
	7)
	  clear
	  figlet -f slant "See You!" | boxes -d tux
	  echo ""
	  echo -e "\e[31mTerimakasih Sudah menggunakan menu ini, Balik Lagi Yaaa💖️"
	  sleep 2
	  clear
	  break
	  ;;
	*)
	  echo -e "\e[31mOpsi Tidak Valid⚠️.\e[0m"
	  ;;
      esac

      echo 
      read -p $'\e[32mTekan ENTER untuk kembali ke menu...\e[0m'
done
