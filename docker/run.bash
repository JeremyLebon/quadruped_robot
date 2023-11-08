#!/bin/bash

export ROS_REMOTE_PC=127.0.0.1
export ROS_PORT=11311

XSOCK=/tmp/.X11-unix

xhost +local:root

export docker_name="legged_noetic"

docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --gpus all \
    --mount source="${docker_name}_vol",destination=/root/home/catkin_ws \
    --env "ROS_MASTER_URI=http://$ROS_REMOTE_PC:$ROS_PORT" \
    --env "ROS_HOSTNAME=$ROS_REMOTE_PC" \
    --device=/dev/input/js0 \
    --device=/dev/input/js1 \
    --name "${docker_name}_cont" \
    --rm \
    --privileged \
    --network host \
    --cap-add=NET_ADMIN \
    "img_${docker_name}" \
    bash
