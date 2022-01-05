/**********************************/
/* Table Name: 상품 목록 */
/**********************************/
CREATE TABLE productlist(
		productno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(30)		 NOT NULL
);

COMMENT ON TABLE productlist is '상품 목록';
COMMENT ON COLUMN productlist.productno is '상품 번호';
COMMENT ON COLUMN productlist.name is '상품명';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(10)		 NOT NULL
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원 번호';
COMMENT ON COLUMN member.name is '회원 성명';


/**********************************/
/* Table Name: 카트 */
/**********************************/
CREATE TABLE cart(
		cartno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		productno                     		NUMBER(10)		 NULL ,
		cnt                           		NUMBER(10)		 NOT NULL,
		cnttot                        		NUMBER(10)		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
		payno                         		NUMBER(10)		 NULL ,
  FOREIGN KEY (productno) REFERENCES productlist (productno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE cart is '카트';
COMMENT ON COLUMN cart.cartno is '카트 번호';
COMMENT ON COLUMN cart.productno is '상품 번호';
COMMENT ON COLUMN cart.cnt is '수량';
COMMENT ON COLUMN cart.cnttot is '합계';
COMMENT ON COLUMN cart.memberno is '회원 번호';
COMMENT ON COLUMN cart.payno is '결재 번호';


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
CREATE TABLE order_pay(
		payno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NOT NULL,
		paytype                       		NUMBER(1)		 NOT NULL,
		total                         		NUMBER(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		store                         		VARCHAR2(10)		 NOT NULL,
		zipcode                       		VARCHAR2(10)		 NOT NULL,
		address1                      		VARCHAR2(80)		 NOT NULL,
		tel                           		VARCHAR2(14)		 NOT NULL,
		codeno                        		NUMBER(10)		 NULL ,
		cartno                        		NUMBER(10)		 NULL ,
		address2                      		VARCHAR2(50)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (codeno) REFERENCES pay_code (codeno),
  FOREIGN KEY (cartno) REFERENCES cart (cartno)
);

COMMENT ON TABLE order_pay is '발주_결재';
COMMENT ON COLUMN order_pay.payno is '결재 번호';
COMMENT ON COLUMN order_pay.memberno is '회원 번호';
COMMENT ON COLUMN order_pay.paytype is '결재 종류';
COMMENT ON COLUMN order_pay.total is '결재 금액';
COMMENT ON COLUMN order_pay.rdate is '결재일';
COMMENT ON COLUMN order_pay.store is '지점';
COMMENT ON COLUMN order_pay.zipcode is '지점 우편번호';
COMMENT ON COLUMN order_pay.address1 is '주소1';
COMMENT ON COLUMN order_pay.tel is '지점 번호';
COMMENT ON COLUMN order_pay.codeno is '코드 번호';
COMMENT ON COLUMN order_pay.cartno is '카트 번호';
COMMENT ON COLUMN order_pay.address2 is '주소2';


