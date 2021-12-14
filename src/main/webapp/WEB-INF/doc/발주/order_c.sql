/**********************************/
/* Table Name: 상품 목록 */
/**********************************/
CREATE TABLE product_list(
		productno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		name                          		VARCHAR2(30)		 NOT NULL
);

COMMENT ON TABLE product_list is '상품 목록';
COMMENT ON COLUMN product_list.productno is '상품 번호';
COMMENT ON COLUMN product_list.name is '상품명';

CREATE SEQUENCE product_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

insert into product_list(productno, name) values (product_seq.nextval, '포카칩');
insert into product_list(productno, name) values (product_seq.nextval, '빼빼로');
insert into product_list(productno, name) values (product_seq.nextval, '초코송이');

select productno, name from product_list where productno=1;

update product_list set name='허니버터칩' where productno=1;

delete  from product_list where productno=3;

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

CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

insert into member(memberno, name) values (member_seq.nextval, '김ㅇㅇ');
insert into member(memberno, name) values (member_seq.nextval, '이ㅇㅇ');
insert into member(memberno, name) values (member_seq.nextval, '박ㅇㅇ');

select memberno, name from member where memberno=1;

update member set name='유ㅇㅇ' where memberno=1;

delete  from member where memberno=3;

/**********************************/
/* Table Name: 발주 목록 */
/**********************************/
CREATE TABLE order_list(
		orderno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		productno                     		NUMBER(10)		 NULL ,
		rdate                         		DATE		 NOT NULL,
		cnt                           		NUMBER(10)		 NOT NULL,
		cnttot                        		NUMBER(10)		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (productno) REFERENCES product_list (productno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE order_list is '발주 목록';
COMMENT ON COLUMN order_list.orderno is '발주 번호';
COMMENT ON COLUMN order_list.productno is '상품 번호';
COMMENT ON COLUMN order_list.rdate is '발주일';
COMMENT ON COLUMN order_list.cnt is '수량';
COMMENT ON COLUMN order_list.cnttot is '합계';
COMMENT ON COLUMN order_list.memberno is '회원 번호';


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

CREATE SEQUENCE code_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지
  
insert into pay_code(codeno, code) values (code_seq.nextval, '20211213-031002001');
insert into pay_code(codeno, code) values (code_seq.nextval, '20211213-031002002');
insert into pay_code(codeno, code) values (code_seq.nextval, '20211213-031002003');

select codeno, code from pay_code where codeno=1;

--코드는 한번 결정되면 수정 없음

delete  from pay_code where codeno=3;


/**********************************/
/* Table Name: 발주_결재 */
/**********************************/
CREATE TABLE pay(
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
		orderno                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES TABLE_member (memberno),
  FOREIGN KEY (codeno) REFERENCES pay_code (codeno),
  FOREIGN KEY (orderno) REFERENCES order_list (orderno)
);

COMMENT ON TABLE pay is '발주_결재';
COMMENT ON COLUMN pay.payno is '결재 번호';
COMMENT ON COLUMN pay.memberno is '회원 번호';
COMMENT ON COLUMN pay.paytype is '결재 종류';
COMMENT ON COLUMN pay.total is '결재 금액';
COMMENT ON COLUMN pay.rdate is '결재일';
COMMENT ON COLUMN pay.store is '지점';
COMMENT ON COLUMN pay.zipcode is '지점 우편번호';
COMMENT ON COLUMN pay.address is '지점 주소';
COMMENT ON COLUMN pay.tel is '지점 번호';
COMMENT ON COLUMN pay.codeno is '코드 번호';
COMMENT ON COLUMN pay.orderno is '발주 번호';

DROP SEQUENCE order_seq;
CREATE SEQUENCE order_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

--등록
INSERT INTO order_list(orderno, productno, rdate, cnt, cnttot, memberno)
VALUES (order_seq.nextval, 1, sysdate, 1, 1, 1);

INSERT INTO order_list(orderno, productno, rdate, cnt, cnttot, memberno)
VALUES (order_seq.nextval, 2, sysdate, 1, 1, 2);

INSERT INTO order_list(orderno, productno, rdate, cnt, cnttot, memberno)
VALUES (order_seq.nextval, 1, sysdate, 1, 1, 3);

--조회
SELECT orderno, productno, rdate, cnt, cnttot, memberno
FROM order_list
where orderno=1;

--수정
UPDATE order_list
SET cnt=2, cnttot=2
where orderno=1;

--삭제
DELETE FROM order_list where orderno=1;

--결재 목록
CREATE SEQUENCE pay_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

--등록
INSERT INTO pay(payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, orderno)
VALUES (pay_seq.nextval, 1, 1, 5000, sysdate,'ㅇㅇ점', 11111, 'ㅇㅇ시', '000-0000-0000', 1, 1);

INSERT INTO pay(payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, orderno)
VALUES (pay_seq.nextval, 2, 1, 5000, sysdate,'ㅇㅇ점', 11112, 'ㅇㅇ시', '000-0000-0000', 2, 2);

INSERT INTO pay(payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, orderno)
VALUES (pay_seq.nextval, 3, 2, 5000, sysdate,'ㅇㅇ점', 11113, 'ㅇㅇ시', '000-0000-0000', 3, 3);

--조회
SELECT payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, orderno
FROM pay
where payno=1;

--수정
UPDATE pay
SET paytype=2, total=10000, tel='000-0000-0001'
where payno=1;

--삭제
DELETE FROM pay where payno=3;