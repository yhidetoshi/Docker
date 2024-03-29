## docker-composeを利用

- nginxのconfigとログを永続化するので下記のディレクトリ構成にする
```
nginx
├── containers
│   └── Dockerfile
├── docker-compose.yml
├── log
│   └── nginx
│       ├── access.log
│       └── error.log
└── nginx
    └── config
        └── default.conf
```
- docker-compose.yml
```
version: '2'

services:
  nginx:
    environment:
      TZ: Asia/Tokyo
    build: ./containers  # Dockerfileのパスを指定する
    volumes:             # ホスト側に出す場合(データの永続化) コンテナが消えてもデータは保持される
      - ./log/nginx/:/var/log/nginx/
      - ./nginx/config/default.conf:/etc/nginx/conf.d/default.conf
    hostname: nginx
    ports:
      - 8100:80
```

#### 既存NWを利用する
```
NETWORK ID          NAME                DRIVER              SCOPE
6c046e895515        wekan_vpc           bridge              local
```
- `docker-compose.yml`
```
networks:
  default:
    external:
      name: wekan_vpc

```

- ネットワークにオプションを付ける(docker-compose.yml)
```
networks:
  vpc:
    driver: bridge
    driver_opts:
       com.docker.network.bridge.default_wekan_vpc: "true"
       com.docker.network.bridge.enable_icc: "true"
       com.docker.network.bridge.enable_ip_masquerade: "true"
       com.docker.network.bridge.host_binding_ipv4: "0.0.0.0"
       com.docker.network.bridge.name: "wekan_vpc"
       com.docker.network.driver.mtu: "1500"
    ipam:
      config:
        - subnet: 172.18.0.0/16
          gateway: 172.18.0.1
```

- `ifconfig` でNWインターフェースが作成されている
```
wekan_vpc Link encap:Ethernet  HWaddr 02:42:A4:99:20:02
          inet addr:172.18.0.1  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::42:a4ff:fe99:2002/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:346 errors:0 dropped:0 overruns:0 frame:0
          TX packets:312 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:19744 (19.2 KiB)  TX bytes:35792 (34.9 KiB)
```


### image/network 指定してコンテナを作成
`$ docker run --name nginx --net wekan_vpc -itd centos`

### コンテナのIPを固定して作成
`$ docker run --name mail -p 587:587 --hostname mail --net ec2user_vpc --ip=172.20.0.5 -itd centos:centos6.9` 

# Dockerを使う

![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/Docker/docker-icon.png)

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



### Dockerコマンドメモ(at Mac)
- <docker_name>という名前のdockerVMを作る
$ docker-machine create --driver virtualbox <docker_name>

- コンテナ一覧を見る

`$ docker-machine ls`

- 起動していない場合はこれで起動

`$ docker-machine start default`

- 環境変数を確認

`$ docker-machine env <コンテナ_name>`

### CentOS6.7にDockerをインストールする
- https://github.com/yhidetoshi/chef_mac
-> cookbooks/docker-installを参照。


### Mac環境でNginx+Jenkinsをリバースプロキシ環境を構築する

**[Nginxの作成]**
(参考)構築後にimage化してDocker Hubに保存
 -> https://hub.docker.com/r/hyajima/nginx-rp-test/
- 作成
```
$ docker run --name nginx -d -p 80:80 --hostname nginx -i -t centos:centos6 /bin/bash
```

- 確認
```
$ docker ps

CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                NAMES
df4559bcf615        centos:centos6      "/bin/bash"         5 seconds ago       Up 3 seconds        0.0.0.0:80->80/tcp   nginx
```

- 接続
```
$ docker attach nginx
```

-> nginxをインストールする
```
# rpm -ivh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
# yum -y install nginx
# cd /etc/nginx/conf.d
# mv default.conf default.conf.org
```

$ vim jenkins.conf
```
upstream backend-jenkins {
    server <リバプロ先のip>:8080 max_fails=3 fail_timeout=10s;
}
server {
    listen 80;
    server_name  localhost;
    keepalive_timeout  300;
    client_max_body_size 50M;
    proxy_read_timeout 600;
    proxy_pass_header Server;
    proxy_redirect                          off;
    proxy_set_header Host                   $host;
    proxy_set_header X-Real-IP              $remote_addr;
    proxy_set_header X-Forwarded-Host       $host;
    proxy_set_header X-Forwarded-Server     $host;
    proxy_set_header X-Forwarded-For        $proxy_add_x_forwarded_for;
  
    location / {
       proxy_pass http://backend-jenkins;
      break;
    }
    error_page  404              /404.html;
    location = /404.html {
        root   /usr/share/nginx/html;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```
- 設定したらnginxを再起動
`# service nginx restart


**[Jenkinsの作成]**
(参考)構築後にimage化してDocker Hubに保存
 -> https://hub.docker.com/r/hyajima/jenkins-test/

- 作成/接続
```
$ docker run --name jenkins -d -p 8080:8080 --hostname jenkins -i -t centos:centos6 /bin/bash
$ docker attach jenkins
```

- openjdkを入れて/jenkinsをダウンロードして起動
```
# yum install -y java-1.7.0-openjdk
# mkdir /usr/local/jenkins
# cd /usr/local/jenkins
# wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
# java -jar java -jar jenkins.war &
```

**[VirtualBoxの設定]**

[VM名:default]->[設定]->[ネットワーク]->[ポートフォワーディング]
- ホストIPはifconfigで確認(ローカルOSのip)
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/Docker/virtualbox_portfoward_new.png)


**[ローカルOSの/etc/hostsを書く]**
```
<ローカルホストOSのip>	jenkins-dev
```

**[ブラウザで接続確認]**
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/Docker/jenkins-top.png)


- docker psで確認
`$ docker ps`
```
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
403c75e81d66        centos:centos6      "/bin/bash"         41 minutes ago      Up 41 minutes       0.0.0.0:8080->8080/tcp   jenkins
df4559bcf615        centos:centos6      "/bin/bash"         52 minutes ago      Up 4 seconds        0.0.0.0:80->80/tcp       nginx
```

### Docker Hubを使って見る
![Alt Text](https://github.com/yhidetoshi/Pictures/raw/master/Docker/docker-top.png)
- アカウントを作成する
https://hub.docker.com/

- Docker Hubへログイン
```
$ docker login
```

- imageを作る
```
$ docker commit -m "コメント" <コンテナID> <名前:タグ>


- docker hubリポジトリにpushするためには 名前をユーザ名で初めて/で区切る
$ docker commit -m 'create nginx' df4559bcf615 hyajima/nginx:Centos6.7
```

- DockerHubへpush
```
$ docker push hyajima/nginx
```
- DockerHubからpull
```
$ docker pull -a hyajima/nginx
```
-> [-a]オプションをつけないとlatestタグを取得しようとして失敗する


- imageを探す
```
# docker search nodejs
```
