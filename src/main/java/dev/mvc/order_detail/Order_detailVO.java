package dev.mvc.order_detail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class Order_detailVO {

  /** 주문상세번호 */
  private int order_itemno=0;  // 초기값: 0 
  /** 회원 번호 */
  private int memberno = 0;
  
  /** 주문 번호 */
  private int payno = 0;
  
  /** 컨텐츠 번호 */
  private int productno = 0;    
  
  /** 수량 */
  private int cnt = 0;
  
  /** 합계
   *  배송비는 주문 결재시에 통합적으로 결재되고 개별 상품 목록에는 배송비가 제외됨
   *  여기서는 교보문고의 유형을 개발함.
   *  
   *  - 교보문고는 배송비가 전체 주문에 통합됨
   *    . 여러권의 책을 구입해도 배송비는 3,000
   *  - 옥션은 모든 상품에 배공비가 독립적으로 적용됨
   *    . 물건 3개이면 배송비 3,000 x 3 = 9,000
   *   */
  private int tot;
  
  /** 배송 상태(stateno):  1: 결재 완료, 2: 상품 준비중, 3: 배송 시작, 4: 배달중, 5: 오늘 도착, 6: 배달 완료   */
  private int stateno;
  
  /** 주문날짜 */
  private String rdate = ""; // 초기값: null
 
}

