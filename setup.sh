#!/bin/bash

# Функция для вывода сообщений
print_message() {
    echo -e "\n\033[1;34m$1\033[0m\n"
}

# Функция для проверки успешности выполнения команды
check_success() {
    if [ $? -eq 0 ]; then
        echo -e "\033[1;32mУспешно!\033[0m"
    else
        echo -e "\033[1;31mОшибка! Процесс остановлен.\033[0m"
        exit 1
    fi
}

# Функция для обновления системы
update_system() {
    print_message "Обновление списка пакетов..."
    
    # Определение используемого пакетного менеджера
    if command -v apt &> /dev/null; then
        # Debian/Ubuntu
        sudo apt update
        check_success
        print_message "Обновление пакетов..."
        sudo apt upgrade -y
        check_success
    elif command -v dnf &> /dev/null; then
        # Fedora/RHEL/CentOS 8+
        sudo dnf check-update
        print_message "Обновление пакетов..."
        sudo dnf upgrade -y
        check_success
    elif command -v yum &> /dev/null; then
        # CentOS/RHEL
        sudo yum check-update
        print_message "Обновление пакетов..."
        sudo yum update -y
        check_success
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        sudo pacman -Sy
        check_success
        print_message "Обновление пакетов..."
        sudo pacman -Su --noconfirm
        check_success
    elif command -v zypper &> /dev/null; then
        # openSUSE
        sudo zypper refresh
        check_success
        print_message "Обновление пакетов..."
        sudo zypper update -y
        check_success
    else
        echo "Не удалось определить пакетный менеджер. Обновление пропущено."
    fi
}

# Функция для установки Node.js
install_nodejs() {
    print_message "Установка Node.js..."
    
    # Проверка, установлен ли уже Node.js
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v)
        echo "Node.js $NODE_VERSION уже установлен."
        
        # Спрашиваем, хочет ли пользователь переустановить
        read -p "Хотите переустановить Node.js? (y/n): " REINSTALL
        if [[ "$REINSTALL" != "y" && "$REINSTALL" != "Y" ]]; then
            return
        fi
    fi
    
    # Определение используемого пакетного менеджера
    if command -v apt &> /dev/null; then
        # Debian/Ubuntu
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        check_success
        sudo apt install -y nodejs
        check_success
    elif command -v dnf &> /dev/null; then
        # Fedora/RHEL/CentOS 8+
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
        check_success
        sudo dnf install -y nodejs
        check_success
    elif command -v yum &> /dev/null; then
        # CentOS/RHEL
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
        check_success
        sudo yum install -y nodejs
        check_success
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        sudo pacman -S --noconfirm nodejs npm
        check_success
    elif command -v zypper &> /dev/null; then
        # openSUSE
        sudo zypper install -y nodejs
        check_success
    else
        # Установка с помощью NVM для других дистрибутивов
        print_message "Установка NVM и Node.js..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        check_success
        
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        nvm install --lts
        check_success
    fi
    
    # Проверка установки
    NODE_VERSION=$(node -v)
    print_message "Node.js $NODE_VERSION успешно установлен!"
    
    # Установка популярных пакетов npm
    print_message "Установка популярных пакетов npm..."
    
    npm install -g npm@latest
    npm install -g yarn
    npm install -g pm2
    npm install -g nodemon
    npm install -g typescript
    npm install -g express-generator
    npm install -g create-react-app
    npm install -g @vue/cli
    
    print_message "Популярные пакеты npm установлены!"
}

# Функция для установки Python
install_python() {
    print_message "Установка Python..."
    
    # Определение используемого пакетного менеджера
    if command -v apt &> /dev/null; then
        # Debian/Ubuntu
        sudo apt install -y python3 python3-pip python3-venv
        check_success
    elif command -v dnf &> /dev/null; then
        # Fedora/RHEL/CentOS 8+
        sudo dnf install -y python3 python3-pip
        check_success
    elif command -v yum &> /dev/null; then
        # CentOS/RHEL
        sudo yum install -y python3 python3-pip
        check_success
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        sudo pacman -S --noconfirm python python-pip
        check_success
    elif command -v zypper &> /dev/null; then
        # openSUSE
        sudo zypper install -y python3 python3-pip
        check_success
    else
        echo "Не удалось определить пакетный менеджер для установки Python."
        return
    fi
    
    # Проверка установки
    PYTHON_VERSION=$(python3 --version)
    print_message "$PYTHON_VERSION успешно установлен!"
    
    # Обновление pip
    print_message "Обновление pip..."
    python3 -m pip install --upgrade pip
    check_success
    
    # Установка популярных пакетов Python
    print_message "Установка популярных пакетов Python..."
    
    python3 -m pip install --user virtualenv
    python3 -m pip install --user requests
    python3 -m pip install --user numpy
    python3 -m pip install --user pandas
    python3 -m pip install --user matplotlib
    python3 -m pip install --user flask
    python3 -m pip install --user django
    python3 -m pip install --user pytest
    
    print_message "Популярные пакеты Python установлены!"
}

# Главное меню
main_menu() {
    clear
    echo -e "\033[1;35m======================================\033[0m"
    echo -e "\033[1;35m       API-NETWORK SETUP        \033[0m"
    echo -e "\033[1;35m======================================\033[0m"
    echo -e "\033[1;36m1. Обновить систему\033[0m"
    echo -e "\033[1;36m2. Установить Node.js и пакеты\033[0m"
    echo -e "\033[1;36m3. Установить Python и библиотеки\033[0m"
    echo -e "\033[1;36m4. Выполнить всё сразу\033[0m"
    echo -e "\033[1;36m0. Выход\033[0m"
    echo -e "\033[1;35m======================================\033[0m"
    echo -ne "\033[1;37mВыберите опцию: \033[0m"
    read choice

    case $choice in
        1)
            update_system
            ;;
        2)
            install_nodejs
            ;;
        3)
            install_python
            ;;
        4)
            update_system
            install_nodejs
            install_python
            ;;
        0)
            print_message "Выход из программы. До свидания!"
            exit 0
            ;;
        *)
            print_message "Неверный выбор. Пожалуйста, попробуйте снова."
            ;;
    esac
    
    echo
    read -p "Нажмите Enter, чтобы продолжить..."
    main_menu
}

# Проверка запуска от имени root
if [ "$(id -u)" -eq 0 ]; then
    print_message "Этот скрипт не рекомендуется запускать напрямую от имени root."
    print_message "Скрипт будет использовать sudo при необходимости."
    read -p "Продолжить выполнение? (y/n): " CONTINUE
    if [[ "$CONTINUE" != "y" && "$CONTINUE" != "Y" ]]; then
        exit 1
    fi
fi

# Запуск главного меню
main_menu 