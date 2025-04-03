# ApiNetwork Tools

Этот скрипт является универсальным инструментом для быстрой настройки Linux-системы:
- Обновление системных пакетов
- Установка Node.js с популярными npm-пакетами
- Установка Python с популярными библиотеками

## Быстрый запуск

Вы можете запустить скрипт сразу через curl:

```bash
curl -sSL https://raw.githubusercontent.com/VerTusOffical/apinetworktools/main/setup.sh | bash
```

или загрузить и запустить локально:

```bash
curl -sSL https://raw.githubusercontent.com/VerTusOffical/apinetworktools/main/setup.sh -o setup.sh
chmod +x setup.sh
./setup.sh
```

## Функции

Скрипт предлагает следующие опции:

1. **Обновление системы**: Определяет дистрибутив и использует соответствующий пакетный менеджер
2. **Установка Node.js**: Устанавливает последнюю LTS-версию Node.js и основные npm-пакеты
3. **Установка Python**: Устанавливает Python 3, pip и популярные библиотеки
4. **Всё сразу**: Выполняет все вышеперечисленные операции

## Поддерживаемые дистрибутивы

Скрипт поддерживает основные дистрибутивы Linux:
- Debian/Ubuntu (apt)
- Fedora/RHEL/CentOS 8+ (dnf)
- CentOS/RHEL (yum)
- Arch Linux (pacman)
- openSUSE (zypper)
- Другие дистрибутивы (использует альтернативные методы установки)

## Установка Node.js

Скрипт устанавливает следующие npm-пакеты глобально:
- yarn
- pm2
- nodemon
- typescript
- express-generator
- create-react-app
- vue-cli

## Установка Python

Скрипт устанавливает следующие Python-библиотеки:
- virtualenv
- requests
- numpy
- pandas
- matplotlib
- flask
- django
- pytest 
