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


