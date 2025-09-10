package jdbc_boards.model;

import jdbc_boards.vo.Board;
import util.DBUtil;

import java.util.*;
import java.sql.*;

public class BoardDao {
    private Connection conn;
    private PreparedStatement pstmt;

    private List<Board> boardList = new ArrayList<>();

    public boolean createBoard(Board board) {
        try{
            // connection 필요
            conn = DBUtil.getConnection();
            //query 문 작성
            String sql = " insert into boardtable (btitle, bcontent, bwriter, bdate) values (?,?,?,now()) ";
            //connection 쿼리를 담아 DB서버로 request할 객체 PrepareStatement 생성
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pstmt.setString(1, board.getBtitle());
            pstmt.setString(2, board.getBcontent());
            pstmt.setString(3, board.getBwriter());

            int result = pstmt.executeUpdate();
            return result > 0;
        }catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBoard(Board board){
        conn = DBUtil.getConnection();
        String sql = "update boardtable set btitle=?,bcontent=?,bwriter=? where bno=?";
        try(PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, board.getBtitle());
            ps.setString(2, board.getBcontent());
            ps.setString(3, board.getBwriter());
            ps.setInt(4, board.getBno());

            int result = ps.executeUpdate();
            return result != 0;
        }catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBoard(int bno){
        conn = DBUtil.getConnection();
        String sql = " delete from boardtable where bno=? ";
        try(PreparedStatement ps = conn.prepareStatement(sql)){

            ps.setInt(1, bno);
            int result = ps.executeUpdate();

            return result > 0;
        }catch(SQLException e){
            e.printStackTrace();
            return false;
        }
    }

    public List<Board> searchAll(){//최신 순 정렬
        conn = DBUtil.getConnection();
        String sql = "select * from boardtable order by bno desc ";
        try(PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs  = ps.executeQuery()){
            while(rs.next()){
                Board temp = new Board();

                temp.setBno(rs.getInt("bno"));
                temp.setBtitle(rs.getString("btitle"));
                temp.setBcontent(rs.getString("bcontent"));
                temp.setBwriter(rs.getString("bwriter"));
                temp.setBdate(rs.getDate("bdate"));

                boardList.add(temp);
            }
            return boardList;
        }catch(SQLException e){
            e.printStackTrace();
            return null;
        }
    }

    public Board searchOne(int bno){
        conn = DBUtil.getConnection();
        String sql = "select * from boardtable where bno=?";
        try(PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, bno);
            try(ResultSet rs = ps.executeQuery()){
                if(rs.next()){
                    Board temp = new Board();
                    temp.setBno(rs.getInt("bno"));
                    temp.setBtitle(rs.getString("btitle"));
                    temp.setBcontent(rs.getString("bcontent"));
                    temp.setBwriter(rs.getString("bwriter"));
                    temp.setBdate(rs.getDate("bdate"));
                    return temp;
                }
            }
            return null;
        }catch (SQLException e){
            e.printStackTrace();
            return null;
        }
    }
}

