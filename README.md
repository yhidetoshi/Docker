# Dockerを使う

### MacにDockerをインストールする
- pkgをダウンロード
https://www.docker.com/products/docker-toolbox

`$ bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'`


**ざっくりの流れ**

1. dockerのイメージを取得する(docker pull)

-> 好きなディストリビューションを持ってくる

2. イメージを基にコンテナを作成する(dockerfile build)

-> dockerfileに記述してカスタマイズコンテナを作成できる

3. 起動/接続(docker run)

-> 切り替わる


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

- コンテナを起動する

`$ docker run --name test01 --hostname test01 -i -t centos:centos6 /bin/bash`

`[root@test01 /]#`と表示され接続できる

- コンテナな起動しているかを確認する
```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
4d96f1ec6420        centos:centos6      "/bin/bash"         2 minutes ago       Up 2 minutes                            test01
```

- コンテナ起動

`docker start <id or name>`

- コンテナ停止

`docker stop <id or name>`

- コンテナの破棄
```
$docker rm <CONTAINER ID> | <NAMES>
```
- dockerのイメージを破棄
```
$ docker rmi <dockerのイメージID or NAME>
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


### Mac環境でNginx+Jenkinsをリバースプロキシ環境を構築する


<img src="http://bit.ly/1RDtYFC" alt="" title="サンプル">

