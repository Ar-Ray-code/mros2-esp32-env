DIR=$(cd $(dirname $0); pwd)
PORT=${1:-/dev/ttyACM0}
ESP32_BOARD=${2:-esp32s3}
DISABLE_CODE=${3:-false}

echo "===================="
echo "PORT: ${PORT}"
echo "DISABLE_CODE: ${DISABLE_CODE}"
echo "===================="

export MROS2_PATH=${HOME}/.mros2/mros2-esp32
mkdir -p ${MROS2_PATH}

# git clone --recursive git@github.com:mROS-base/mros2-esp32.git ${MROS2_PATH}
# cd ${MROS2_PATH}
# check cloned and install using ls
if [ ! -d ${MROS2_PATH}/components ]; then
    echo "mros2-esp32 is not installed"
    git clone --recursive git@github.com:mROS-base/mros2-esp32.git ${MROS2_PATH}
    cd ${MROS2_PATH}
    git submodule update --init --recursive
    cd ${DIR}
else
    echo "mros2-esp32 is already installed"
fi

# open files (vscode)
if [ ${DISABLE_CODE} = false ]; then
    echo "Wi-Fi setting is required (SSID, Password, IP address)"
    code --goto ${MROS2_PATH}/components/mros2/include/rtps/config.h:42
    code --goto ${MROS2_PATH}/components/mros2/include/netif.h:4
    code --goto ${MROS2_PATH}/workspace/common/wifi/wifi.h:3
    read -p "Press enter to continue"
fi

# install esp-idf --
. $HOME/esp/esp-idf/export.sh

# if menuconfig found
if [ ! -f ${DIR}/sdkconfig ]; then
    echo "sdkconfig is not created"
    idf.py set-target ${ESP32_BOARD}
    idf.py menuconfig
else
    echo "sdkconfig is already created (menuconfig is skipped)"
fi

idf.py build
idf.py -p ${PORT} flash
