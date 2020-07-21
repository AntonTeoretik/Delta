# Устанавливаем stack
## Инструкция для windows

* Идём на сайт https://docs.haskellstack.org/en/stable/install_and_upgrade/#windows.

* Скачиваем Windows 64-bit Installer
* Устанавливаем stack
* Запустите консоль (win+R, наберите cmd и нажмите Enter)
* Наберите `stack ghc -- -V`. У вас должен начать устанавливаться компилятор.
* Наберите `stack ghci -- -V`. У вас должен начать устанавливаться интерпретатор.

## Инструкция для linux
* Откройте консоль
* `curl -sSL https://get.haskellstack.org/ | sh` либо `wget -qO- https://get.haskellstack.org/ | sh`

# Устанавливаем git

## Windows
* Идём на `https://git-scm.com/download/win`
* Ждем, пока скачается.
* Устанавливаем, следуя всем инструкциям.

## Linux
* Откройте консоль
* `sudo add-apt-repository ppa:git-core/ppa`
* `sudo apt update`
* `sudo apt intall git`
