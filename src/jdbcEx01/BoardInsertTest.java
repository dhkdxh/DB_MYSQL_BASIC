package jdbcEx01;

import java.sql.*;

public class BoardInsertTest {

    public static void main(String[] args) {
        String DriverName = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/bookmarkedb?serverTimezone=Asia/Seoul";
        String username = "root";
        String password = "wjsdPdnjs0404!";

        try{
            Class.forName(DriverName);
            System.out.println("Driver loaded OK!");
        } catch (Exception e) {
            System.out.println("Driver loaded failed!");
        }

        try(Connection con = DriverManager.getConnection(url, username, password)){
            System.out.println("AutoCommit 상태: "+ con.getAutoCommit());
            con.setAutoCommit(true);

            String sql = "insert into boards(btitle, bcontent, bwriter, bdate, bfilename,bfiledata) values(?,?,?,now(),?,?)";

            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 값과 sql문을 분리하기에 sql injection에 효과적

            ps.setString(1, "yewon");
            ps.setString(2, "hello world!");
            ps.setString(3, "yewonjeon");
            ps.setString(4, "/sqlstudy/java");
            ps.setString(5, "test01"); //이건 bfiledata
            //filedata는 용량이 클때, 또는 사진을 넣을 때는 new FileInputStream("파일 경로") 이용해서 넣음

            int result = ps.executeUpdate();
            System.out.println("저장된 행의 수:"+result);
            int bno = -1;
            //bno 값 얻기
            if(result==1){
                System.out.println("Insert successful!");
                try(ResultSet rs = ps.getGeneratedKeys()){
                    if(rs.next()){
                        bno = rs.getInt(1);
                        System.out.println("bno = "+ bno);
                    }
                }// 저장된 행 가져와서 확인하는 방법
            }

            //하나의 전체 record 가져오기
            if(bno != -1){

                String selectSql = "SELECT bno,btitle,bcontent,bwriter,bdate,bfilename "+
                        "FROM boards WHERE bno = ?";

                // java에서는 table을 받을 때 ResultSet을 사용
                try(PreparedStatement selectpstmt = con.prepareStatement(selectSql)){
                    selectpstmt.setInt(1, bno);
                    try(ResultSet rs = selectpstmt.executeQuery()){
                        if(rs.next()){//date 타입은 TimeStamp로 받아야함
                            bno = rs.getInt(1);
                            System.out.println("bno = "+ bno);
                            System.out.println("btitle = "+ rs.getString(2));
                            System.out.println("bcontent = " + rs.getString(3));
                            System.out.println("bwriter = "+ rs.getString(4));
                            System.out.println("bdate = " + rs.getTimestamp(5));
                            System.out.println("bfilename = " + rs.getString(6));
                        }
                    }
                }

            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}


