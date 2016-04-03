# Docker


### MacにDockerをインストールする
- pkgをダウンロード
https://www.docker.com/products/docker-toolbox

### Dockerコマンドメモ
- <docker_name>という名前のdockerVMを作る
$ docker-machine create --driver virtualbox <docker_name>

- docker一覧を見る
$ docker-machine ls

- 起動していない場合はこれで起動
$ docker-machine start default

- 環境変数を確認
$ docker-machine env <docker_name>

