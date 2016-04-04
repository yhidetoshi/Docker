# Dockerを使う

### MacにDockerをインストールする
- pkgをダウンロード
https://www.docker.com/products/docker-toolbox

`$ bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'`


### Dockerfile
`docker build` コマンドでDockerコンテナーの起動、構成、Dockerイメージの作成まで一気に実行
```
$ pwd
/Users/hidetoshi/Docker/httpd

$ docker pull centos:centos6
$ docker images
---
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos/centos6      latest              17c89573e795        4 seconds ago       341.4 MB
centos              centos6             fc73b108c5ae        2 days ago          228.9 MB
---

$ docker build -t centos/centos6 .
```

- dockerイメージを確認
`$docker images`

- dockerイメージが作成できればコンテナを起動する

```
$ docker images

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos/centos6      latest              17c89573e795        17 minutes ago      341.4 MB
centos              centos6             fc73b108c5ae        2 days ago          228.9 MB
```



### Dockerコマンドメモ
- <docker_name>という名前のdockerVMを作る
$ docker-machine create --driver virtualbox <docker_name>

- コンテナ一覧を見る
$ docker-machine ls

- 起動していない場合はこれで起動
$ docker-machine start default

- 環境変数を確認
$ docker-machine env <コンテナ_name>

### CentOS6.7にDockerをインストールする
- https://github.com/yhidetoshi/chef_mac
-> cookbooks/docker-installを参照。
