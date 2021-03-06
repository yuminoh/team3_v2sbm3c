/**********************************/
/* Table Name: 상품 목록 */
/**********************************/
CREATE TABLE TABLE_product list(
		productno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(30)		 NOT NULL
);

COMMENT ON TABLE TABLE_product list is '상품 목록';
COMMENT ON COLUMN TABLE_product list.productno is '상품 번호';
COMMENT ON COLUMN TABLE_product list.name is '상품명';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE TABLE_member(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(10)		 NOT NULL
);

COMMENT ON TABLE TABLE_member is '회원';
COMMENT ON COLUMN TABLE_member.memberno is '회원 번호';
COMMENT ON COLUMN TABLE_member.name is '회원 성명';


/**********************************/
/* Table Name: 결재 코드 */
/**********************************/
CREATE TABLE pay_code(
		codeno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		code                          		VARCHAR2(20)		 NOT NULL
);

COMMENT ON TABLE pay_code is '결재 코드';
COMMENT ON COLUMN pay_code.codeno is '코드 번호';
COMMENT ON COLUMN pay_code.code is '코드';


/**********************************/
/* Table Name: 발주_결재 */
/**********************************/
CREATE TABLE TABLE_pay(
		payno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NOT NULL,
		paytype                       		NUMBER(1)		 NOT NULL,
		total                         		NUMBER(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		store                         		VARCHAR2(10)		 NOT NULL,
		zipcode                       		VARCHAR2(10)		 NOT NULL,
		address                       		VARCHAR2(100)		 NOT NULL,
		tel                           		VARCHAR2(14)		 NOT NULL,
		codeno                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES TABLE_member (memberno),
  FOREIGN KEY (codeno) REFERENCES pay_code (codeno)
);

COMMENT ON TABLE TABLE_pay is '발주_결재';
COMMENT ON COLUMN TABLE_pay.payno is '결재 번호';
COMMENT ON COLUMN TABLE_pay.memberno is '회원 번호';
COMMENT ON COLUMN TABLE_pay.paytype is '결재 종류';
COMMENT ON COLUMN TABLE_pay.total is '결재 금액';
COMMENT ON COLUMN TABLE_pay.rdate is '결재일';
COMMENT ON COLUMN TABLE_pay.store is '지점';
COMMENT ON COLUMN TABLE_pay.zipcode is '지점 우편번호';
COMMENT ON COLUMN TABLE_pay.address is '지점 주소';
COMMENT ON COLUMN TABLE_pay.tel is '지점 번호';
COMMENT ON COLUMN TABLE_pay.codeno is '코드 번호';


/**********************************/
/* Table Name: 발주 목록 */
/**********************************/
CREATE TABLE TABLE_order list(
		orderno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		productno                     		NUMBER(10)		 NULL ,
		rdate                         		DATE		 NOT NULL,
		code                          		NUMBER(20)		 NULL ,
		cnt                           		NUMBER(10)		 NOT NULL,
		cnttot                        		NUMBER(10)		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
		payno                         		NUMBER(10)		 NULL ,
  FOREIGN KEY (productno) REFERENCES TABLE_product list (productno),
  FOREIGN KEY (memberno) REFERENCES TABLE_member (memberno),
  FOREIGN KEY (payno) REFERENCES TABLE_pay (payno)
);

COMMENT ON TABLE TABLE_order list is '발주 목록';
COMMENT ON COLUMN TABLE_order list.orderno is '발주 번호';
COMMENT ON COLUMN TABLE_order list.productno is '상품 번호';
COMMENT ON COLUMN TABLE_order list.rdate is '발주일';
COMMENT ON COLUMN TABLE_order list.code is '결제 코드';
COMMENT ON COLUMN TABLE_order list.cnt is '수량';
COMMENT ON COLUMN TABLE_order list.cnttot is '합계';
COMMENT ON COLUMN TABLE_order list.memberno is '회원 번호';
COMMENT ON COLUMN TABLE_order list.payno is '결재 번호';


