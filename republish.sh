#!/bin/bash
# created by Ruoyu

echo ""
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@！！！This script will restart Tomcat service, the live network will be impacted！！！@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo ""
read -n1 -p  "#The manager portal will be republished，pls make sure continue or not? [Y/N]" result

case $result in
Y | y)

	echo ""
	echo "-----Check current path-----"
	cd /apprun/tomcat/webapps
	echo `pwd`
	sleep 2
	echo ""

	echo "-----Backup the current file-----"
	cp /apprun/tomcat/webapps/open_mssportal.war ../bak/open_mssportal.war.bak_`date +%Y%m%d`
#	cp /apprun/tomcat/webapps/a.txt ../bak/a.txt.bak_`date +%Y%m%d`
	sleep 2
	echo "ls /apprun/tomcat/bak | grep mssportal"
	for i in `ls  /apprun/tomcat/webapps | grep mssportal`;do echo $i;done
	sleep 2
	echo ""

	echo ""
	echo "-----Stop Tomcat Service, Waiting about 15s-----"
	sudo systemctl stop tomcat
#	echo `sudo systemctl stop tomcat`
	sleep 15
	check1=`systemctl status tomcat | grep Active:`
	echo ""
	echo "---Pls check Tomcat status---"
	echo "$check1"
	sleep 2
	echo ""

	read -n1 -p  "Pls make sure the Tomcat is stopped? [Y/N]" tomcatresult
	case $tomcatresult in
	Y | y)	
		echo ""
		echo "-----Delete Old file-----"
		rm -rf /apprun/tomcat/webapps/manage*
#		rm -rf /apprun/tomcat/webapps/a.txt
		echo ""
		echo "ls  /apprun/tomcat/webapps "
		for i in `ls  /apprun/tomcat/webapps`;do echo $i;done
		sleep 2
		echo ""
		
		echo "-----Copy the new file to dedicate path-----"
		mv /apprun/tomcat/webapps/open_mssportal.war /apprun/tomcat/webapps/manager.war
#		mv /apprun/tomcat/webapps/b.txt /apprun/tomcat/webapps/c.txt
		echo ""
		echo "ls /apprun/tomcat/webapps | grep manager"
		for i in `ls  /apprun/tomcat/webapps | grep manager.war`;do echo $i;done
#		for i in `ls  /apprun/tomcat/webapps | grep c.txt`;do echo $i;done
		sleep 3
		echo ""
		
		echo "-----Start Tomcat Service, wating about 10s-----"
		sudo systemctl start tomcat
		sleep 5
		check2=`systemctl status tomcat | grep Active:`

		echo ""
		echo "$check2"
		echo ""
		echo "Pls check the Tomcat status"
		sleep 2
		echo "The script completed, pls check the logs by yourself"
		;;	
	N | n)
		echo"Pls check Tomcat status and re-try script";;
        esac
	exit 0

;;

N | n)
	echo ""
        echo "Ok,Good Bye";;

*)
	echo ""
        echo "pls input Y or N";;
esac
exit 0
