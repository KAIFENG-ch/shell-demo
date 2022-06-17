Xshell 7 (Build 0109)
Copyright (c) 2020 NetSarang Computer, Inc. All rights reserved.

Type `help' to learn how to use Xshell prompt.
[C:\~]$ 

Connecting to 120.78.12.129:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

WARNING! The remote SSH server rejected X11 forwarding request.

Welcome to Alibaba Cloud Elastic Compute Service !

Updates Information Summary: available
    20 Security notice(s)
         1 Critical Security notice(s)
         6 Important Security notice(s)
        12 Moderate Security notice(s)
         1 Low Security notice(s)
Run "dnf upgrade-minimal --security" to apply all updates.
Last login: Fri Jun 17 17:43:03 2022 from 112.49.214.226
[root@Albert ~]# cd shell-demo/
[root@Albert shell-demo]# vim test.sh 

#! /bin/bash 
choice() { 
        echo " 
        ---系统信息获取和展示--- 
        1.获取系统内存信息 
        2.获取系统磁盘信息 
        3.获取CPU信息 
        4.获取网络信息 
        5.获取用户信息 
        6.获取进程信息 
        7.获取服务信息 
        " 
} 
 
get_memory() { 
        mem_total=`free | grep Mem | awk '{print $2}'` 
        echo "物理内存总量："$mem_total 
        mem_used=`free | grep Mem | awk '{print $3}'` 
        echo "已使用内存:"$mem_used 
        mem_free=`free | grep Mem | awk '{print $4}'` 
        echo "剩余内存:"$mem_free 
} 
 
get_disk() { 
        disk_total=$(fdisk -l | grep "Disk /dev/vda" | awk -F '[ :,]+' '{print $3}') 
        echo "磁盘总空间："$disk_total 
        disk_used=$(df -k | grep -v "tmpfs" | awk 'NR!=1'  | awk '{sum+=$2};END {print sum}') 
        echo "已使用磁盘空间:"$disk_used 
        disk_free=$(df -k | grep -v "tmpfs" | awk 'NR==2' | awk '{print $4}') 
        echo "剩余磁盘空间："$disk_free 
} 
 
get_cpu() { 
        cpu_proc_num=`cat /proc/cpuinfo | grep "processor" | wc -l` 
        echo "获取逻辑CPU个数"$cpu_proc_num 
        cpu_core_num=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk -F ': ' '{print $2}'` 
        echo "CPU核数"$cpu_core_num 
        cpu_main_freq=`cat /proc/cpuinfo | grep "model name" | awk -F '@ ' 'NR==1 {print $2}'` 
        echo "CPU主频"$cpu_main_freq 
} 
 
get_network() { 
        ip=`ifconfig | grep inet| awk 'NR==1' | awk '{print $2}'` 
        mask=`ifconfig | grep inet | awk 'NR==1' |  awk '{print $4}'` 
        echo "ip地址:"$ip 
        echo "子网掩码："$mask 
} 
 
 
get_user() { 
        user=`cat /etc/passwd | awk -F ':' '{if ($3>=500) print $1}'` 
        echo "用户："$user 
} 
 
get_process() { 
        process_num=$(ps -aux | wc -l) 
        echo "运行进程数:"$process_num 
} 
 
get_service() { 
        service_num=$(systemctl list-units --type=service | wc -l) 
        echo "运行服务数:"$service_num  
} 
 
 
while : 
do 
        choice 
        read -ep "输入需要的选项（输入0退出）：" ch 
        case $ch in  
        1) 
                get_memory 
                ;; 
        2) 
                get_disk 
                ;; 
        3) 
                get_cpu 
                ;; 
        4) 
                get_network 
                ;; 
        5) 
                get_user 
                ;; 
        6) 
                get_process 
                ;; 
        7) 
                get_service 
                ;; 
        0) 
                exit 0 
                ;; 
        *) 
                echo "输入错误" 
        esac 
done 
