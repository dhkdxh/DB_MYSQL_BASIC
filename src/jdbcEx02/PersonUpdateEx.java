package jdbcEx02;

//update table명 set (필드 = '수정값') where num=1;
//String sql = update person set id= ?, name = ? where num = ? -> 이런식으로 매개 변수 값을 matching 해줄 수 있음
//String sql2 = new StringBuilder().append(sql).toString(); -> 알아보기 쉽게 하나씩 문자열을 append로 추가해줄 수도 있음 주의할점: 세미콜론은 들어가지 않음

import util.DBUtil;

import java.sql.*;
public class PersonUpdateEx {
    public static void main(String[] args) {
        Connection connection = DBUtil.getConnection();

        //매개변수화된 update sql문 작성
        String sql = new StringBuilder().append(" update person set ")
                .append("id = ? ,").append("name = ?").append(" where num = ?").toString();

        try(PreparedStatement ps = connection.prepareStatement(sql)){

            ps.setInt(1, 150);
            ps.setString(2, "도우너");
            ps.setInt(3, 1);

            //sql 실행 -> server에 보내야함
            //insert update delete할 때는 executeUpdate()
            //query(select) 는 executeQuery()
            int rows = ps.executeUpdate();

            System.out.println(rows + " rows updated!");

        }catch (SQLException e){
            System.out.println(e.getMessage());
        }
    }
}
