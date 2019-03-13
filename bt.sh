#!/bin/bash
##检查操作系统
检查系统(){
	如果 [[ -f/etc/redhat-释放]; 然后
释放="CentOS"
	埃利夫CAT/ETC/问题|GREP-Q-E-I"德比安"; 然后
释放="德比安"
	埃利夫CAT/ETC/问题|GREP-Q-E-I"乌本图"; 然后
释放="乌本图"
	埃利夫CAT/ETC/问题|GREP-Q-E-I"红帽"; 然后
释放="CentOS"
	埃利夫CAT/proc/版本|GREP-Q-E-I"德比安"; 然后
释放="德比安"
	埃利夫CAT/proc/版本|GREP-Q-E-I"乌本图"; 然后
释放="乌本图"
	埃利夫CAT/proc/版本|GREP-Q-E-I"红帽"; 然后
释放="CentOS"
    菲
位=`美姆`
}

##检查是否根用户
[ $(ID-u) != "0" ] && { 回波-e"“\033[31m错误：必须使用root用户执行此脚本！\033[0m]"; 出口 1; }
##定义常用属性
绿色字体前缀="\033[32米]" &&红色字体前缀="\033[3100万]" &&绿色背景前缀="\033[42；37米]" &&红色背景前缀="\033[41；37米]" &&字体颜色后缀="\033[0m]"
信息="${绿色字体前缀}[信息]${Font_color_后缀}"
误差="${红色字体前缀}[错误]${Font_color_后缀}"
尖端="${绿色字体前缀}[注意]${Font_color_后缀}"

清澈
#宝塔sspanel-v3-mod-um快速部署工具
回波-e"感谢使用“\033[32m宝塔sspanel-v3-mod-uIM快速部署工具\033[0m]”"
回波 "----------------------------------------------------------------------------"
回波-e"请注意这些要求：“\033[31m宝塔版本=5.9\033[0m”，添加网址PHP版本必须选择为“\033][31m PHP7.1\033][0m”，添加完成后地址不要改动！"
回波 "----------------------------------------------------------------------------"
stty擦除'^H' && 朗读，阅读-p"请输入宝塔面板添加的网站域名，请不要修改添加之后的默认地址(例如：www.Baidu.com，不带http/https)："网站
stty擦除'^H' && 朗读，阅读-p"请输入宝塔面板添加的mysql用户名："牡蛎名称
stty擦除'^H' && 朗读，阅读-p"请输入宝塔面板添加的mysql数据库名："mysql数据库
stty擦除'^H' && 朗读，阅读-p"请输入宝塔面板添加的mysql密码："mysql密码
stty擦除'^H' && 朗读，阅读-p"请输入网站的mukey(用于webapi方式对接后端，可以自定义)："斯帕
睡眠1
回波-e"${Info}请确认您输入的网站域名：$网站"
回波-e"${Info}请确认您输入的mysql用户名：$mysqsuername"
回波-e"${Info}请确认您输入的mysql用户名：$mysql数据库"
回波-e"${Info}请确认您输入的mysql密码：$mysql密码"
回波-e"${Info}请确认您输入的mukey：$sspanelmukey"
stty擦除'^H' && 朗读，阅读-p"请输入数字(1：继续；2：退出)[1/2]："地位
案例 "$Status" 在……里面
	1)
	回波-e"${Info}您选择了继续，开始安装程序！"
	;;
	2)
	回波-e"${Tip}您选择了退出，请重新执行安装程序！" && 出口 1
	;;
	*)
	回波-e"${Error}请输入正确值[1/2]，请重新执行安装程序" && 出口 1
	;;
