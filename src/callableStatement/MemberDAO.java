package callableStatement;

import com.mysql.cj.xdevapi.DbDocValueFactory;
import util.DBUtil;

import java.util.*;
import java.sql.*;

public class MemberDAO {
    private Connection conn;

    public MemberDAO() {}

    public void member_insert(){
        conn = DBUtil.getConnection();
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

    public void member_update(){
        conn = DBUtil.getConnection();
        String sql = "{CALL SP_MEMBER_UPDATE(?,?,?)}";
        int menu = 1; //pwd
        String m_userid = "blackpink";
        String content = "blackpink1234"; //pwd

        try(CallableStatement cs = conn.prepareCall(sql)){
            conn.setAutoCommit(false);
            cs.setInt(1, menu);
            cs.setString(2, m_userid);
            cs.setString(3, content);

            boolean result = cs.execute();
            if(result){
                System.out.println("update success!");
            }else{
                System.out.println("update fail!");
            }
        }catch(SQLException e){
            try{conn.rollback();} catch(SQLException e1){e.printStackTrace();}
        }
    }

    public void member_delete(){
        conn = DBUtil.getConnection();
        String sql = "{CALL SP_MEMBER_DELETE(?)}";
        String delete_userid = "blackpink";

        try(CallableStatement cs = conn.prepareCall(sql)){
            cs.setString(1, delete_userid);

            boolean result = cs.execute();

            if(result) System.out.println("update success!");
            else System.out.println("update fail!");

        }catch(SQLException e){
            try{conn.rollback();} catch(SQLException e1){e.printStackTrace();}
        }
    }

    public void selectAll(){
        conn = DBUtil.getConnection();
        String sql = "{call SP_MEMBER_LIST()}";

        try(CallableStatement cs = conn.prepareCall(sql); ResultSet rs = cs.executeQuery()) {
            conn.setAutoCommit(false);

            while(rs.next()){
                System.out.println("m_seq: "+rs.getInt(1));
                System.out.println("m_userid: "+rs.getString(2));
                System.out.println("m_pwd: "+rs.getString(3));
                System.out.println("m_email: "+rs.getString(4));
                System.out.println("m_hp: "+rs.getString(5));
                System.out.println("m_registdate: "+rs.getDate(6));
                System.out.println("m_point: "+rs.getInt(7));
                System.out.println("=============================================");
            }
        }catch(SQLException e){
            try{conn.rollback();}catch(SQLException e1){e.printStackTrace();}
        }
    }

    public void selectOne(){
        conn = DBUtil.getConnection();
        String sql = "{CALL SP_MEMBER_CHECK(?)}";
    }
}

