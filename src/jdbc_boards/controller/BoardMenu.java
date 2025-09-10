package jdbc_boards.controller;

import jdbc_boards.model.BoardDao;
import jdbc_boards.vo.Board;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class BoardMenu {
    private final BoardDao dao;
    private final BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public BoardMenu(){
        dao = new BoardDao();
        run();
    }

    private void run() {
        System.out.println("\n==== 게시판 ====");
        while(true){
            showMenu();
            System.out.print("메뉴 선택: ");

            int choice = 0;
            try{
                choice = Integer.parseInt(input.readLine());
            }catch (IOException e){
                System.out.println("입력도중 에러 발생");
            }catch (NumberFormatException e1){
                System.out.println("숫자만 입력해주세요");
            }catch (Exception e2){
                System.out.println("꿰엑 에라 모르겠다.");
            }

            try {
                switch (choice){
                    case 1 -> write();
                    case 2 -> listall();
                    case 3 -> search();
                    case 4 -> edit();
                    case 5 -> delete();
                    case 0 -> {
                        System.out.println("프로그램 종료");
                        return;
                    }
                    default -> System.out.println("메뉴를 다시 선택해주세요.");
                }
            } catch (IOException e) {
                System.out.println("[예외발생] "+ e.getMessage());
            }
        }
    }

    private void showMenu(){
        System.out.println();
        System.out.println("1. 글쓰기");
        System.out.println("2. 전체목록");
        System.out.println("3. 상세조회");
        System.out.println("4. 수정");
        System.out.println("5. 삭제");
        System.out.println("6. 종료");
    }

    private Board boardDataInput() throws IOException{
        Board board = new Board();
        System.out.println("<새로운 글 입력>");
        System.out.print("제목: ");
        String title =input.readLine();
        board.setBtitle(title);
        System.out.println("내용: ");
        String content = input.readLine();
        board.setBcontent(content);
        System.out.println("작성자: ");
        String author = input.readLine();
        board.setBwriter(author);
        return board;
    }

    private void write() throws IOException{
        System.out.println("\n[WRITE]");
        Board row = boardDataInput();
        boolean ack = dao.createBoard(row);
        if(ack == true) System.out.println("글이 성공적으로 입력되었습니다.");
        else System.out.println("입력 실패, 다시 시도 부탁드립니다. ");
    }

    private void listall(){
        System.out.println("\n[LIST]");
        List<Board> boardlist = dao.searchAll();
        if(boardlist.isEmpty() || boardlist == null){
            System.out.println("게시물이 없거나 예외가 발생했습니다.");
        }
        System.out.println("--------------------------------------------------------------------");
        System.out.println(String.format("%-5s %-20s %-10s %-19s", "번호", "제목", "작성자", "작성일"));
        System.out.println("--------------------------------------------------------------------");

        for(Board b : boardlist){
            String datestr = b.getBdate() != null? sdf.format(b.getBdate()) : "";
            System.out.println(String.format("%-5d %-20s %-10s %-19s",
                    b.getBno(), trimToLen(b.getBtitle(), 20), trimToLen(b.getBwriter(), 10), datestr));
        }
        System.out.println("--------------------------------------------------------------------");
    }

    private void search() throws IOException, NumberFormatException{
        System.out.println("\n[SEARCH]");
        int bno = Integer.parseInt(input.readLine());
        Board board = dao.searchOne(bno);
        if(board == null){
            System.out.println("해당 글이 없습니다.");
        }

        System.out.println();
    }

    private void edit(){

    }

    private void delete(){

    }

    private String trimToLen(String s, int len) {
        if (s == null) return "";
        if (s.length() <= len) return s;
        return s.substring(0, len - 1) + "…";
    }
}
