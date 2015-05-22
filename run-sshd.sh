#!/bin/bash
# vim:set et ts=2 sw=2:

# Author : djluo
# version: 4.0(20150107)

# chkconfig: 3 90 19
# description:
# processname: zentao container

[ -r "/etc/baoyu/functions"  ] && source "/etc/baoyu/functions" && _current_dir
[ -f "${current_dir}/docker" ] && source "${current_dir}/docker"

# ex: ...../dir1/dir2/run.sh
# container_name is "dir1-dir2"
_container_name ${current_dir}

images="openssh"
#images="${registry}/baoyu/openssh"
PW='$6$qHLWO/IH$Ct6qjb2rRQf7Wjl9ZbORKUdCvN5iEj1VIzv/edtHMYaJShgDG2/Fw0.2pqwkQeO0l8nCzIDKsbgoaZf8Qlhd3.'

action="$1"    # start or stop ...
_get_uid "$2"  # uid=xxxx ,default is "1000"
shift $flag_shift
unset  flag_shift

# 转换需映射的端口号
app_port="$@"  # hostPort
app_port=${app_port:=${default_port}}
_port

_run() {
  local mode="-d" # --restart=always"
  local name="$container_name"
  local cmd="/usr/sbin/sshd -D"

  [ "x$1" == "xdebug" ] && _run_debug

  sudo docker run $mode $port \
    -e "TZ=Asia/Shanghai"     \
    -e "HOME=/home/docker"    \
    -e "User_Id=${User_Id}"   \
    -e "PW=${PW}"   \
    --privileged=true \
    -v "${current_dir}/keys:/home/docker/.ssh" \
    --name ${name} ${images}  \
    $cmd
}
###############
_call_action $action
