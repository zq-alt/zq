#!/bash/bash

################# linux shell practice #################

#Linux下查询文件是否存在，若存在，写出文件存在的目录
#!/bin/bash
read -p "输入您要查询的文件名：" file   #read 写入变量
if [ `find / -name $file|wc -l` -ne 0 ];then  #判断文件$files是否存在
   find / -name $file > file.txt       #若存在，将查找到的内容写入到file.txt
   if [ `cat file.txt|wc -l` -eq 1 ];then  
      echo "$file只存在一个"
      echo "文件存在的目录为： `sed 's/'$file'//g' file.txt`"
   else
     echo "$file存在多个目录"
     while read line
     do
     echo "文件存在的目录为：${line%/*}"
     done < file.txt
   fi
else
   echo "$file不存在"
fi

rm -rf file.txt

#查看文件系统的使用率超过90%的情况
df -hP |awk '{if(NR>=2){print $5,$6}}' |sed 's/%//g' |awk '{if($1>=90){print $2}}'


#查看服务器端口已tcp状态的分类
netstat -antp |awk '/^tcp/{stat[$6]++}END{for(i in stat){print i,stat[i]}}'


#ftp服务自动登录
read -p "输入你需要连接的ftp服务器的IP地址、登录用户、密码分别为：" ip user password
read -p "输入您需要操作的类型：（上传请输入put，下载请输入get）" operation
read -p "输入你需要下载文件或上传文件的目录和名称分别为：" dir file
case $operation in
        "put")
ftp -inv $ip <<!
user $user $password
bin
cd $dir
put $file
bye
!
    ;;
    "get")
ftp -inv $ip <<!
user $user $password
bin
cd $dir
get $file
bye
!
    ;;
    *)
    echo "输入的操作类型有误"
    exit 1
esac


#参数取值
a=12334
echo ${a#*3}  #34
echo ${a##*3} #4
echo ${a%3*}  #123
echo ${a%%3*} #12

#表示从左向右非贪婪删除word匹配成功的部分
##表示从左向右贪婪删除word匹配成功的部分
%表示从右向左非贪婪删除word匹配成功的部分
%%表示从右向左贪婪删除word匹配成功的部分


