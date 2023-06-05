# mros2-esp32-env
mros2-esp32の環境構築資料。

```bash
.
├── build_example.bash
├── docker
│   └── esp_idf.dockerfile
├── docker-compose.yml
├── example
│   ├── build.bash
│   ├── CMakeLists.txt
│   ├── main
│   │   ├── app.cpp
│   │   ├── CMakeLists.txt
├── LICENSE
└── README.md
```

- build_example.bash : サンプルプロジェクトの自動ビルドスクリプト
- esp_idf.dockerfile : ビルド用Dockerfile
- docker-compose.yml : ビルド用Docker-compose
- example/ : サンプルプロジェクトのワークスペース

## Requirements

- USB経由でのシリアル接続が可能なDocker-compose環境
- esp-idf v5.1でコンパイルできるマイコン（M5CoreS3）

## Usage

```bash
git clone https://github.com/Ar-Ray-code/mros2-esp32-env
cd mros2-esp32-env
bash build_example.bash <target-port> <mros2-esp32のパス> <プロジェクトのパス> <対象ボード（esp32s3など）>
```

<br>


## 注意事項

- menuconfigでIPv6が有効になっているとRTPSパケットが飛びません
- `mros2-esp32/workspace/common/wifi.h` と `mros2-esp32/include/rtps/config.h` のIPアドレスを設定して一致させる必要があります。
- 一応DHCPは利きますが、RTPS側のIPアドレスを一致させる必要があります。
- mros2のプログラムを変更したことによって同じトピック名で異なる型がPub/Subされる場合、登録されたトピックの内容が消えず失敗します。 `ros2 daemon stop` でdaemonを停止してROS2を再起動してください。
