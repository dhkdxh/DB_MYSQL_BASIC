package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionTest {

    public static void main(String[] args) {
        String DriverName = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/bookmarkedb?serverTimezone=Asia/Seoul";
        String username = "root";
        String password = "wjsdPdnjs0404!";

        try{
            Class.forName(DriverName);
            System.out.println("Driver loaded OK!");
        } catch (Exception e) {
            System.out.println("Driver could not be loaded!");
        }

        try(Connection con = DriverManager.getConnection(url, username, password)) {
            System.out.println("AutoCommit 상태: "+ con.getAutoCommit());
            con.setAutoCommit(true); // transaction false 처리
            Statement stmt = con.createStatement();
            int result = stmt.executeUpdate("INSERT INTO person(id, name) values (100,'홍길동')");
            if(result == 1){
                System.out.println("Insert successful!");
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}
