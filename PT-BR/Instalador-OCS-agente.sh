#!/bin/bash

# Atualiza e faz upgrade dos pacotes
echo "Atualizando e fazendo upgrade dos pacotes..."
sudo apt update -y
sudo apt upgrade -y

# Instala o expect para automatizar a instalação
echo "Instalando o expect..."
sudo apt-get install -y expect

# Baixa o script expect
echo "Baixando o script expect..."
cat <<EOF > expect.exp
#!/usr/bin/expect -f

# Define o tempo de espera
set timeout -1

# Inicia o comando
spawn sudo perl Makefile.PL

# Responde automaticamente às perguntas
expect "Do you want to continue? [y/N] "
send "y\r"

expect "Choose installation directory:"
send "2\r"

expect "Do you want to install required Perl modules? [y/N] "
send "y\r"

expect "Do you want to configure the OCS Inventory Agent now? [y/N] "
send "y\r"

expect "Enter the OCS Inventory server URL:"
send "http://10.0.5.121/ocsinventory\r"

expect "Do you want to enable the OCS Inventory Agent service now? [y/N] "
send "y\r"

# Finaliza a interação
expect eof
EOF

# Torna o script expect executável e executa
chmod +x expect.exp
echo "Executando o script expect..."
./expect.exp

# Instala os pacotes necessários
echo "Instalando pacotes necessários..."
sudo apt install -y make gcc libmodule-install-perl dmidecode libxml-simple-perl libcompress-zlib-perl openssl libnet-ip-perl libwww-perl libdigest-md5-perl libdata-uuid-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl net-tools libsys-syslog-perl pciutils smartmontools read-edid nmap libnet-netmask-perl

# Baixa o arquivo
echo "Baixando o arquivo do agente OCS Inventory..."
sudo wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.10.2/Ocsinventory-Unix-Agent-2.10.2.tar.gz

# Extrai o arquivo
echo "Extraindo o arquivo..."
sudo tar -xvf Ocsinventory-Unix-Agent-2.10.2.tar.gz

# Muda para o diretório extraído
cd Ocsinventory-Unix-Agent-2.10.2

# Compila e instala o pacote
echo "Compilando e instalando o pacote..."
sudo perl Makefile.PL
sudo make
sudo make install

echo "Instalação concluída com sucesso!"
