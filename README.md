
# a

## 概要

試しに書いているhome-managerの構成です

## セットアップ

### 設定ファイルの配置

`git clone https://github.com/thukumo/home-manager ~/.config/home-manager`

### xremap用の設定(uinputをユーザ権限で読めるようにする)

`sudo gpasswd -a <ここにユーザー名を入力> input`\
`echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules`\
この作業後、再起動するまでキーバインディングは適用されない。

### Nix, home-managerのインストールと構成の適用

`curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate`\
`nix run home-manager/master -- init --switch`

## キーバインディングについて

`xremap/config.nix`を参照してください。

