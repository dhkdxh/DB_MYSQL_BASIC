package jdbcEx02;

import util.DBUtil;

import java.util.*;
import java.sql.*;

public class AccountsInsertEx {
    public static void main(String[] args) {
        try{
            Connection con = DBUtil.getConnection();

            String sql = new StringBuilder().append("Insert into accounts(ano, owner, balance) ")
                    .append("values(?,?,?)").toString();

            try(PreparedStatement ps = con.prepareStatement(sql)){
                ps.setString(1, "111-222-333-4444");
                ps.setString(2, "전예원");
                ps.setInt(3, 100000);

                int result = ps.executeUpdate();
                if(result == 1){
                    System.out.println("Insert successful!");
                }
            }catch(SQLException e){
                e.printStackTrace();
            }

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
