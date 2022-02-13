
set -e
set -x

sudo apt update

sudo apt upgrade -y

sudo apt install -y curl vim cmake network-manager

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt update

sudo apt install -y ros-noetic-ros-base

sudo apt install -y python3-rosdep python3-rosinstall \
    python3-rosinstall-generator python3-wstool \
    build-essential python3-rosdep

sudo rosdep init
rosdep update

sudo apt-get install -y ros-noetic-mavros ros-noetic-mavros-extras

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh

sudo bash ./install_geographiclib_datasets.sh

rm install_geographiclib_datasets.sh

sudo apt install -y python3-pip

sudo pip install numpy scipy matplotlib ipdb PyGeodesy PyYAML tqdm
