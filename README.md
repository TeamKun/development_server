# development_server
メンバーが開発時に使用する使い捨てインスタンスを管理するサーバ

# for server develop

VirtualBox + Vagrant + ansible

### Premise for windows 
This introduction is for WSL(ubuntu)

install VirtualBox(GUI)
search from oracle page https://www.oracle.com/jp/virtualization/technologies/virtualbox/downloads.html

install Vagrant and ansible(WSL:ubuntu)

```(bash)
apt install virtualbox
pip3 install ansible
```

## boot Vagrant

`vagrant up`

Vagrant using
```(bash)
vagrant up      #starts and provisions the vagrant environment
vagrant status  #outputs status of the vagrant machine
vagrant halt    #stops the vagrant machine
vagrant destroy #stops and deletes all traces of the vagrant machine
```
