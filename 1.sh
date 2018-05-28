#!/bin/bash

#添加终端颜色
echo "
PS1=\"\\[\\e[37;40m\\][\\[\\e[32;40m\\]\\u\\[\\e[37;40m\\]@\\h \\[\\e[35;40m\\]\\W\\[\\e[0m\\]]\\\\\$ \\[\\e[33;40m\\]\"" >> /etc/profile
source /etc/profile

#配置vimrc
echo "
set encoding=utf-8
set number
syntax on
" > /root/.vimrc

#添加别名
echo "
alias ll='ls -lh'
cd_ls(){
    \cd \$1
    ls 
}
alias cd='cd_ls'
">>/root/.bashrc
source /root/.bashrc


#添加开机脚本
yum -y install bc
echo "
/root/.bash_login" >> /etc/profile

cat >/root/.bash_login << "EOF"
# ~/.bash_login
echo -e "nOf course it runs on $(uname -s)n"
 CPUTIME=$(ps -eo pcpu | awk 'NR>1' | awk '{tot=tot+$1} END {print tot}')
 CPUCORES=$(cat /proc/cpuinfo | grep -c processor)
 echo "
 System Summary (collected `date`)
 - CPU Usage (average)       = `echo $CPUTIME / $CPUCORES | bc`%
 - Memory free (real)        = `free -m | head -n 2 | tail -n 1 | awk {'print $4'}` Mb
 - Memory free (cache)       = `free -m | head -n 3 | tail -n 1 | awk {'print $3'}` Mb
 - Swap in use               = `free -m | tail -n 1 | awk {'print $3'}` Mb
 - System Uptime             =`uptime`
 - Disk Space Used           = `df / | awk '{ a = $5 } END { print a }'`"
EOF

chmod +x /root/.bash_login
source /root/.bash_login


