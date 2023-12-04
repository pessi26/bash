#frontend script
log_file="/tmp/expense.log"
color="\e[32m"

echo -e "${color} installing Nginx \e[0m"
dnf install nginx -y &>>${log_file}
echo $?

echo -e "${color} copying the configuration file\e[0m"
cp expense.conf  /etc/nginx/default.d/expense.conf &>>${log_file}
echo $?

echo -e "${color} enable nginx service \e[0m"
systemctl enable nginx &>>${log_file}
echo $?
echo -e "${color} starting nginx service \e[0m"
systemctl start nginx &>>${log_file}
echo $?
echo -e "${color} remove default files in nginx \e[0m"
rm -rf /usr/share/nginx/html/* &>>${log_file}
echo $?

echo -e "${color} download software \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
echo $?
echo -e "${color} extract software \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}
echo $?

systemctl restart nginx &>>${log_file}
echo $?
