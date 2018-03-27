drop user mmind@localhost;
create user mmind@localhost identified by 'replace_this_with_real_password';
grant all privileges on mmind.* to mmind@localhost;
flush privileges;
