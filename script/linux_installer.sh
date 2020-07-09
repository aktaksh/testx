#!/bin/bash
 yum remove ruby -y
 yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison sqlite-devel
 curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
 curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
 curl -L get.rvm.io | bash -s stable
 source /etc/profile.d/rvm.sh
 rvm reload
 rvm install 2.7
 sleep 5
 rvm use 2.7 --default
 gem install jekyll
 sleep 5
 echo `pwd ; ls -lrt`
 cd /root/Biqmind-AKS-Workshop/
 nohup jekyll server -H 0.0.0.0 -P 4000 &>/dev/null &
