package dev.mvc.post;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
  postno INTEGER PRIMARY KEY NOT NULL, -- 게시글 번호
  title VARCHAR(200) NOT NULL, -- 제목
  contents VARCHAR(500) NOT NULL, -- 내용 
  pdate DATE NOT NULL, -- 등록일
  memberno NUMBER(10)  NOT NULL, -- 회원 번호(FK)
  FOREIGN KEY (memberno) REFERENCES member (memberno)
*/
@Getter @Setter @ToString 
public class PostVO {
    private int postno;
    private String title;
    private String contents;
    private String pdate;
    private int memberno;

    public PostVO() {
        
    }
    public PostVO(int postno, int memberno, String title, String contents, String pdate) {
        this.postno = postno;
        this.title = title;
        this.contents = contents;
        this.pdate = pdate;
        this.memberno = memberno;
}

    @Override
    public String toString() {
        return "PostVO [postno=" + postno + ", title=" + title + ", contents=" + contents + ", pdate=" + pdate
                + ", memberno=" + memberno + "]";
    }

    public int getPostno() {
        return postno;
    }

    public void setPostno(int postno) {
        this.postno = postno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getPdate() {
        return pdate;
    }

    public void setPdate(String pdate) {
        this.pdate = pdate;
    }

    public int getMemberno() {
        return memberno;
    }

    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    
}
    
    
    
    
    
    