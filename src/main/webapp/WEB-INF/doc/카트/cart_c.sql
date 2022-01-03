
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
  FOREIGN KEY (productno) REFERENCES product (productno),
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

insert into pay_code(codeno, code) values (code_seq.nextval, '20211213-031002001');
insert into pay_code(codeno, code) values (code_seq.nextval, '20211213-031002002');
insert into pay_code(codeno, code) values (code_seq.nextval, '20211213-031002003');

select codeno, code from pay_code where codeno=1;

--코드는 한번 결정되면 수정 없음

delete  from pay_code where codeno=3;

commit;
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
		cartno                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES member (memberno),
  FOREIGN KEY (codeno) REFERENCES pay_code (codeno)
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

CREATE SEQUENCE code_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

CREATE SEQUENCE pay_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  commit;
  
  CREATE SEQUENCE cart_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
  commit;

INSERT INTO cart(cartno, productno, cnt, cnttot, memberno)
VALUES (cart_seq.nextval, 1, 1, 1, 1);

INSERT INTO cart(cartno, productno, cnt, cnttot, memberno)
VALUES (cart_seq.nextval, 2, 1, 1, 1);

INSERT INTO cart(cartno, productno, cnt, cnttot, memberno)
VALUES (cart_seq.nextval, 1, 1, 1, 3);

--조회
SELECT cartno, productno, cnt, cnttot, memberno
FROM cart
where cartno=1 and memberno=1;

--수정
UPDATE cart
SET cnt=2, cnttot=2
where cartno=1;

--삭제
DELETE FROM cart where productno=1;

--등록
INSERT INTO pay(payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, cartno)
VALUES (pay_seq.nextval, 1, 1, 5000, sysdate,'ㅇㅇ점', 11111, 'ㅇㅇ시', '000-0000-0000', 1, 1);

INSERT INTO pay(payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, cartno)
VALUES (pay_seq.nextval, 2, 1, 5000, sysdate,'xx점', 11112, 'ㅇㅇ시', '000-0000-0000', 2, 2);

--조회
SELECT payno, memberno, paytype, total, rdate, store, zipcode, address, tel, codeno, cartno
FROM pay
where payno=1;

--수정
UPDATE pay
SET paytype=2, total=10000, tel='000-0000-0001'
where payno=1;

--삭제
DELETE FROM pay where payno=3;

commit;
