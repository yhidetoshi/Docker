# Waken install for Docker

### Dockerのインストール
$ sudo yum install -y docker
$ sudo pip install -U docker-compose
$ Dockerのサービスを起動する
$ sudo service docker start

### Wekanをインストール Wekan用ユーザーの作成

$ sudo useradd -d /home/wekan -m -s /bin/bash wekan
$ sudo usermod -aG docker wekan
$ sudo passwd wekan

### Wekan用のDockerコンテナ定義ファイルを作成
$  sudo -u wekan vi /home/wekan/docker-compose.yml
