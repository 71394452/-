#!/bin/bash
##������ϵͳ
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}

##����Ƿ�root�û�
[ $(id -u) != "0" ] && { echo -e " ��\033[31m Error: ����ʹ��root�û�ִ�д˽ű���\033[0m��"; exit 1; }
##���峣������
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[��Ϣ]${Font_color_suffix}"
Error="${Red_font_prefix}[����]${Font_color_suffix}"
Tip="${Green_font_prefix}[ע��]${Font_color_suffix}"

clear
#����sspanel-v3-mod-uim���ٲ��𹤾�
echo -e "��лʹ�� ��\033[32m ����sspanel-v3-mod-uim���ٲ��𹤾� \033[0m��"
echo "----------------------------------------------------------------------------"
echo -e "��ע����ЩҪ��:��\033[31m �����汾=5.9 \033[0m���������ַPHP�汾����ѡ��Ϊ��\033[31m PHP7.1 \033[0m��,�����ɺ��ַ��Ҫ�Ķ���"
echo "----------------------------------------------------------------------------"
stty erase '^H' && read -p "�����뱦�������ӵ���վ����,�벻Ҫ�޸����֮���Ĭ�ϵ�ַ������:www.baidu.com������http/https����" website
stty erase '^H' && read -p "�����뱦�������ӵ�MySQL�û�����" mysqlusername
stty erase '^H' && read -p "�����뱦�������ӵ�MySQL���ݿ�����" mysqldatabase
stty erase '^H' && read -p "�����뱦�������ӵ�MySQL���룺" mysqlpassword
stty erase '^H' && read -p "��������վ��mukey(����webapi��ʽ�ԽӺ�ˣ������Զ���)��" sspanelmukey
sleep 1
echo -e "${Info} ��ȷ�����������վ������$website"
echo -e "${Info} ��ȷ���������MySQL�û�����$mysqlusername"
echo -e "${Info} ��ȷ���������MySQL�û�����$mysqldatabase"
echo -e "${Info} ��ȷ���������MySQL���룺$mysqlpassword"
echo -e "${Info} ��ȷ���������mukey��$sspanelmukey"
stty erase '^H' && read -p " ����������(1��������2���˳�) [1/2]:" status
case "$status" in
	1)
	echo -e "${Info} ��ѡ���˼�������ʼ��װ����"
	;;
	2)
	echo -e "${Tip} ��ѡ�����˳���������ִ�а�װ����" && exit 1
	;;
	*)
	echo -e  "${Error} ��������ȷֵ [1/2]��������ִ�а�װ����" && exit 1
	;;
