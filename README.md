
The BLAS library link was disabled in the CMAKElist

roslaunch qr_gazebo gazebo_startup.launch wname:=earth

roslaunch qr_gazebo model_spawn.launch rname:=a1 use_xacro:=true use_camera:=false

rosrun examples example_a1_sim

rosrun examples example_keyboard