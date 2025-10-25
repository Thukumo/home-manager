
# セットアップ

## 設定ファイルの配置

`git clone https://github.com/thukumo/home-manager ~./config/`

## xremap用の設定(uinputをユーザ権限で読めるようにする)

`sudo gpasswd -a <USER> input`\
`echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules`\
この作業以降に再起動するまで、キーバインディングは適用されない。

## Nix, home-managerのインストール 兼 構成の適用

`curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate`\
`nix run home-manager/master -- init --switch`

# キーバインディングについて

Shiftキーを短く押して全角/半角キー\
全角/半角キー, 右CtrlキーでEsc\
CapsLock, 右Shiftで左METAキー\
無変換キーでHome\
変換, カタカナひらがなキーでEnd
詳しくはxremap/config.ymlで

