# U-07
echo ""   
	echo "■ U-07(상) | 2. 파일 및 디렉토리 관리 > 2.3 /etc/passwd 파일 소유자 및 권한 설정"   
	echo " 양호 판단기준 : /etc/passwd 파일의 소유자가 root이고, 권한이 644 이하인 경우"   
	if [ -f /etc/passwd ]; then		 
		etc_passwd_owner_name=`ls -l /etc/passwd | awk '{print $3}'`
		if [[ $etc_passwd_owner_name =~ root ]]; then
			etc_passwd_permission=`stat /etc/passwd | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'` # stat : 디렉터리나 파일의 상세 정보를 표시하는 명령어
			if [ $etc_passwd_permission -le 644 ]; then
				etc_passwd_owner_permission=`stat /etc/passwd | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,1)}'`
				if [ $etc_passwd_owner_permission -eq 0 ] || [ $etc_passwd_owner_permission -eq 2 ] || [ $etc_passwd_owner_permission -eq 4 ] || [ $etc_passwd_owner_permission -eq 6 ]; then
					etc_passwd_group_permission=`stat /etc/passwd | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,4,1)}'`
					if [ $etc_passwd_group_permission -eq 0 ] || [ $etc_passwd_group_permission -eq 4 ]; then
						etc_passwd_other_permission=`stat /etc/passwd | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,5,1)}'`
						if [ $etc_passwd_other_permission -eq 0 ] || [ $etc_passwd_other_permission -eq 4 ]; then
							echo "■ U-07 결과 : 양호"  
							
						else
							echo "■ U-07 결과 : 취약"  
							echo " /etc/passwd 파일의 다른 사용자(other)에 대한 권한이 취약합니다."  
							
						fi
					else
						echo "■ U-07 결과 : 취약"  
						echo " /etc/passwd 파일의 그룹 사용자(group)에 대한 권한이 취약합니다."  
						
					fi
				else
					echo "■ U-07 결과 : 취약"  
					echo " /etc/passwd 파일의 사용자(owner)에 대한 권한이 취약합니다."  
					
				fi
			else
				echo "■ U-07 결과 : 취약"  
				echo " /etc/passwd 파일의 권한이 644보다 큽니다."  
				
			fi
		else
			echo "■ U-07 결과 : 취약"  
			echo " /etc/passwd 파일의 소유자(owner)가 root가 아닙니다."  
			
		fi
	else
		echo "■ U-07 결과 : N/A"  
		echo " /etc/passwd 파일이 없습니다."  
		
	fi
	
	
# U-09
	echo ""
	echo "■ U-09(상) | 2. 파일 및 디렉토리 관리 > 2.5 /etc/hosts 파일 소유자 및 권한 설정 "
	echo " 양호 판단 기준 : /etc/hosts 파일의 소유자가 root이고, 권한이 600인 이하인 경우"
	if [ -f /etc/hosts ]; then
		etc_hosts_owner_name=`ls -l /etc/hosts | awk '{print $3}'`
		if [[ $etc_hosts_owner_name =~ root ]]; then
			etc_hosts_permission=`stat /etc/hosts | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
			if [ $etc_hosts_permission -le 600 ]; then
				etc_hosts_owner_permission=`stat /etc/hosts | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,1)}'`
				if [ $etc_hosts_owner_permission -eq 0 ] || [ $etc_hosts_owner_permission -eq 2 ] || [ $etc_hosts_owner_permission -eq 4 ] || [ $etc_hosts_owner_permission -eq 6 ]; then
					etc_hosts_group_permission=`stat /etc/hosts | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,4,1)}'`
					if [ $etc_hosts_group_permission -eq 0 ]; then
						etc_hosts_other_permission=`stat /etc/hosts | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,5,1)}'`
						if [ $etc_hosts_other_permission -eq 0 ]; then
							echo "※ U-09 결과 : 양호"
							
						else
							echo "※ U-09 결과 : 취약"
							echo " /etc/hosts 파일의 다른 사용자(other)에 대한 권한이 취약합니다."
							
						fi
					else
						echo "※ U-09 결과 : 취약"
						echo " /etc/hosts 파일의 그룹 사용자(group)에 대한 권한이 취약합니다."
						
					fi
				else
					echo "※ U-09 결과 : 취약" 
					echo " /etc/hosts 파일의 사용자(owner)에 대한 권한이 취약합니다." 
					
				fi
			else
				echo "※ U-09 결과 : 취약" 
				echo " /etc/hosts 파일의 권한이 600보다 큽니다." 
				
			fi
		else
			echo "※ U-09 결과 : 취약" 
			echo " /etc/hosts 파일의 소유자(owner)가 root가 아닙니다." 
			
		fi
	else
		echo "※ U-09 결과 : N/A" 
		echo " /etc/hosts 파일이 없습니다." 
		
	fi
	
	
