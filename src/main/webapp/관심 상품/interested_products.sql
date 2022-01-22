SELECT sub_categoryno, rownum as rank from
        (SELECT sub_categoryno, count(*)
                        FROM pay_list  WHERE memberno=18 AND rdate >= sysdate-60    
                        GROUP BY sub_categoryno  
                        ORDER BY count(*) DESC
                        ) 
        WHERE rownum <=3;
        
        
DELETE INTERESTED_PRODUCTS where memberno = #{memberno};
SELECT count(*) FROM INTERESTED_PRODUCTS WHERE memberno=18;

SELECT IP.sub_categoryno FROM INTERESTED_PRODUCTS IP INNER JOIN PD_DETAIL_CATEGORY sc ON ip.sub_categoryno=sc.sub_categoryno WHERE memberno=18
