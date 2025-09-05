create database shop_db;
create user shopadmin@localhost identified by 'shop1234!';
grant all privileges on shop_db.* to shopadmin@localhost; 