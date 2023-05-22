# mros2-mbed-env
mros2-mbedの環境構築資料。記事化予定

## Requirements

- Ubuntu22
- ESP-IDF v5.2-dev-503-g17451f1fb3
- Target: esp32s3 (M5Stack CORE S3)
- dialout groupへの所属（`sudo adduser $USER dialout`でOK）

<br>

## Build template

### Download this project

```bash
git clone git@github.com:Ar-Ray-code/mros2-mbed-env.git
```

### build

`build.bash`を実行すると、mros2-mbedのダウンロードと諸設定、ビルドが行われます。

mros2-mbedは`~/.mros2/mros2-esp32`にインストールされ、この環境変数をもとにテンプレートがビルドされます。

ファイルが勝手に開くので、適宜編集などをしてください。

**編集箇所**

1. `config.h`・`netif.h`・`wifi.h`のIPアドレスを編集、`wifi.h`はSSIDとパスワードも編集。編集がおわったらターミナル上でEnterを押す。
2. `sdkconfig`が存在しない場合、esp-idfの`menuconfig`が開くので、3以降の手順を実行
3. `/`を押して検索モードに移行、`ipv6`と入力。Enterを押す
4. `[*] Enable IPv6`にカーソルが合わせられるので、Enterを押す
5. `S`を押して保存先のファイルを選択、Enterを押して保存
6. `Q`を押してメニューを閉じる

```bash
cd mros2-mbed-env
bash build.bash
# bash build.bash <port> <esp32-board> <disable-vscode: true/false>
```

<br>

## 注意事項

- menuconfigでIPv6が有効になっているとRTPSパケットが飛びません
- `config.h`・`netif.h`・`wifi.h`のIPアドレスは一致している必要があります。
- 一応DHCPは利きますが、RTPS側のIPアドレスを一致させる必要があります。
- mros2のプログラムを変更したことによって同じトピック名で異なる型がPub/Subされる場合、登録されたトピックの内容が消えず失敗します。 `ros2 daemon stop` でdaemonを停止してROS2を再起動してください。
