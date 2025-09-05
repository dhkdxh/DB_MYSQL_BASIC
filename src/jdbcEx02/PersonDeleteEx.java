package jdbcEx02;

import util.DBUtil;

import java.io.DataOutput;
import java.sql.*;

//delete from table명; -> 해당 테이블에 있는 모든 행을 지움
//delete from table명 where pk또는 id로 조건을 주는것이 안전함
//delete from table명 where id = '식별값';
//String sql = "delete from person where num = ?"

public class PersonDeleteEx {
    public static void main(String[] args) {
        Connection con = DBUtil.getConnection();

        //sql문 작성먼저 하기
        String sql = "delete from person where num = ?";
        try(PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1, 1);

            int rows = ps.executeUpdate();
            System.out.println("삭제된 행의 수: "+ rows);

        }catch(SQLException e) {
            e.printStackTrace();
        }
    }
}