#U-11
echo ""
	echo "■ U-11(상) | 2. 파일 및 디렉토리 관리 > 2.7 /etc/syslog.conf 파일 소유자 및 권한 설정 "
	echo " 양호 판단 기준 : /etc/syslog.conf 파일의 소유자가 root(또는 bin, sys)이고, 권한이 640 이하인 경우"
	syslogconf_files=("/etc/rsyslog.conf" "/etc/syslog.conf" "/etc/syslog-ng.conf")
	file_exists_count=0
	for ((i=0; i<${#syslogconf_files[@]}; i++))
	do
		if [ -f ${syslogconf_files[$i]} ]; then
			((file_exists_count++))
			syslogconf_file_owner_name=`ls -l ${syslogconf_files[$i]} | awk '{print $3}'`
			if [[ $syslogconf_file_owner_name =~ root ]] || [[ $syslogconf_file_owner_name =~ bin ]] || [[ $syslogconf_file_owner_name =~ sys ]]; then
				syslogconf_file_permission=`stat ${syslogconf_files[$i]} | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
				if [ $syslogconf_file_permission -le 640 ]; then
					syslogconf_file_owner_permission=`stat ${syslogconf_files[$i]} | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,1)}'`
					if [ $syslogconf_file_owner_permission -eq 6 ] || [ $syslogconf_file_owner_permission -eq 4 ] || [ $syslogconf_file_owner_permission -eq 2 ] || [ $syslogconf_file_owner_permission -eq 0 ]; then
						syslogconf_file_group_permission=`stat ${syslogconf_files[$i]} | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,4,1)}'`
						if [ $syslogconf_file_group_permission -eq 4 ] || [ $syslogconf_file_group_permission -eq 2 ] || [ $syslogconf_file_group_permission -eq 0 ]; then
							syslogconf_file_other_permission=`stat ${syslogconf_files[$i]} | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,5,1)}'`
							if [ $syslogconf_file_other_permission -ne 0 ]; then
								echo "※ U-11 결과 : 취약" 
								echo " ${syslogconf_files[$i]} 파일의 다른 사용자(other)에 대한 권한이 취약합니다." 
								
							fi
						else
							echo "※ U-11 결과 : 취약" 
							echo " ${syslogconf_files[$i]} 파일의 그룹 사용자(group)에 대한 권한이 취약합니다." 
							
						fi
					else
						echo "※ U-11 결과 : 취약" 
						echo " ${syslogconf_files[$i]} 파일의 사용자(owner)에 대한 권한이 취약합니다." 
						
					fi
				else
					echo "※ U-11 결과 : 취약" 
					echo " ${syslogconf_files[$i]} 파일의 권한이 640보다 큽니다." 
					
				fi
			else
				echo "※ U-11 결과 : 취약" 
				echo " ${syslogconf_files[$i]} 파일의 소유자(owner)가 root(또는 bin, sys)가 아닙니다." 
				
			fi
		fi
	done
	if [ $file_exists_count -eq 0 ]; then
		echo "※ U-11 결과 : N/A" 
		echo " /etc/syslog.conf 파일이 없습니다." 
		
	else
		echo "※ U-11 결과 : 양호" 
		
	fi

#U-12
echo ""
	echo "■ U-12(상) | 2. 파일 및 디렉토리 관리 > 2.8 /etc/services 파일 소유자 및 권한 설정 "
	echo " 양호 판단 기준 : /etc/services 파일의 소유자가 root(또는 bin, sys)이고, 권한이 644 이하인 경우"
	if [ -f /etc/services ]; then
		etc_services_owner_name=`ls -l /etc/services | awk '{print $3}'`
		if [[ $etc_services_owner_name =~ root ]] || [[ $etc_services_owner_name =~ bin ]] || [[ $etc_services_owner_name =~ sys ]]; then
			etc_services_permission=`stat /etc/services | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
			if [ $etc_services_permission -le 644 ]; then
				etc_services_owner_permission=`stat /etc/services | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,3,1)}'`
				if [ $etc_services_owner_permission -eq 6 ] || [ $etc_services_owner_permission -eq 4 ] || [ $etc_services_owner_permission -eq 2 ] || [ $etc_services_owner_permission -eq 0 ]; then
					etc_services_group_permission=`stat /etc/services | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,4,1)}'`
					if [ $etc_services_group_permission -eq 4 ] || [ $etc_services_group_permission -eq 0 ]; then
						etc_services_other_permission=`stat /etc/services | grep -i 'Uid' | awk '{print $2}' | awk -F / '{print substr($1,5,1)}'`
						if [ $etc_services_other_permission -eq 4 ] || [ $etc_services_other_permission -eq 0 ]; then
							echo "※ U-12 결과 : 양호" 
							
						else
							echo "※ U-12 결과 : 취약" 
							echo " /etc/services 파일의 다른 사용자(other)에 대한 권한이 취약합니다." 
							
						fi
					else
						echo "※ U-12 결과 : 취약" 
						echo " /etc/services 파일의 그룹 사용자(group)에 대한 권한이 취약합니다." 
						
					fi
				else
					echo "※ U-12 결과 : 취약" 
					echo " /etc/services 파일의 사용자(owner)에 대한 권한이 취약합니다." 
					
				fi
			else
				echo "※ U-12 결과 : 취약" 
				echo " /etc/services 파일의 권한이 644보다 큽니다." 
				
			fi
		else
			echo "※ U-12 결과 : 취약" 
			echo " /etc/services 파일의 파일의 소유자(owner)가 root(또는 bin, sys)가 아닙니다." 
			
		fi
	else
		echo "※ U-12 결과 : N/A" 
		echo " /etc/services 파일이 없습니다." 
		
	fi

