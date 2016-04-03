# Docker

- pkgをダウンロード
https://www.docker.com/products/docker-toolbox

- defaultという名前のdockerVMを作る
$ docker-machine create --driver virtualbox default

- docker VMの一覧を見る
$ docker-machine ls

- 起動していない場合はこれで起動
$ docker-machine start default

- 環境変数を確認
$ docker-machine env <vm_name>
