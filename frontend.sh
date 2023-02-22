echo -e "\e[35mInstalling nginx \e[0m"
yum install nginx -y 
systemctl enable nginx 
systemctl start nginx 
echo -e "\e[35mRemving Old content \e[0m"
rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
cd -
echo -e "\e[35mCopying the config files \e[0m"
cp configs/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[35mEnabling the nginx \e[0m"
systemctl enable nginx 
echo -e "\e[35mRestarting the nginx \e[0m"
systemctl restart nginx 