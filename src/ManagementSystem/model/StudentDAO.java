package ManagementSystem.model;

import ManagementSystem.vo.StudentVO;
import util.DBUtil;

import java.util.*;
import java.sql.*;

/**
 * 학생 데이터를 관리하기 위한 데이터 접근 객체임
 * 데이터베이스에 연결되어 학생 데이터를 추가, 삭제, 수정, 검색, 정렬하는 기능을 제공함
 *
 * 주요 기능
 * - 데이터베이스 연결 및 쿼리 실행
 * - 학생 데이터 추가, 변경, 삭제, 정렬
 * - 합계, 평균, 등급 계산
 **/

public class StudentDAO implements Student{
    /**
     * singleton으로 구현된 DAO 인스턴스
     */
    private static StudentDAO dao;

    /**
     * 생성자를 private으로 제한하여, 외부에서의 객체 생성을 제한함
     */
    private StudentDAO() {}

    /**
     * DAO instance를 반환하는 public singleton method
     * @return {@code StudentDAO} 인스턴스
     */
    public static StudentDAO getInstance() {
        if(dao == null) {dao = new StudentDAO();}
        return dao;
    }

    /**학생 데이터 관리 리스트*/
    private ArrayList<StudentVO> studentList = new ArrayList<>();
    /** 데이터 베이스 연결과 수행 객체*/
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private Statement stmt;

    /**
     * 데이터 베이스 연결 종료 메소드
     * ResultSet, Statement, PreparedStatement, Connection 순서대로 객체를 닫음
     * */
    private void disconnect() {
        if(rs != null) try {rs.close();} catch(SQLException e) {}
        if(stmt != null) try {stmt.close();} catch(SQLException e) {}
        if(pstmt != null) try {pstmt.close();} catch(SQLException e) {}
        if(conn != null) try {conn.close();} catch(SQLException e) {}
    }

    /**
     * 데이터 베이스 연결 메소드
     * DB에서 'Student' table의 데이터를 읽어와서 studentlist에 저장한다.
     * */
    private void connect(){
        try{
           conn = DBUtil.getConnection();
           String sql = " select * from student ";
           pstmt  = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();

           while(rs.next()){
               StudentVO studentVO = new StudentVO();
               studentVO.setSno(rs.getString("sno"));
               studentVO.setName(rs.getString("name"));
               studentVO.setKorean(rs.getInt("korean"));
               studentVO.setEnglish(rs.getInt("english"));
               studentVO.setMath(rs.getInt("math"));
               studentVO.setScience(rs.getInt("science"));

               //합계, 평균, 등급 계산
               this.total(studentVO);
               this.average(studentVO);
               this.grade(studentVO);

               //학생정보 보관 list에 추가
               studentList.add(studentVO);
           }
        }catch(SQLException e){
            e.printStackTrace();
        }finally {
            disconnect();
        }
    }

    public void input(StudentVO studentVO) {
        if(studentList.size() == 0){
            this.connect();
        }

        try {
            conn = DBUtil.getConnection();
            String sql = " insert into student values(?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, studentVO.getSno());
            pstmt.setString(2, studentVO.getName());
            pstmt.setInt(3, studentVO.getKorean());
            pstmt.setInt(4, studentVO.getEnglish());
            pstmt.setInt(5, studentVO.getMath());
            pstmt.setInt(6, studentVO.getScience());

            pstmt.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            disconnect();
        }
    }
}
