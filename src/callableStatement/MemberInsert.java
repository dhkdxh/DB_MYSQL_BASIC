package callableStatement;

import util.DBUtil;

import java.util.*;
import java.sql.*;

public class MemberInsert {
    static Connection conn = DBUtil.getConnection();


    public static void main(String[] args) {
        String sql = "{CALL SP_MEMBER_INSERT(?,?,?,?,?)}";// in과 out parameter 동시에 ?로 처리함
        String m_userid = "blackpink";
        String m_pwd = "blackpink";
        String m_email = "blackpink@gmail.com";
        String m_hp = "010-1234-1234";


        try(CallableStatement call = conn.prepareCall(sql);){
            conn.setAutoCommit(false);
            //in parameter setting
            call.setString(1, m_userid);
            call.setString(2, m_pwd);
            call.setString(3, m_email);
            call.setString(4, m_hp);

            //out parameter setting
            call.registerOutParameter(5, java.sql.Types.INTEGER);

            //실행
            call.execute();

            int rtn = call.getInt(5);

            if(rtn == 100) {conn.rollback();//rollback은 되돌리는 것임
                System.out.println("이미 가입된 사용자입니다.");}
            else {
                conn.commit();
                System.out.println("회원 가입이 되었습니다. 감사합니다.");
            }
        }catch(SQLException e){
            try{conn.rollback();} catch(SQLException e1){
                e1.printStackTrace();
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
