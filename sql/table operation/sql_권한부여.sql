-- root 계정으로 현재 접속 중(DBA)
-- bookmarketdb 데이터베이스 생성 -> 새로운 무언가를 만드려면 admin 계정 권한이 있는 곳으로 가야함
create database bookmarkedb; -- schemas 생성: 물리적인 공간이 만들어짐

-- bookadmin 계정 생성, 비밀번호 설정하려면 identified by
create user bookadmin@localhost identified by 'bookadmin'; -- 실습용이므로 local에서 사용할거니 @ -> 외부로 갈거면 %

-- 이후 bookadmin 계정한테 bookmarketdb에 접속하여 운영 관리할 수 있는 권한을 부여해야함(grant)
grant all privileges on bookmarkedb.* to bookadmin@localhost;