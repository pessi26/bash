log_file="/tmp/expense.log"
color="\e[32m"


echo -e ${color} "disable node js utilities \e[0m"
dnf module disable nodejs -y &>>${log_file}
echo $?

echo -e ${color} "enable nodejs utilities \e[0m"
dnf module enable nodejs:18 -y &>>${log_file}
echo $?

echo -e ${color} "install node js utilities \e[0m"
dnf install nodejs -y &>>${log_file}
echo $?

echo -e ${color} "copy backend service file" \e[0m
cp backend.service /etc/systemd/system/backend.service &>>${log_file}
echo $?

echo -e ${color} "enable backend service" \e[0m
systemctl daemon-reload &>>${log_file}
echo $?
systemctl enable backend &>>${log_file}
echo $?
systemctl start backend &>>${log_file}
echo $?

echo -e ${color} "add demon user " \e[0m
useradd expense &>>${log_file}
echo $?

echo -e ${color} "download backend code " \e[0m
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>${log_file}
echo $?

echo -e ${color} "unzip the download " \e[0m
cd /app &>>${log_file}
unzip /tmp/backend.zip &>>${log_file}
echo $?

echo -e ${color} "install npm " \e[0m
cd /app
npm install &>>${log_file}
echo $?

echo -e ${color} "install mysql " \e[0m
dnf install mysql -y &>>${log_file}
mysql -h mysql.pdevops1126.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>${log_file}
echo $?