package jdbc_boards.util;

import java.util.*;
import java.sql.*;

public class DButil {
    private static ResourceBundle bundle;

    static {
        bundle = ResourceBundle.getBundle("util.dbinfo");

        try {
            Class.forName(bundle.getString("driver"));
            System.out.println("드라이버 로딩 성공");
        }catch(ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    //connection null이 뜨면 DBUtil에서 무조건 문제 생긴 것임
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(
                    bundle.getString("url"),
                    bundle.getString("user"),
                    bundle.getString("password"));
        } catch (SQLException e) {
            System.out.println("연결 실패");
            return null;
        }
    }
}
