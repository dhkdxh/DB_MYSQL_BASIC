package util;

import java.util.*;
import java.sql.*;

public class DBUtil {
    private static ResourceBundle bundle;

    static {
        bundle = ResourceBundle.getBundle("util.dbinfo");

        try {
            Class.forName(bundle.getString("driver"));
            System.out.println("success loading!");
        }catch (Exception e) {
            System.out.println("fail loading!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try{
            return DriverManager.getConnection(
                    bundle.getString("url"),
                    bundle.getString("username"),
                    bundle.getString("password")
            );
        }catch (SQLException e){
            System.out.println("fail to connect!");
            e.printStackTrace();
        }
        return null;
    }
}
