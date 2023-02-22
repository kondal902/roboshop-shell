code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

echo -e "\e[35mInstalling nginx \e[0m"
yum install nginx -y  &>>${log_file}
systemctl enable nginx 
systemctl start nginx 
echo -e "\e[35mRemving Old content \e[0m"
rm -rf /usr/share/nginx/html/* &>>${log_file}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>${log_file}
echo -e "\e[35mCopying the config files \e[0m"
cp ${code_dir}/configs/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo -e "\e[35mEnabling the nginx \e[0m"
systemctl enable nginx  &>>${log_file}
echo -e "\e[35mRestarting the nginx \e[0m"
systemctl restart nginx &>>${log_file}