#U-13
echo ""
	echo "■ U-13(상) | 2. 파일 및 디렉토리 관리 > 2.9 SUID, SGID, 설정 파일점검 "
	echo " 양호 판단 기준 : 주요 실행파일의 권한에 SUID와 SGID에 대한 설정이 부여되어 있지 않은 경우"
	executables=("/sbin/dump" "/sbin/restore" "/sbin/unix_chkpwd" "/usr/bin/at" "/usr/bin/lpq" "/usr/bin/lpq-lpd" "/usr/bin/lpr" "/usr/bin/lpr-lpd" "/usr/bin/lprm" "/usr/bin/lprm-lpd" "/usr/bin/newgrp" "/usr/sbin/lpc" "/usr/sbin/lpc-lpd" "/usr/sbin/traceroute")
	for ((i=0; i<${#executables[@]}; i++))
	do
		if [ -f ${executables[$i]} ]; then
			if [ `ls -l ${executables[$i]} | awk '{print substr($1,2,9)}' | grep -i 's' | wc -l` -gt 0 ]; then
				echo "※ U-13 결과 : 취약" 
				echo " 주요 실행 파일의 권한에 SUID나 SGID에 대한 설정이 부여되어 있습니다." 
				
			fi
		fi
	done
	echo "※ U-13 결과 : 양호" 
	

#U-15
echo ""
	echo "■ U-15(상) | 2. 파일 및 디렉토리 관리 > 2.11 world writable 파일 점검 "
	echo " 양호 판단 기준 : 시스템 중요 파일에 world writable 파일이 존재하지 않거나, 존재 시 설정 이유를 확인하고 있는 경우"
	if [ `find / -type f -perm -2 2>/dev/null | wc -l` -gt 0 ]; then
		echo "※ U-15 결과 : 취약" 
		echo " world writable 설정이 되어있는 파일이 있습니다." 
		
	else
		echo "※ U-15 결과 : 양호" 
		
	fi

#U-16
echo ""
	echo "■ U-16(상) | 2. 파일 및 디렉토리 관리 > 2.12 /dev에 존재하지 않는 device 파일 점검 "
	echo " 양호 판단 기준 : /dev에 대한 파일 점검 후 존재하지 않은 device 파일을 제거한 경우" 
	if [ `find /dev -type f 2>/dev/null | wc -l` -gt 0 ]; then
		echo "※ U-16 결과 : 취약" 
		echo " /dev 디렉터리에 존재하지 않는 device 파일이 존재합니다." 
		
	else
		echo "※ U-16 결과 : 양호" 
		
	fi

#U-44
echo ""
	echo "■ U-44(중) | 1. 계정관리 > 1.5 root 이외의 UID가 '0' 금지 "
	echo " 양호 판단 기준 : root 계정과 동일한 UID를 갖는 계정이 존재하지 않는 경우" 
	if [ -f /etc/passwd ]; then
		if [ `awk -F : '$3==0 {print $1}' /etc/passwd | grep -vx 'root' | wc -l` -gt 0 ]; then
			echo "※ U-44 결과 : 취약" 
			echo " root 계정과 동일한 UID(0)를 갖는 계정이 존재합니다." 
			
		else
			echo "※ U-44 결과 : 양호" 
			
		fi
	fi

#U-62
echo ""
	echo "■ U-62(중) | 3. 서비스 관리 > 3.26 ftp 계정 shell 제한 "
	echo " 양호 판단 기준 : ftp 계정에 /bin/false 쉘이 부여되어 있는 경우" 
	if [ `awk -F : '$1=="ftp" && $7=="/bin/false"' /etc/passwd | wc -l` -gt 0 ]; then
		echo "※ U-62 결과 : 양호" 
		
	else
		echo "※ U-62 결과 : 취약" 
		echo " ftp 계정에 /bin/false 쉘이 부여되어 있지 않습니다." 
		
	fi

#U-66
echo ""
	echo "■ U-66(중) | 3. 서비스 관리 > 3.30 SNMP 서비스 구동 점검 "
	echo " 양호 판단 기준 : SNMP 서비스를 사용하지 않는 경우" 
	if [ `ps -ef | grep -i 'snmp' | grep -v 'grep' | wc -l` -gt 0 ]; then
		echo "※ U-66 결과 : 취약" 
		echo " SNMP 서비스를 사용하고 있습니다." 
		
	else
		echo "※ U-66 결과 : 양호" 
		
	fi