esac
echo -e "${Info} ��ȴ�ϵͳ�Զ�����......"
cd /www/wwwroot/$website
rm -rf index.html 404.html
##��װgit unzip crontab
echo -e "${Info} ���ڼ�ⰲװgit��unzip��crontab����"
yum install git unzip crontab -y
echo -e "${Info} ��ⰲװgit��unzip��crontab���������"
sleep 1
##���ؽ�ѹ����Դ��
echo -e "${Info} �������ؽ�ѹ�������Դ��"
wget -N --no-check-certificate "https://github.com/71394452/-/blob/master/ss-panel-v3-mod_Uim-dev.zip"
unzip dev.zip
cd ss-panel-v3-mod_Uim-dev
mv * .[^.]* /www/wwwroot/$website/
cd ..
rm -rf dev.zip ss-panel-v3-mod_Uim-dev/
echo -e "${Info} ���ؽ�ѹ�������Դ�������"
sleep 1
##����php����
echo -e "${Info} ���ڴ�����php����"
sed -i 's/system,//g' /www/server/php/71/etc/php.ini
sed -i 's/proc_open,//g' /www/server/php/71/etc/php.ini
sed -i 's/proc_get_status,//g' /www/server/php/71/etc/php.ini
sed -i 's/dynamic/static/g' /www/server/php/71/etc/php-fpm.conf
sed -i 's/display_errors = On/display_errors = Off/g' /www/server/php/71/etc/php.ini
echo -e "${Info} ������php���������"
sleep 1
##�������ݿ�
echo -e "${Info} ���ڵ������ݿ�"
cd sql/
mysql -u$mysqlusername -p$mysqlpassword $mysqldatabase < glzjin_all.sql >/dev/null 2>&1
echo -e "${Info} �������ݿ������"
sleep 1
##��װ����
echo -e "${Info} ���ڰ�װ����"
cd ..
chown -R root:root *
chmod -R 755 *
chown -R www:www storage
php composer.phar install
echo -e "${Info} ��װ���������"
sleep 1
##����nginxα��̬������Ŀ¼
echo -e "${Info} ���ڴ���nginx����"
echo "location / {try_files \$uri \$uri/ /index.php\$is_args\$args;}"> /www/server/panel/vhost/rewrite/$website.conf
sed -i "s/\/www\/wwwroot\/${website}/\/www\/wwwroot\/$website\/public/g" /www/server/panel/vhost/nginx/$website.conf
echo -e "${Info} ����nginx���������"
sleep 1
##��ʼ��վ����Ϣ
echo -e "${Info} ��������վ�������Ϣ"
cd /www/wwwroot/$website
cp config/.config.php.for7color config/.config.php
sed -i "s/websiteurl/$website/g" /www/wwwroot/$website/config/.config.php
sed -i "s/sspanel-mukey/$sspanelmukey/g" /www/wwwroot/$website/config/.config.php
sed -i "s/sspanel-db-databasename/$mysqldatabase/g" /www/wwwroot/$website/config/.config.php
sed -i "s/sspanel-db-username/$mysqlusername/g" /www/wwwroot/$website/config/.config.php
sed -i "s/sspanel-db-password/$mysqlpassword/g" /www/wwwroot/$website/config/.config.php
echo -e "${Info} ����վ�������Ϣ�����"
sleep 1
##����IP������  ����ssr��ʽ
echo -e "${Info} ��������ip������"
sleep 1
echo -e "${Info} ����ip�����������"
sleep 1
echo -e "${Info} ��������ssr��ʽ"
sleep 1
echo -e "${Info} ����ssr��ʽ�����"
sleep 1
##���붨ʱ����
echo -e "${Info} ������Ӷ�ʱ����"
echo "30 22 * * * php /www/wwwroot/$website/xcat sendDiaryMail" >> /var/spool/cron/root
echo "0 0 * * * php -n /www/wwwroot/$website/xcat dailyjob" >> /var/spool/cron/root
echo "*/1 * * * * php /www/wwwroot/$website/xcat checkjob" >> /var/spool/cron/root
echo "*/1 * * * * php /www/wwwroot/$website/xcat syncnode" >> /var/spool/cron/root
chkconfig �Clevel 35 crond on
/sbin/service crond restart
echo -e "${Info} ��Ӷ�ʱ���������"
sleep 1
##����php��nginx
echo -e "${Info} ��������PHP"
/etc/init.d/php-fpm-71 restart
echo -e "${Info} ����PHP�����"
sleep 1
echo -e "${Info} ��������NGINX"
/etc/init.d/nginx restart
echo -e "${Info} ����NGINX�����"
sleep 3
echo -e "${Tip} ��װ������ɣ������������"
sleep 1
clear
echo "-----------------------------"
echo "#############################"
echo "########           ##########"
echo "########   ##################"
echo "########   ##################"
echo "########           ##########"
echo "###############    ##########"
echo "###############    ##########"
echo "########           ##########"
echo "#############################"
sleep 1
clear
echo "-----------------------------"
echo "#############################"
echo "#######   ####   ############"
echo "#######   ####   ############"
echo "#######   ####   ############"
echo "#######               #######"
echo "##############   ############"
echo "##############   ############"
echo "##############   ############"
echo "#############################"
sleep 1
clear
echo "-----------------------------"
echo "#############################"
echo "########            #########"
echo "#################   #########"
echo "#################   #########"
echo "########            #########"
echo "#################   #########"
echo "#################   #########"
echo "########            #########"
echo "#############################"
sleep 1
clear
echo "-----------------------------"
echo "#############################"
echo "########           ##########"
echo "################   ##########"
echo "################   ##########"
echo "########           ##########"
echo "########   ##################"
echo "########   ##################"
echo "########           ##########"
echo "#############################"
sleep 1
clear
echo "-----------------------------"
echo "#############################"
echo "############   ##############"
echo "############   ##############"
echo "############   ##############"
echo "############   ##############"
echo "############   ##############"
echo "############   ##############"
echo "############   ##############"
echo "#############################"
echo "-----------------------------"
sleep 1
clear
echo "--------------------------------------------------------------------------------"
echo -e "${Info} ������ɣ����http://$website�������"
echo -e "${Info} Ĭ�����ɵĹ���Ա�û�����admin ����Ϊ7colorblog"
echo -e "${Info} ����򲻿�վ�㣬�뵽��������������������nginx��php7.1"
echo -e "${Info} �Զ������ã����/www/wwwroot/$website/config/.config.php�����޸�"
echo -e "${Info} github��ַ:https://github.com/lizhongnian/sspanel-v3-mod-uim-bt"
echo -e "${Info} ���͵�ַ:https://www.7colorblog.com/"
echo "--------------------------------------------------------------------------------"