ESAC
回波-e"${Info}请等待系统自动操作."
光盘/www/wwroot/www/wwroot/$网站
rm-rf index.html 404.html
##安装git解压缩crontab
回波-e"${Info}正在检测安装git、解压缩、crontab工具"
Yum安装git解压缩crontab-y
回波-e"${Info}检测安装git、解压缩、crontab工具已完成"
睡眠1
##下载解压拷贝源码
回波-e"${Info}正在下载解压处理程序源码"
Wget-N-无支票证书"https：/github.com/lizhongnian/ss-面板-v3-mod_uIM/存档/dev.zip"
解压缩dev.zip
光盘SS-Panel-v3-mod_uim-dev
中压* .[^.]*/www/wwroot/www/wwroot/$网站/
光盘 ..
rm-rf dev.zip ss-面板-v3-mod_uIM-dev/
回波-e"${Info}下载解压处理程序源码已完成"
睡眠1
##处理php函数
回波-e"${Info}正在处理宝塔php内容"
SED-I'S/System/g'/www/server/php/71/etc/php.ini
SED-I'S/proc_open，/g'/www/server/php/71/etc/php.ini
SED-I'S/proc_get_state，/g'/www/server/php/71/etc/php.ini
SED-I'S/动态/静态/g'/www/server/php/71/etc/php-fpm.conf
SED-I'S/Display_Error=ON/Display_Error=off/g'/www/server/php/71/etc/php.ini
回波-e"${Info}处理宝塔php内容已完成"
睡眠1
##导入数据库
回波-e"${Info}正在导入数据库"
光盘SQL/
MySQL-u$mysqsuername-p$mysql密码 $mysql数据库 <glzjin_all.sql>/dev/NULL2>&1
回波-e"${Info}导入数据库已完成"
睡眠1
##安装依赖
回波-e"${Info}正在安装依赖"
光盘 ..
Chown-R根：根*
chmod-R 755*
Chown-R WWW：www存储
PHP Composer.phar安装
回波-e"${Info}安装依赖已完成"
睡眠1
##处理nginx伪静态和运行目录
回波-e"${Info}正在处理准内容"
回波 "位置/{TRY_file\$乌里\$URI/index.php\$IS ARGS\$ARGS；}">/www/server/Panel/vhost/rewrite/$网站.conf
SED-I"S/www\/wwwroot\/${网站}/www\/wwwroot\/$网站\/公众/g"/www/server/Panel/vhost/nginx/$网站.conf
回波-e"${Info}处理准内容已完成"
睡眠1
##初始化站点信息
回波-e"${Info}正在配置站点基本信息"
光盘/www/wwroot/www/wwroot/$网站
CP config/.config.php.for7color config/.config.php
SED-I"S/websiteurl/$网站/g"/www/wwroot/www/wwroot/$网站/config/.config.php
SED-I"S/spanel-mukey/$sspanelmukey/g"/www/wwroot/www/wwroot/$网站/config/.config.php
SED-I"S/sspanel-db-databasename/$mysql数据库/g"/www/wwroot/www/wwroot/$网站/config/.config.php
SED-I"S/sspanel-db-用户名/$mysqsuername/g"/www/wwroot/www/wwroot/$网站/config/.config.php
SED-I"S/sspanel-db-密码/$mysql密码/g"/www/wwroot/www/wwroot/$网站/config/.config.php
回波-e"${Info}配置站点基本信息已完成"
睡眠1
##下载IP解析库下载SSR程式
回波-e"${Info}正在下载IP解析库"
睡眠1
回波-e"${Info}下载IP解析库已完成"
睡眠1
回波-e"${Info}正在下载SSR程式"
睡眠1
回波-e"${Info}下载SSR程式已完成"
睡眠1
##加入定时任务
回波-e"${Info}正在添加定时任务"
回波 "30 22*php/www/wwwroot/$网站/xCAT电子邮件" >>/var/spool/cron/root
回波 "0*php-n/www/wwwroot/$网站/xCAT日报" >>/var/spool/cron/root
回波 "*/1*php/www/wwwroot/$网站/xCAT支票作业" >>/var/spool/cron/root
回波 "*/1*php/www/wwwroot/$网站/xCAT同步节点" >>/var/spool/cron/root
chkconfig-35级crond
/sbin/service crond重新启动
回波-e"${Info}添加定时任务已完成"
睡眠1
##重启php和nginx
回波-e"${Info}正在重启PHP"
/etc/init.d/php-FPM-71重新启动
回波-e"${Info}重启已完成"
睡眠1
回波-e"${Info}正在重启Nginx"
/etc/init.d/nginx重新启动
回波-e"${Info}重启准已完成"
睡眠3
回波-e"${Tip}安装即将完成，倒数五个数！"
睡眠1
清澈
回波 "-----------------------------"
回波 "#############################"
回波 "########           ##########"
回波 "########   ##################"
回波 "########   ##################"
回波 "########           ##########"
回波 "###############    ##########"
回波 "###############    ##########"
回波 "########           ##########"
回波 "#############################"
睡眠1
清澈
回波 "-----------------------------"
回波 "#############################"
回波 "#######   ####   ############"
回波 "#######   ####   ############"
回波 "#######   ####   ############"
回波 "#######               #######"
回波 "##############   ############"
回波 "##############   ############"
回波 "##############   ############"
回波 "#############################"
睡眠1
清澈
回波 "-----------------------------"
回波 "#############################"
回波 "########            #########"
回波 "#################   #########"
回波 "#################   #########"
回波 "########            #########"
回波 "#################   #########"
回波 "#################   #########"
回波 "########            #########"
回波 "#############################"
睡眠1
清澈
回波 "-----------------------------"
回波 "#############################"
回波 "########           ##########"
回波 "################   ##########"
回波 "################   ##########"
回波 "########           ##########"
回波 "########   ##################"
回波 "########   ##################"
回波 "########           ##########"
回波 "#############################"
睡眠1
清澈
回波 "-----------------------------"
回波 "#############################"
回波 "############   ##############"
回波 "############   ##############"
回波 "############   ##############"
回波 "############   ##############"
回波 "############   ##############"
回波 "############   ##############"
回波 "############   ##############"
回波 "#############################"
回波 "-----------------------------"
睡眠1
清澈
回波 "--------------------------------------------------------------------------------"
回波-e"${Info}部署完成，请打开http：/$网站即可浏览"
回波-e"${Info}默认生成的管理员用户名：管理密码为7彩色博客"
回波-e"${Info}如果打不开站点，请到宝塔面板中软件管理重启nginx和php7.1"
回波-e"${Info}自定义配置，请打开/www/wwwroot/$网站/config/.config.php进行修改"
回波-e"${Info}gitHub地址：https：/github.com/lizhongnian/sspanel-v3-mod-uim-bt"
回波-e"${Info}https://www.7colorblog.com/：博客地址"
回波 "--------------------------------------------------------------------------------"
