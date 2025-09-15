use bookmarkedb;

-- sample table 생성
create table code1 (
    cid int, cname varchar(50)
);

desc code1;

insert into code1(cid, cname)
select ifnull(max(cid), 0)+1 as cids2, 'Test' as cName2
from code1;
-- 다른 테이블에 있는 data를 옮겨담을 떄 (backup할 떄)

select * from code1;
truncate code1;

-- 프로시저 생성
drop procedure if exists p_insertcodes;
delimiter ##
create procedure p_insertcodes(in cData varchar(255), in cTname varchar(255), out resultMsg varchar(255))
begin
    set @strsql = concat('insert into ', cTname ,'(cid,cname) ', 'select coalesce(max(cid),0)+1, ? from ', cTname);

    set @cData = cData;
    set @resultMsg = 'Insert Success!';

    prepare stmt from @strsql;
    execute stmt using @cData;
    deallocate prepare stmt;
    commit;
end ##
delimiter ;

-- null을 방지하기 위해 사용하는 coalesce 함수-> 인수가 여러개 있으면 왼쪽부터 확인해서 넣음

set @resultMsg = ' ';
call p_insertcodes('프론트 디자이너', 'code1', @resultMsg);
select * from code1;

CREATE TABLE TB_MEMBER (
                           m_seq INT AUTO_INCREMENT PRIMARY KEY,  -- 자동 증가 시퀀스
                           m_userid VARCHAR(20) NOT NULL,
                           m_pwd VARCHAR(20) NOT NULL,
                           m_email VARCHAR(50) NULL,
                           m_hp VARCHAR(20) NULL,
                           m_registdate DATETIME DEFAULT NOW(),  -- 기본값: 현재 날짜와 시간
                           m_point INT DEFAULT 0
);

drop procedure if exists sp_member_insert;
delimiter ##
CREATE PROCEDURE SP_MEMBER_INSERT(
    IN V_USERID VARCHAR(20),
    IN V_PWD VARCHAR(20),
    IN V_EMAIL VARCHAR(50),
    IN V_HP VARCHAR(20),
    OUT RTN_CODE INT
)
begin
    declare count int;

    select count(m_seq) into count from tb_member where m_userid = V_USERID;
    if count > 0 then
        set RTN_CODE = 100;
    else
        set @userid = V_USERID;
        set @pwd = V_PWD;
        set @email = V_EMAIL;
        set @hp = V_HP;

        set @strsql = concat('insert into tb_member (m_seq, m_userid, m_pwd, m_email, m_hp) values(null, ?, ?, ?, ?)');

        prepare stmt from @strsql;
        execute stmt using @userid, @pwd, @email, @hp;
        set RTN_CODE = 200;
        deallocate prepare stmt;
    end if; commit;
end ##
delimiter ;

call SP_MEMBER_INSERT('apple', '1111', 'apple@sample.com', '010-9898-9999',@rtn);
select @rtn;
select * from TB_MEMBER;
show create procedure SP_MEMBER_INSERT;

drop procedure if exists SP_MEMBER_LIST;
delimiter ##
create procedure SP_MEMBER_LIST()
begin
    set @strsql = 'select * from TB_MEMBER';

    prepare stmt from @strsql;
    execute stmt;
    deallocate prepare stmt;
end ##
delimiter ;

call SP_MEMBER_LIST();

desc tb_member;

drop procedure if exists SP_MEMBER_CHECK;
delimiter ##
create procedure SP_MEMBER_CHECK(in userid varchar(20))
begin
    set @userid = userid;
    set @sqlstr = 'select * from tb_member where m_userid =?';

    prepare stmt from @sqlstr;
    execute stmt using @userid;
    deallocate prepare stmt;
end ##
delimiter ;

call sp_member_check('apple');

drop procedure if exists SP_MEMBER_UPDATE;
delimiter ##
create procedure SP_MEMBER_UPDATE(in menu int, in id varchar(20), in variable varchar(50))
begin
    case menu
        when 1 then set @sqlstr = 'update tb_member set m_pwd = ? where m_userid = ?';
        when 2 then set @sqlstr = 'update tb_member set m_email = ? where m_userid= ?';
        when 3 then set @sqlstr = 'update tb_member set m_hp = ? where m_userid = ?';
        else  set @sqlstr = 'select invalid menu';
    end case;

    set @var = variable;
    set @id = id;
    prepare stmt from @sqlstr;
    execute stmt using @var, @id;
    deallocate prepare stmt;
end ##
delimiter ;

call sp_member_update(1, 'apple', '2222');
select * from tb_member;

drop procedure if exists SP_MEMBER_DELETE;
delimiter ##
create procedure SP_MEMBER_DELETE(in userid varchar(20))
begin
    set @sqlstr = 'delete from tb_member where m_userid = ?';

    set @userid = userid;
    prepare stmt from @sqlstr;
    execute stmt using @userid;
    deallocate prepare stmt;
end ##
delimiter ;

call sp_member_delete('blackpink');
select * from tb_member;


