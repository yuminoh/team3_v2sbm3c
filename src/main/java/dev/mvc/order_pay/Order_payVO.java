package dev.mvc.order_pay;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class Order_payVO {

  /** 주문 번호 */
  private int payno;
  /** 회원 번호 */
  private int memberno;
  /** 수취인 성명 */
  private String rc_name = "";
  /** 수취인 전화 번호 */
  private String rc_tel = "";
  /** 수취인 우편 번호 */
  private String rc_zipcode = "";
  /** 수취인 주소 1 */
  private String rc_address1 = "";
  /** 수취인 주소 2 */
  private String rc_address2 = "";
  /** 결재 타입 1: 신용 카드, 2. 모바일 결재, 3. 포인트 결재 4. 계좌 이체, 5: 직접 입금 */
  private int paytype = 1;
  /** 결재 금액 */
  private int amount_pay = 0;
  /** 주문일 */
  private String rdate = "";   
}

