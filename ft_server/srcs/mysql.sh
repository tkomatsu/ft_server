service mysql start
echo "CREATE DATABASE wpdb;" | mysql -u root
echo "CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';" | mysql -u root 
echo "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';" | mysql -u root 
echo "FLUSH PRIVILEGES;" | mysql -u root
