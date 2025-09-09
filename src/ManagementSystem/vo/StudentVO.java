package ManagementSystem.vo;

import lombok.Data;

import java.util.Objects;

@Data
public class StudentVO implements Comparable<StudentVO>{
    private String sno;
    private String name;
    private int korean;
    private int english;
    private int math;
    private int science;

    private int total;
    private double avg;
    private String grade;

    public StudentVO() {}

    public StudentVO(String sno, String name, int korean, int english, int math, int science) {
        this.sno = sno;
        this.name = name;
        this.korean = korean;
        this.english = english;
        this.math = math;
        this.science = science;
    }


    @Override
    public int compareTo(StudentVO o) {
        if(this.sno.compareTo(o.sno) > 0){
            return 1;
        }else if(this.sno.compareTo(o.sno) < 0){
            return -1;
        }
        return 0;
    }

    @Override
    public boolean equals(Object o){
        StudentVO that = (StudentVO) o;
        return Objects.equals(sno, that.sno);
        //return this.sno.equals(that.sno);
    } // 이거 빼먹으면 안됨 -> 사용자 정의 객체는 무조건 정의해줘야함

    @Override
    public String toString() {
        String str = "\t%-12s%-11s%-11d%-11d%-11d%-11d%-11d%-12.1f%-8s";
        return String.format(str,sno,name,korean,english,math,science,total,avg);
    }//printf 형태로 return 하는 방법
}
