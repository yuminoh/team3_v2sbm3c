DROP table order_pay;
CREATE TABLE order_pay(
    payno                     NUMBER(10)     NOT NULL    PRIMARY KEY,
    memberno                       NUMBER(10)     NULL ,
    rc_name                             VARCHAR2(30)     NOT NULL,
    rc_tel                                 VARCHAR2(14)     NOT NULL,
    rc_zipcode                          VARCHAR2(5)    NULL ,
    rc_address1                         VARCHAR2(80)     NOT NULL,
    rc_address2                         VARCHAR2(50)     NOT NULL,
    paytype                           NUMBER(1)    DEFAULT 0     NOT NULL,
    amount_pay                            NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                              DATE     NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);
SELECT order_pay_seq.nextval FROM dual;

COMMENT ON TABLE order_pay is '주문 결재';
COMMENT ON COLUMN order_pay.payno is '구매 번호';
COMMENT ON COLUMN order_pay.MEMBERNO is '회원 번호';
COMMENT ON COLUMN order_pay.rc_name is '수취인성명';
COMMENT ON COLUMN order_pay.rc_tel is '수취인 전화번호';
COMMENT ON COLUMN order_pay.rc_zipcode is '우편번호';
COMMENT ON COLUMN order_pay.rc_address1 is '주소1';
COMMENT ON COLUMN order_pay.rc_address2 is '주소2';
COMMENT ON COLUMN order_pay.paytype is '결재 방법';
COMMENT ON COLUMN order_pay.amount_pay is '총 결재금액';
COMMENT ON COLUMN order_pay.rdate is '주문날짜';

CREATE SEQUENCE order_pay_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;  

 INSERT INTO order_pay(payno, memberno, rc_name, rc_tel, rc_zipcode, rc_address1, rc_address2, paytype, amount_pay, rdate)
    VALUES (#{payno}, #{memberno}, #{rc_name}, #{rc_tel}, #{rc_zipcode},
                                     #{rc_address1}, #{rc_address2}, #{paytype}, #{amount_pay}, sysdate)

delete order_pay
commit;