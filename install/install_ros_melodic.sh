
set -e
set -x

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

sudo apt update

# sudo apt install -y ros-melodic-desktop-full

sudo apt install -y ros-melodic-ros-base

echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

source ~/.bashrc

sudo apt install -y python-rosdep python-rosinstall \
    python-rosinstall-generator python-wstool build-essential

sudo rosdep init
rosdep update

# sudo apt-get install ros-melodic-mavros ros-melodic-mavros-extras
