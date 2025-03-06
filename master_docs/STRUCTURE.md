### **📌 Структура проекта "мастерово.рф"**

## **📁 Структура каталогов**

```bash
masterovo/
│── backend/                  # Серверная часть (NestJS API)
│   ├── src/
│   │   ├── modules/          # Основные модули API
│   │   │   ├── users/        # Модуль пользователей
│   │   │   ├── auth/         # Авторизация (JWT, OAuth, Web3)
│   │   │   ├── marketplace/  # Торговая площадка (магазины, товары, NFT)
│   │   │   ├── orders/       # Заказы и платежи
│   │   │   ├── blockchain/   # Взаимодействие с Solana/Polygon
│   │   ├── main.ts           # Основной файл запуска
│   │   ├── app.module.ts     # Корневой модуль NestJS
│   ├── config/               # Конфигурационные файлы
│   ├── test/                 # Тесты
│   ├── package.json          # Зависимости NestJS
│   ├── Dockerfile            # Docker-контейнер для backend
│
│── frontend/                 # Клиентская часть (Next.js + Web3.js)
│   ├── public/               # Статические файлы (лого, иконки)
│   ├── src/
│   │   ├── components/       # UI-компоненты
│   │   ├── pages/            # Страницы (SSR, SSG)
│   │   ├── hooks/            # Custom Hooks
│   │   ├── services/         # API-запросы к backend
│   │   ├── store/            # Zustand или Redux
│   ├── package.json          # Зависимости Next.js
│   ├── Dockerfile            # Docker-контейнер для frontend
│
│── blockchain/               # Разработка смарт-контрактов
│   ├── solana/               # Контракты для Solana
│   │   ├── src/
│   │   ├── tests/
│   │   ├── Cargo.toml        # Rust-зависимости
│   │   ├── Anchor.toml       # Конфиг Anchor (Solana)
│   ├── polygon/              # Контракты для Polygon (Ethereum)
│   │   ├── contracts/
│   │   ├── scripts/
│   │   ├── hardhat.config.ts # Конфигурация Hardhat
│   ├── deploy/               # Скрипты для деплоя контрактов
│
│── database/                 # Скрипты миграций БД
│   ├── migrations/
│   ├── seeders/
│   ├── ormconfig.ts          # Настройки TypeORM/Mongoose
│
│── monitoring/               # Системы мониторинга
│   ├── prometheus/           # Конфигурация Prometheus
│   │   ├── prometheus.yml
│   ├── grafana/              # Дашборды и настройки Grafana
│   │   ├── dashboards/
│   │   ├── datasources/
│   ├── loki/                 # Конфигурация Loki (логирование)
│   │   ├── loki-config.yml
│   ├── promtail/             # Агент сбора логов
│   │   ├── promtail-config.yml
│
│── devops/                   # Инфраструктура и CI/CD
│   ├── docker/               # Docker Compose и Dockerfile
│   │   ├── docker-compose.yml
│   ├── kubernetes/           # K8s манифесты (если потребуется)
│   ├── ansible/              # Playbooks Ansible
│   ├── ci-cd/                # CI/CD скрипты (GitHub Actions, GitLab CI)
│
│── security/                 # Безопасность и secrets
│   ├── secrets/              # Ключи, приватные данные
│   ├── .env                  # Переменные окружения
│   ├── nginx/                # Конфигурация Nginx
│   │   ├── nginx.conf
│   ├── alertmanager.yml      # Конфигурация Alertmanager
│
│── storage/                  # Данные БД и IPFS
│   ├── postgres/
│   ├── mongo/
│   ├── redis/
│   ├── ipfs/
│
│── logs/                     # Логи сервисов
│   ├── nginx/
│   ├── backend/
│   ├── frontend/
│
│── tests/                    # Интеграционные и e2e тесты
│
│── README.md                 # Документация проекта
```

---

## **📌 Описание разделов**

### **1️⃣ ********`backend/`******** – API на NestJS**

📌 Обрабатывает **запросы от фронтенда** и **взаимодействует с блокчейном и базами данных**.

- **Auth** – регистрация через **VK, Google, Web3-кошельки**
- **Marketplace** – API для **магазинов, товаров, NFT**
- **Blockchain** – API для **интеграции с Solana/Polygon**
- **Orders** – обработка **транзакций в токенах**
- **WebSockets** – **real-time обновления (лайки, чаты, покупки)**

---

### **2️⃣ ********`frontend/`******** – Next.js + Web3.js**

📌 **SSR/SSG-рендеринг** для скорости + **интеграция Web3.js** для взаимодействия с блокчейном.

- **Компоненты UI** – для **магазинов, товаров, NFT**
- **Redux/Zustand** – управление состоянием
- **Web3.js** – взаимодействие с **Solana/Polygon**

---

### **3️⃣ ********`blockchain/`******** – смарт-контракты**

📌 **Смарт-контракты для токенов (SPL/ERC-20) и NFT (SPL/ERC-721)**

- **Solana (Rust + Anchor)**
- **Polygon (Solidity + Hardhat)**
- **Deploy-скрипты**

---

### **4️⃣ ********`monitoring/`******** – Метрики и логи**

📌 **Сбор и анализ метрик и логов**

- **Prometheus** – сбор метрик
- **Grafana** – дашборды
- **Loki + Promtail** – **система логирования**

---

### **5️⃣ ********`devops/`******** – Развертывание**

📌 **Скрипты для автоматического развертывания**

- **Docker Compose** – локальный запуск
- **Kubernetes (K8s)** – кластерное развертывание
- **Ansible** – автоматизация серверов
- **CI/CD (GitHub Actions, GitLab CI)**

---

### **6️⃣ ********`security/`******** – Безопасность**

📌 **Хранение секретных данных и конфигураций**

- **Secrets** – закрытые ключи
- **.env** – переменные окружения
- **Nginx конфигурация**

---
