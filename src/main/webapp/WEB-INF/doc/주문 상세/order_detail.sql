DROP table order_datail;
CREATE TABLE order_detail(
        order_itemno                     NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberno                        NUMBER(10)         NULL ,
        payno                     NUMBER(10)         NOT NULL,
        productno                        NUMBER(10)         NULL ,
        cnt                                   NUMBER(5)         DEFAULT 1         NOT NULL,
        tot                                   NUMBER(10)         DEFAULT 0         NOT NULL,
        stateno                               NUMBER(1)         DEFAULT 0         NOT NULL,
        rdate                                 DATE         NOT NULL,
  FOREIGN KEY (payno) REFERENCES order_pay (payno),
  FOREIGN KEY (memberno) REFERENCES MEMBER (memberno),
  FOREIGN KEY (productno) REFERENCES PRODUCTS (productno)
);

COMMENT ON TABLE order_datail is '주문상세';
COMMENT ON COLUMN order_datail.order_itemno is '주문상세번호';
COMMENT ON COLUMN order_datail.MEMBERNO is '회원 번호';
COMMENT ON COLUMN order_datail.productno is '주문 번호';
COMMENT ON COLUMN order_datail.productno is '상품 번호';
COMMENT ON COLUMN order_datail.cnt is '수량';
COMMENT ON COLUMN order_datail.tot is '합계';
COMMENT ON COLUMN order_datail.stateno is '주문상태';
COMMENT ON COLUMN order_datail.rdate is '주문날짜';
commit;

CREATE SEQUENCE order_datail_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;   