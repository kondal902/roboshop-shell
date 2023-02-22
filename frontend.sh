code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head(){
echo -e "\e[35m$1\e[0m"
}

print_head "Installing nginx"
yum install nginx -y  &>>${log_file}
systemctl enable nginx 
systemctl start nginx 

print_head "Remving Old content"
rm -rf /usr/share/nginx/html/* &>>${log_file}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>${log_file}
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>${log_file}

print_head "Copying the config files"
cp ${code_dir}/configs/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
print_head "Enabling the nginx"
systemctl enable nginx  &>>${log_file}
print_head "Restarting the nginx"
systemctl restart nginx &>>${log_file}