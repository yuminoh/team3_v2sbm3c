package dev.mvc.notice;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
		noticeno NUMBER(10) NOT NULL     PRIMARY KEY,
        memberno NUMBER(10) NOT NULL,
		title VARCHAR2(300) NOT NULL,
        rname VARCHAR2(10) NOT NULL,
		content CLOB NOT NULL,
        recom NUMBER(7)   DEFAULT 0 NOT NULL,
        passwd VARCHAR2(15) NOT NULL,
        word  VARCHAR2(300) NULL ,
		rdate DATE NOT NULL,
		file1 VARCHAR(100) NULL,
		file1saved VARCHAR(100) NULL,
		thumb1 VARCHAR(100) NULL,
		size1 NUMBER(10) DEFAULT 0 NULL,
 */

@Getter @Setter @ToString
public class NoticeVO {
  /** 공지사항 번호 */
  private int noticeno;
  /** 관리자 번호 */
  private int memberno;
  /** 제목 */
  private String title = "";
  /** 이름 */
  private String rname = "";
  /** 내용 */
  private String content = "";
  /** 추천수 */
  private int recom;
  /** 패스워드 */
  private String passwd = "";
  /** 검색어 */
  private String word = "";
  /** 등록 날짜 */
  private String rdate = "";
  
  /** 메인 이미지 */
  private String file1 = "";
  /** 실제 저장된 메인 이미지 */
  private String file1saved = "";  
  /** 메인 이미지 preview */
  private String thumb1 = "";
  /** 메인 이미지 크기 */
  private long size1;

  /** 
  이미지 MultipartFile 
  <input type='file' class="form-control" name='file1MF' id='file1MF' 
                   value='' placeholder="파일 선택">
  */
  private MultipartFile file1MF;

  /**
   * 파일 크기 단위 출력
   */
  private String size1_label;
  
}
