-- 1.제품이 생산된 공장위치가 "SEOUL"인 제품 중 판매점에 재고가 없는 상품을 출력한다.
-- 제품 카테고리(product), 제품명(product), 공장명(factory),판매점명(store),판매점 재고수량(stock) 

SELECT p.pdname '카테고리',p.pdsubname '제품명',f.FACNAME '공장명',sr.STONAME,ifnull(sc.stamount,0)
FROM product p JOIN factory f USING(FACTNO)
JOIN stock sc USING(pdno) 
JOIN store sr USING(stono) WHERE f.facloc ='SEOUL' AND sc.stamount = 0 OR sc.stamount IS NULL;

-- 2. 제품카테고리가 “TV”인 제품 중 가장 싼 것보다 비싸고
--제품카테고리가 “CELLPHONE”인 제품 중 가장 비싼 제품보다 싼 모든 제품을 출력한다.
-- 제품명, 원가, 제품가격
-- 조건:
-- 1) UNION을 사용하지 않고 하나의 쿼리 문장으로 작성 한다.
-- 2) 제품원가를 기준으로 한다.

SELECT pdsubname,pdcost,pdprice 
FROM product
WHERE pdcost > (SELECT MIN(pdcost) FROM product WHERE pdname='TV') AND pdcost < (SELECT MAX(pdcost) FROM product WHERE pdname='CELLPHONE'); 

-- 3. 공장 위치가 ‘CHANGWON’에서 생산된 제품들에 결함이 발견되어 생산된 모든 제품을 폐기 하고자 한다. 

DROP discarded_product;
Truncate table discarded_product;

CREATE table DISCARDED_PRODUCT (
	pdno INTEGER PRIMARY KEY,
	pdname VARCHAR(10),
	pdsubname VARCHAR(10),
	factno VARCHAR(5),
	pddate DATE,
	pdcost INTEGER,
	pdprice INTEGER,
	pdamount INTEGER,
	discarded_date DATE,
	FOREIGN KEY (factno) REFERENCES factory (factno)
);

-- 4.
START TRANSACTION;
INSERT INTO discarded_product SELECT p.*,CURDATE() FROM product p JOIN factory f USING(factno) WHERE f.FACLOC ='CHANGWON'; 
COMMIT;
ROLLBACK;	
-- 5.

START TRANSACTION;
DELETE FROM product WHERE pdno in(SELECT pdno FROM discarded_product);
COMMIT;
ROLLBACK;	
	