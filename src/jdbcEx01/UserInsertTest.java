package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class UserInsertTest {

    public static void main(String[] args) {
        String DriverName = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/bookmarkedb?serverTimezone=Asia/Seoul";
        String username = "root";
        String password = "wjsdPdnjs0404!";

        try{
            Class.forName(DriverName);
            System.out.println("Driver loaded OK!");
        } catch (Exception e) {
            System.out.println("Driver loaged failed!");
        }

        try(Connection con = DriverManager.getConnection(url, username, password)){
            System.out.println("AutoCommit 상태: "+ con.getAutoCommit());
            con.setAutoCommit(true);

            String sql = "insert into users(userid,username, userpassword, userage, useremail) values(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql); // 값과 sql문을 분리하기에 sql injection에 효과적

            ps.setString(1, "user100");
            ps.setString(2, "yewon");
            ps.setString(3, "yewon1234");
            ps.setInt(4, 22);
            ps.setString(5, "dhkdxh@naver.com");

            int result = ps.executeUpdate();
            System.out.println("저장된 행의 수:"+result);

            if(result==1){
                System.out.println("Insert successful!");
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
