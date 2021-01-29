# development_server
メンバーが開発時に使用する使い捨てインスタンスを管理するサーバ

# 開発サーバでのContainer起動方法

```bash
cd /home/minecraft_ops
mkdir [お好きな名前]
↑作ったディレクトリ内にプラグインを入れてね。依存関係があるなら全部入れてね。
./init-mc-Container.sh [ディレクトリにつけた名前]
```

最後にIPとポートが表示されます

## ローカルでのテスト
### windowsでの準備
WSL環境でansibleとVagrantを使えるようにします。

VirtualBoxをwindows側（GUI）でinstallします
https://www.oracle.com/jp/virtualization/technologies/virtualbox/downloads.html

WSLでvagrantとansibleをインストールします。（ansibleはPIP経由です、使えるようにしてください）

```(bash)
apt install vagrant 
pip3 install ansible
```

### Vagrantで起動するには
下記コマンドでVMを立ち上げます

```
vagrant up
```

このplaybookを検証するには以下のコマンドを使用します

```
vagrant provision
```

Vagrant using
```(bash)
vagrant up      #starts and provisions the vagrant environment
vagrant status  #outputs status of the vagrant machine
vagrant halt    #stops the vagrant machine
vagrant destroy #stops and deletes all traces of the vagrant machine
```

## リモートのサーバに適用するには
下記コマンドで適用してください。ipaddressは適切なものに変更してください。ipアドレスの後ろの`,`は必須です
```
 ansible-playbook -u root -i [ipaddress], playbook/base_server_prov.yml
```
