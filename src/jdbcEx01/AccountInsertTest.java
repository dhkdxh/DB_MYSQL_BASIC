package jdbcEx01;

import java.sql.*;

public class AccountInsertTest {

    public static void main(String[] args) {
        String DriverName = "com.mysql.cj.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/bookmarkedb?serverTimezone=Asia/Seoul";
        String username = "root";
        String password = "wjsdPdnjs0404!";

        try{
            Class.forName(DriverName);
            System.out.println("Driver loaded Ok!");
        }catch(Exception e){
            System.out.println("Driver loaded failed!");
        }

        try(Connection con = DriverManager.getConnection(url, username, password)){
            con.setAutoCommit(true);

            String sql = "insert into accounts(ano, owner, balance) values(?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, "1111-1212-3232-12121");
            ps.setString(2, "홍길동");
            ps.setInt(3, 100000);

            int result = ps.executeUpdate();
            System.out.println("저장된 행의 수:" + result+"\n");

            String ano = "1111-1212-3232-12121";

            if(result==1) {

                if(ano != null){
                    String selectsql = "select ano,owner,balance from accounts where ano = ?";

                    try(PreparedStatement selectpstmt = con.prepareStatement(selectsql)){
                        selectpstmt.setString(1, ano);
                        try(ResultSet rs = selectpstmt.executeQuery()){
                            if(rs.next()){
                                System.out.println("=====================================");
                                System.out.println("계좌번호: "+ rs.getString(1));
                                System.out.println("계좌주: "+ rs.getString(2));
                                System.out.println("계좌총액: "+ rs.getInt(3)+"원");
                            }
                        }
                    }
                }
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
}
