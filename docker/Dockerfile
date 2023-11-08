FROM osrf/ros:noetic-desktop-full

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive
ARG rosdistro="noetic"

ENV ROS_DISTRO=$rosdistro
# Install packages
RUN apt-get update && apt-get install -y \
locales \
lsb-release \
git \
subversion \
nano \
terminator \
xterm \
wget \
curl \
htop \
libssl-dev \
build-essential \
dbus-x11 \
software-properties-common \
ssh \
net-tools \
iputils-ping \
iproute2 \
ros-noetic-move-base \
ros-noetic-slam-gmapping \
ros-noetic-gazebo-ros-pkgs  \
ros-noetic-gazebo-ros-control \
ros-noetic-gazebo-plugins \
ros-noetic-robot-localization \
ros-noetic-joy \
ros-noetic-teleop-twist-joy \
ros-noetic-teleop-twist-keyboard \
ros-noetic-navigation \
ros-noetic-hector-gazebo-plugins \
ros-noetic-socketcan-interface \
libignition-rendering3 \
ros-noetic-robot-state-publisher \
libyaml-cpp-dev \
libeigen3-dev \
liblcm-dev \
libglm-dev

# don't work for noetic
#ros-noetic-cartographer \
#ros-noetic-joystick-drivers \
RUN apt-get clean && rm -rf /var/lib/apt/lists/*



# Install ROS
RUN apt-get update && apt-get install -y ros-$ROS_DISTRO-socketcan-bridge
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure ROS
RUN rosdep update
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc
RUN echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.bashrc
RUN echo "source /opt/ros/$ROS_DISTRO/setup.zsh" >> /root/.zshrc
RUN echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.zshrc





RUN /bin/bash -c 'source /opt/ros/$ROS_DISTRO/setup.bash &&\
   sudo mkdir -p  /root/home/catkin_ws/src/quadruped-robot &&\
    cd /root/home/catkin_ws/src &&\
   catkin_init_workspace &&\
   cd /root/home/catkin_ws' 

ENV ROS_WS_PATH=root/home/catkin_ws/src

COPY ./quadruped-robot /${ROS_WS_PATH}

RUN /bin/bash -c 'source /opt/ros/$ROS_DISTRO/setup.bash &&\
    cd /root/home/catkin_ws &&\
    catkin_make'

RUN echo "source root/home/catkin_ws/devel/setup.bash" >> /root/.bashrc



