# Dockerを使う

### MacにDockerをインストールする
- pkgをダウンロードしてインストールする
https://www.docker.com/products/docker-toolbox

`$ bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'`

```


                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
           \______ o           __/
             \    \         __/
              \____\_______/


docker is configured to use the default machine with IP x.x.x.x
For help getting started, check out the docs at https://docs.docker.com

$ docker-machine restart default
Restarting "default"...
Waiting for SSH to be available...
Detecting the provisioner...
Restarted machines may have new IP addresses. You may need to re-run the `docker-machine env` command.
```

**ざっくりの流れ**

- dockerのイメージを取得する(docker pull)

-> 好きなディストリビューションを持ってくる

- イメージを基にコンテナを作成する(dockerfile build)

- dockerfileに記述してカスタマイズコンテナを作成できる

-  起動/接続(docker run)

- docker start | stop

(エラー対処)
- `(error ) Network timed out while trying to connect to https://index.docker.io`
- `docker start `しても起動しない場合

(他に良い方法があるかもしれません...)
`$ docker-machine restart default`


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

![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/virtualbox_portfoward.png)
