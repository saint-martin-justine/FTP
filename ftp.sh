#/bin/bash
cd /home/debian11/ftp/list.csv
cat list.csv | while read varligne
do
	password=`echo $varligne |cut -d ',' -f4`
	username=`echo $varligne |cut -d ',' -f2`
	username=`echo ${username,,}`
	role=`echo $varligne |cut -d ',' -f5`
	echo $role
	if [ ${role:0:5} = "Admin" ]
	then
		echo "creation de l'utilisateur : $username"
		#sudo useradd -m -d /home/$username $username
		sudo useradd -m $username -p $password
		echo "changement du role de : $username"
		sudo usermod -aG sudo $username
		#echo $username:$password | chpasswd
	else 
		echo "creation de l'utilisateur : $username"
		#sudo useradd -m -d /home/$username $username
		sudo useradd -m $username -p $password
		#echo "$username:$password" | chpasswd
	fi
done < <(tail -n +2 list.csv)
