package jdbc_boards.vo;

import java.sql.*;
import java.util.Objects;

public class Board {
    private int bno;
    private String btitle;
    private String bcontent;
    private String bwriter;
    private Date bdate;

    public int getBno() {
        return bno;
    }

    public void setBno(int bno) {
        this.bno = bno;
    }

    public String getBtitle() {
        return btitle;
    }

    public void setBtitle(String btitle) {
        this.btitle = btitle;
    }

    public String getBcontent() {
        return bcontent;
    }

    public void setBcontent(String bcontent) {
        this.bcontent = bcontent;
    }

    public String getBwriter() {
        return bwriter;
    }

    public void setBwriter(String bwriter) {
        this.bwriter = bwriter;
    }

    public Date getBdate() {
        return bdate;
    }

    public void setBdate(Date bdate) {
        this.bdate = bdate;
    }

    @Override
    public boolean equals(Object obj) {
        Board tempBoard = (Board) obj;
        return Objects.equals(bno, tempBoard.bno);
    }

    @Override
    public String toString() {
        return "[Board]"+
                "\nbno = "+ this.bno+
                "\nbtitle = "+ this.btitle+
                "\nbcontent = "+ this.bcontent+
                "\nbwriter= "+ this.bwriter+
                "\nbdate= "+ this.bdate;
    }
}
