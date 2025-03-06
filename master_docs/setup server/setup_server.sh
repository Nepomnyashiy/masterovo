#!/bin/bash

# === 1. Обновление системы ===
echo "🔄 Обновление системы..."
sudo apt update && sudo apt upgrade -y

# === 2. Установка необходимых пакетов ===
echo "📦 Установка утилит..."
sudo apt install -y curl wget git unzip htop ufw fail2ban gnupg lsb-release ca-certificates software-properties-common rsync

# === 3. Создание пользователя с sudo ===
read -p "Введите имя нового пользователя: " NEW_USER
sudo adduser $NEW_USER
sudo usermod -aG sudo $NEW_USER
sudo usermod -aG docker $NEW_USER
echo "✅ Пользователь $NEW_USER добавлен в sudo и Docker."

# === 4. Настройка SSH ===
echo "🔒 Настройка SSH..."
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd
echo "✅ Root доступ отключен, только ключи SSH!"

# === 5. Настройка брандмауэра (UFW) ===
echo "🚀 Настройка брандмауэра..."
sudo ufw allow OpenSSH
sudo ufw allow 80,443/tcp  # HTTP / HTTPS
sudo ufw allow 4000/tcp  # Backend API
sudo ufw allow 3000/tcp  # Frontend
sudo ufw allow 9090/tcp  # Prometheus
sudo ufw allow 3001/tcp  # Grafana
sudo ufw allow 9100/tcp  # Node Exporter
sudo ufw enable
echo "✅ UFW настроен."

# === 6. Установка Docker и Docker Compose ===
echo "🐳 Установка Docker и Docker Compose..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable --now docker
echo "✅ Docker и Docker Compose установлены."

# === 7. Создание структуры каталогов ===
echo "📁 Создание каталогов проекта..."
PROJECT_DIR="/home/$NEW_USER/masterovo"
mkdir -p $PROJECT_DIR/{backend,frontend,blockchain,storage,logs,devops,monitoring,database,security,backup}
mkdir -p $PROJECT_DIR/backend/{src,config,test}
mkdir -p $PROJECT_DIR/frontend/{src,public,components,pages,store}
mkdir -p $PROJECT_DIR/blockchain/{solana,polygon,deploy}
mkdir -p $PROJECT_DIR/storage/{postgres,mongo,redis,ipfs}
mkdir -p $PROJECT_DIR/logs/{nginx,backend,frontend}
mkdir -p $PROJECT_DIR/devops/{docker,kubernetes,ansible,ci-cd}
mkdir -p $PROJECT_DIR/monitoring/{prometheus,grafana,loki,promtail}
mkdir -p $PROJECT_DIR/database/{migrations,seeders}
mkdir -p $PROJECT_DIR/security/{secrets,nginx}
echo "✅ Каталоги созданы!"

# === 8. Установка PostgreSQL, Redis, Prometheus, Grafana ===
echo "📦 Установка PostgreSQL, Redis, Prometheus, Grafana..."
sudo apt install -y postgresql redis-server prometheus grafana
sudo systemctl enable --now postgresql redis-server prometheus grafana
echo "✅ БД и мониторинг установлены."

# === 9. Настройка fail2ban ===
echo "🔒 Настройка fail2ban..."
sudo systemctl enable --now fail2ban
echo "[sshd]" | sudo tee /etc/fail2ban/jail.local
echo "enabled = true" | sudo tee -a /etc/fail2ban/jail.local
echo "bantime = 3600" | sudo tee -a /etc/fail2ban/jail.local
echo "findtime = 600" | sudo tee -a /etc/fail2ban/jail.local
echo "maxretry = 3" | sudo tee -a /etc/fail2ban/jail.local
sudo systemctl restart fail2ban
echo "✅ Защита от брутфорса включена!"

# === 10. Настройка резервного копирования БД и логов ===
echo "🛠 Настройка резервного копирования..."
BACKUP_DIR="$PROJECT_DIR/backup"
mkdir -p $BACKUP_DIR

# Скрипт для резервного копирования PostgreSQL и логов
BACKUP_SCRIPT="$BACKUP_DIR/backup.sh"
echo "#!/bin/bash" > $BACKUP_SCRIPT
echo "TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')" >> $BACKUP_SCRIPT
echo "pg_dumpall -U postgres > $BACKUP_DIR/postgres_backup_\$TIMESTAMP.sql" >> $BACKUP_SCRIPT
echo "tar -czf $BACKUP_DIR/logs_backup_\$TIMESTAMP.tar.gz $PROJECT_DIR/logs" >> $BACKUP_SCRIPT
echo "echo '✅ Бэкап завершен: \$TIMESTAMP'" >> $BACKUP_SCRIPT
chmod +x $BACKUP_SCRIPT

# Добавление в cron для ежедневного выполнения
(crontab -l 2>/dev/null; echo "0 2 * * * $BACKUP_SCRIPT") | crontab -
echo "✅ Настроено ежедневное резервное копирование БД и логов!"

# === 11. Настройка Swap (если RAM < 8GB) ===
RAM=$(free -m | awk '/^Mem:/{print $2}')
if [ "$RAM" -lt 8000 ]; then
    echo "🛠 Настройка Swap (RAM < 8GB)..."
    sudo fallocate -l 4G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
    echo "✅ Swap (4GB) настроен!"
fi

# === 12. Очистка системы ===
echo "🧹 Очистка ненужных пакетов..."
sudo apt autoremove -y && sudo apt autoclean -y
echo "✅ Сервер подготовлен к работе!"

echo "🎉 Установка завершена! Перезагрузите сервер командой: sudo reboot"
