create database movie;

use movie;

create table movies(
                       movie_ID int auto_increment, -- 자동 지정
                       movie_title varchar(20) not null,
                       movie_director varchar(20) not null,
                       main_actor varchar(20) not null,
                       movie_script longtext,
                       movie_film longblob,
                       constraint pk_movie_movie_id primary key (movie_id) -- 제약조건에 이름(pk_movie_movie_id)을 붙여서 나중에 이 제약조건을 관리하기 쉽게 함 /primary key (movie_id) = movie아이디를 기본카로 설정한다는 뜻
)default charset=utf8mb4; -- 한글을 문제없이 처리하기 위해 기본문자셋을 UTF8mb4로 저장함

desc movies;

insert into movies values (
                              null,'쉰들러 리스트','스필버그','리암니슨',
                              load_file('C:/mystudy/movies/Shawshank.txt'),
                              load_file('C:/mystudy/movies/Shawshank.mp4')
                          );

insert into movies values (
                              null,'쇼생크 탈출','프랭크다라본트','팀 로빈슨',
                              load_file('C:/mystudy/movies/Schindler.txt'),
                              load_file('C:/mystudy/movies/Schindler.mp4')
                          );

insert into movies values (
                           null, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스',
                           load_file('C:/mystudy/movies/Mohican.txt'),
                           load_file('C:/mystudy/movies/Mohican.mp4')
                          );


-- moive table의 data만 삭제
truncate movies;

select * from movies;


-- 영화 스크립트와 영화 동영상이 입력되지 않은 이유
/*
   1. 최대 패킷 크기 (최대 파일 크기)가 설정된 시스템 변수인 max_allowed_packet확인하여 늘려주어야 한다.
*/

show variables like 'max_allowed_packet';


/*
   2. 파일을 업로드/다운로드 할 폴더의 경로를 별도로 허용해 주어야 한다.
    시스템 변수 secure_file_priv 설정 값 확인 -> C:\ProgramData\MySQL\MySQL Server 8.0\Uploads 여기에 올려줘야 동영상과 글 확인 가능
*/

-- 입력된 데이터를 파일로 download -> Shawshank_out.txt라는 파일에
select movie_script from movies where movie_id = 1
into outfile 'C:/mystudy/movies/Shawshank_out.txt' lines terminated by '\\n';
-- 줄바꿈 문자도 그대로 저장해서 가져오겠다는 의미의 lines terminated by '\\n'
-- privilege 해놓은 곳에만 저장됨

-- 영화 동영상(movie_film) into dumpfile 문을 사용ㅎ아ㅕ 바이너리 파일로 다운로드 할 수 있음
select movie_film from movies where movie_id = 1
into dumpfile 'C:/mystudy/movies/Shawshank_out.mp4';