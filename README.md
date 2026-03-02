# Путь  Социальная платформа для практик саморазвития 

<p align="center">
  <img src="https://myvay.ru/storage/app/public/logo.png" alt="Мой путь logo" width="200">
</p>

<p align="center">
  <a href="https://myvay.ru"><img src="https://img.shields.io/badge/live-demo-brightgreen.svg" alt="Live Demo"></a>
  <a href="https://github.com/inrayzex/put-path/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License"></a>
  <a href="https://laravel.com"><img src="https://img.shields.io/badge/Laravel-12-red.svg" alt="Laravel"></a>
  <a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-ready-blue.svg" alt="Docker"></a>
</p>

##  О проекте

**Мой путь**  это полноценная социальная платформа для людей, практикующих саморазвитие. Проект сочетает в себе трекер привычек, ленту активности, клубы по интересам и базу знаний, объединённые единой экосистемой.

**Ключевая особенность:** Полностью контейнеризированное приложение (Docker) с PWA-поддержкой и push-уведомлениями через Firebase, готовое к масштабированию.

###  Функциональность

- ** Пользователи**: регистрация, авторизация через Sanctum, настройка профиля (аватар, статус, цитата), приватность трекеров и постов.
- ** Трекер практик**:
  - Ежедневные и еженедельные цели
  - Поддержка количественных и бинарных (выполнено/не выполнено) практик
  - Автоматический подсчёт streak'ов (серий)
  - Режим Аскеза с заданной продолжительностью
  - Напоминания с возможностью выбора канала (push/email)
- ** Социальная сеть**:
  - Лента постов с настройкой приватности (только я/друзья/все)
  - Лайки, комментарии, подписки на пользователей
  - Клубы по интересам с собственными постами и чатом
- ** База знаний**:
  - Статьи с RichEditor-форматированием, категориями и изображениями
  - Рекомендации книг/видео (управляются через админку)
  - Глоссарий терминов
- ** PWA и уведомления**:
  - Progressive Web App с установкой на рабочий стол
  - Push-уведомления через Firebase Cloud Messaging (работают даже при закрытом приложении)
  - Дедупликация уведомлений на уровне Service Worker'а
- ** Админ-панель**: Filament для управления контентом (статьи, рекомендации, пользователи)

---

##  Архитектура и технологии

<p align="center">
  <img src="./readme_assets/architecture.png" alt="Архитектура" width="80%">
</p>

### **Бэкенд**
- **Laravel 12**  основной фреймворк
- **PostgreSQL 13**  основная БД
- **Redis 7**  кэш, сессии, очереди
- **Laravel Sanctum**  API-аутентификация
- **Filament 3**  административная панель

### **Фронтенд**
- Чистый **HTML5/CSS3/JavaScript** (без фреймворков)
- Адаптивная вёрстка (mobile-first)
- **PWA** с сервис-воркером и манифестом
- Интеграция с **Firebase Cloud Messaging**

### **Инфраструктура (DevOps)**
- **Docker + Docker Compose**  полная контейнеризация
- **Nginx**  reverse proxy + статика
- **PHP-FPM**  обработка PHP
- **GitHub**  репозиторий и CI/CD
- **VPS (AlmaLinux 9)**  продакшн-сервер
- **Let's Encrypt**  автоматическое обновление SSL-сертификатов
- **Cron**  планировщик задач (запуск команд внутри контейнера)

---

##  Быстрый старт (локальная разработка)

### Предварительные требования

- Установленные [Docker](https://www.docker.com/) и [Docker Compose](https://docs.docker.com/compose/)
- Аккаунт в [Firebase](https://console.firebase.google.com/) (для уведомлений)
- Git

### Установка и запуск

1. **Клонируйте репозиторий**
   ```bash
   git clone https://github.com/inrayzex/put-path.git
   cd put-path

   cd put-path
   ```

2. **Настройте окружение**
   ```bash
   cp .env.example .env
   ```

3. **Запустите контейнеры**
   ```bash
   docker-compose up -d
   ```

4. **Установите зависимости Composer**
   ```bash
   docker exec -it put_app composer install
   ```

5. **Сгенерируйте ключ приложения**
   ```bash
   docker exec -it put_app php artisan key:generate
   ```

6. **Выполните миграции**
   ```bash
   docker exec -it put_app php artisan migrate
   ```

7. **Создайте администратора (опционально)**
   ```bash
   docker exec -it put_app php artisan make:filament-user
   ```

8. **Настройте симлинк для storage**
   ```bash
   docker exec -it put_app php artisan storage:link
   ```
Приложение будет доступно по адресу: http://localhost

🐳 Контейнеризация (детали)
Проект использует многоконтейнерную архитектуру:

Контейнер	Назначение	Зависимости
put_app	PHP-FPM с Laravel	postgres, redis
put_nginx	Веб-сервер	app
put_postgres	База данных PostgreSQL	—
put_redis	Кэш, сессии, очереди	—
Основные Docker-команды
bash
# Сборка и запуск
docker-compose up -d --build

# Остановка
docker-compose down

# Просмотр логов
docker-compose logs -f [service_name]

# Вход в контейнер
docker exec -it put_app bash

📱 PWA и уведомления (Firebase)
Настройка Firebase
Создайте проект в Firebase Console

Добавьте веб-приложение и скопируйте конфигурацию

В разделе Cloud Messaging сгенерируйте VAPID-ключ

Скачайте Service Account JSON и поместите в storage/app/firebase/

Файлы PWA
/public/manifest.json — конфигурация установки

/public/sw.js — базовый сервис-воркер

/public/firebase-messaging-sw.js — воркер для уведомлений

Дедупликация уведомлений
В проекте реализована защита от двойных уведомлений: сервис-воркер сохраняет ID полученных сообщений в кэше и игнорирует повторы.

📄 Лицензия
Проект распространяется под лицензией MIT. Подробнее см. в файле LICENSE.

📞 Контакты и ссылки
Демо-сайт: https://myvay.ru

GitHub: https://github.com/inrayzex/put-path

Email: inrayzex@gmail.com


