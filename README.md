# StaticJinjaPlus-docker
StaticJinjaPlus docker images

Репозиторий содержит dockerfile для создания различных образов StaticJinjaPlus

Для запуска:

Установите docker

```
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker
```
Скопируйте репозиторий. Соберите образ командой
```
$ docker build --build-arg VERSION=<version> --build-arg BASE=<base> -t <image_name> .
```
Доступные варианты:

VERSION:
- latest(default)
- 0.1.0
- 0.1.1
- develop

BASE:
- ubuntu
- python3.10-slim(default)

То есть для запуска latest версии на python3.10-slim достаточно выполнить
```
$ docker build -t <image_name> .
```

Для запуска полученного образа выполните
```
$ docker run -it <image_name>
```
Должно получиться:

<img width="517" height="115" alt="изображение" src="https://github.com/user-attachments/assets/be8e99ec-ec96-4829-b8ca-9ceac37d577b" />





