/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno NUMERIC(10) NOT NULL PRIMARY KEY,
		ID VARCHAR(20) NOT NULL,
		passwd VARCHAR(60) NOT NULL,
		mname VARCHAR(30) NOT NULL,
		tel VARCHAR(14) NOT NULL,
		zipcode VARCHAR(5),
		address1 VARCHAR(80),
		address2 VARCHAR(50),
		mdate DATE NOT NULL,
		grade NUMERIC(2) NOT NULL
);

/**********************************/
/* Table Name: 상품 카테고리 */
/**********************************/
CREATE TABLE PD_CATEGORY(
		categoryno NUMERIC(38) NOT NULL PRIMARY KEY,
		categoryname VARCHAR(20) NOT NULL
);

/**********************************/
/* Table Name: 서브 카테고리 */
/**********************************/
CREATE TABLE PD_DETAIL_CATEGORY(
		sub_categoryno NUMERIC(15) NOT NULL PRIMARY KEY,
		sub_categoryname VARCHAR(40) NOT NULL,
		categoryno NUMERIC(38) NOT NULL,
  FOREIGN KEY (categoryno) REFERENCES PD_CATEGORY (categoryno)
);

/**********************************/
/* Table Name: 상품 */
/**********************************/
CREATE TABLE PRODUCTS(
		productno NUMERIC(15) NOT NULL PRIMARY KEY,
		productname VARCHAR(30) NOT NULL,
		categoryno NUMERIC(15) NOT NULL,
		sub_categoryno NUMERIC(15) NOT NULL,
		product_price NUMERIC(38) NOT NULL,
		product_explanation VARCHAR(150),
		pddate DATE NOT NULL,
		pdimagefile1 VARCHAR(100),
  FOREIGN KEY (sub_categoryno) REFERENCES PD_DETAIL_CATEGORY (sub_categoryno),
  FOREIGN KEY (categoryno) REFERENCES PD_CATEGORY (categoryno)
);

/**********************************/
/* Table Name: 구매 기록 */
/**********************************/
CREATE TABLE pay_list(
		payno NUMERIC(38) NOT NULL PRIMARY KEY,
		rdate DATE NOT NULL,
		memberno NUMERIC(38) NOT NULL,
		categoryno NUMERIC(38) NOT NULL,
		sub_categoryno NUMERIC(38) NOT NULL,
		cnt NUMERIC(38) NOT NULL,
		productno NUMERIC(38) NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (categoryno) REFERENCES PD_CATEGORY (categoryno),
  FOREIGN KEY (sub_categoryno) REFERENCES PD_DETAIL_CATEGORY (sub_categoryno),
  FOREIGN KEY (productno) REFERENCES PRODUCTS (productno)
);

/**********************************/
/* Table Name: 쇼핑카트 */
/**********************************/
CREATE TABLE cart(
		cartno NUMERIC(10) NOT NULL PRIMARY KEY,
		memberno NUMERIC(10) NOT NULL,
		productno NUMERIC(38) NOT NULL,
		product_price NUMERIC(38) NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (productno) REFERENCES PRODUCTS (productno)
);

/**********************************/
/* Table Name: 회원 관심상품 */
/**********************************/
CREATE TABLE INTERESTED_PRODUCTS(
		memberno NUMERIC(10) NOT NULL PRIMARY KEY,
		sub_categoryno NUMERIC(10) NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (sub_categoryno) REFERENCES PD_DETAIL_CATEGORY (sub_categoryno)
);

/**********************************/
/* Table Name: 추천 테이블 */
/**********************************/
CREATE TABLE RECOMMEND_PRODUCT(
		memberno NUMERIC(10) NOT NULL PRIMARY KEY,
		SUGGESTION_SUBCATEGORYNO NUMERIC(15) NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (SUGGESTION_SUBCATEGORYNO) REFERENCES PD_DETAIL_CATEGORY (sub_categoryno)
);

/**********************************/
/* Table Name: 공지사항 */
/**********************************/
CREATE TABLE notice(
		noticeno NUMERIC(10) PRIMARY KEY,
		memberno NUMERIC(10) NOT NULL,
		title VARCHAR(300) NOT NULL,
		rname VARCHAR(10) NOT NULL,
		content VARCHAR(1000) NOT NULL,
		recom NUMERIC(7) NOT NULL,
		passwd VARCHAR(15) NOT NULL,
		word VARCHAR(300) NOT NULL,
		rdate DATE,
		file VARCHAR(100),
		filesaved VARCHAR(100),
		thumb VARCHAR(100),
		size NUMERIC(10),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

/**********************************/
/* Table Name: 주문 결재 */
/**********************************/
CREATE TABLE order_pay(
		payno NUMERIC(10) NOT NULL PRIMARY KEY,
		rc_name NUMERIC(10) NOT NULL,
		rc_tel VARCHAR(15) NOT NULL,
		rc_zipcode VARCHAR(5) NOT NULL,
		rc_address1 VARCHAR(80) NOT NULL,
		rc_address2 NUMERIC(50) NOT NULL,
		paytype NUMERIC(1) NOT NULL,
		amount_pay NUMERIC(10) NOT NULL,
		rdate DATE NOT NULL,
		memberno NUMERIC(10),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

/**********************************/
/* Table Name: 주문 상세 */
/**********************************/
CREATE TABLE order_detail(
		order_itemno NUMERIC(10) NOT NULL PRIMARY KEY,
		memberno NUMERIC(10),
		payno NUMERIC(10),
		productno NUMERIC(15),
		cnt NUMERIC(10) NOT NULL,
		tot NUMERIC(10) NOT NULL,
		stateno NUMERIC(10) NOT NULL,
		rdate DATE,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (payno) REFERENCES order_pay (payno),
  FOREIGN KEY (productno) REFERENCES PRODUCTS (productno),
  FOREIGN KEY (payno) REFERENCES pay_list (payno)
);

/**********************************/
/* Table Name: 상품 문의 게시판 */
/**********************************/
CREATE TABLE post(
		postno NUMERIC(10) NOT NULL PRIMARY KEY,
		memberno NUMERIC(10) NOT NULL,
		title VARCHAR(200) NOT NULL,
		contents VARCHAR(500) NOT NULL,
		PDate DATE NOT NULL,
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

