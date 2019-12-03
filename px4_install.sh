#!/bin/bash

# install dependencies
sudo apt install python-pip python-jinja2
sudo pip install numpy toml pymavlink
sudo apt install ros-$ROS_DISTRO-mavros ros-$ROS_DISTRO-mavlink ros-$ROS_DISTRO-mav-msgs ros-$ROS_DISTRO-mavros-extras ros-$ROS_DISTRO-control-toolbox ros-$ROS_DISTRO-vrpn

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
sudo bash install_geographiclib_datasets.sh
rm install_geographiclib_datasets.sh


make px4_sitl_default gazebo

# add to .bashrc to source and export paths
echo "

# px4 workspace
source ~/catkin_ws/devel/setup.bash

# px4 gazebo (make sure to edit the 'px4_path' to match current ROS workspace)
px4_path=~/catkin_ws/src/Firmware
source \$px4_path/Tools/setup_gazebo.bash \$px4_path \$px4_path/build/px4_sitl_default
export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:\$px4_path/Tools/sitl_gazebo

# lab coordinates for QGC
export PX4_HOME_ALT=1461.0
export PX4_HOME_LON=-111.807713
export PX4_HOME_LAT=41.742054
" >> ~/.bashrc

source ~/.bashrc

echo
echo
echo -e "${GN}Remember to update your ~/.bashrc file with the correct workspace."
echo -e "${GN}Run 'roslaunch demolab_gazebo lab.launch' to start Gazebo sim."
echo
echo -e "${GN}Then you can run 'rosrun drone_control posctl.py' for a waypoint control."
echo

