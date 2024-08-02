-- 박소연

-- 문제 1.	Student 테이블을 참조해서 아래 화면과 같이
-- 1 전공이(deptno1 컬럼) 201번인 학생의 이름과 전화번호와 지역번호를 출력하세요. 
-- (단 지역번호는 숫자만 나와야 합니다. )

SELECT NAME,tel,SUBSTR(tel,1,INSTR(tel,')')-1) areacode FROM student WHERE deptno1 = 201;


-- 2.	Student 테이블에서 아래 그림과 같이 1 전공이 102 번인 학생들의 이름과 전화번호, 전화번호에서 국번 부분만 ‘*’ 처리하여 출력하세요. 
-- (단 모든 국번은 3자리로 간주합니다.)
-- (student : name, tel, deptno1)

SELECT NAME,tel,INSERT(tel,INSTR(tel,')')+1,3,'***') 'REPLACE' FROM student WHERE deptno1=102;


-- 3.Student 테이블의 birthday 컬럼을 사용하여 생일이 1월인 학생의 학번,이름, birthday 를 아래 화면과 같이 출력하세요.

SELECT studno, NAME, date_FORMAT(birthday,'%y/%m/%d') 'Birthday' FROM student WHERE MONTH(birthday) = 01; 

-- 4. emp 테이블을 조회하여 comm 값을 가지고 있는 사람들의 empno , ename , hiredate , 총연봉,15% 인상 후 연봉을 아래 화면처럼 출력하세요.
-- 단 총연봉은 (sal*12)+comm 으로 계산하고 아래 화면에서는 SAL 로 출력되었으며 15% 인상한 값은 총연봉의 15% 인상 값입니다.
-- (HIREDATE 컬럼의 날짜 형식과 SAL 컬럼 , 15% UP 컬럼의 $ 표시와 , 기호 나오게 하세요) 

SELECT empno,ename,date_format(hiredate,'%y/%m/%d') hiredate ,CONCAT('$',FORMAT((sal*12)+comm,0)) AS 'sal', CONCAT('$',FORMAT(((sal*12)+comm)*1.15,0))  AS '15%UP' FROM emp  WHERE comm IS NOT NULL;

-- 5. Professor 테이블에서 201번 학과 교수들의 이름과 급여, bonus , 총 연봉을 아래와 같이 출력하세요. 단 총 연봉은 (pay*12+bonus) 로 계산하고 bonus 가 없는 교수는 0으로 계산하세요.

SELECT NAME,pay,bonus,(pay*12+ifnull(bonus,0)) total FROM professor WHERE deptno=201;

-- 6. Student 테이블을 사용하여 제 1 전공 (deptno1) 이 101 번인 학과 학생들의 이름과 주민번호, 성별을 출력하되 
-- 성별은 주민번호(jumin) 컬럼을 이용하여 7번째 숫자가 1일 경우 “MAN” , 2일 경우 “WOMAN” 로 출력하세요.
SELECT NAME,jumin,if(SUBSTR(jumin,7,1)=1,'MAN','WOMAN') 'Gender' FROM student WHERE deptno1 = 101;

-- 7. emp 테이블을 사용하여 사원 중에서 급여(sal)와 보너스(comm)를 합친 금액이 가장 많은 경우와 가장 적은 경우, 
-- 평균 금액을 구하세요. 단 보너스가 없을 경우는 보너스를 0 으로 계산하고 출력 금액은 모두 소수점 첫째 자리까지만 나오게 하세요. 

SELECT MAX(sal+ifnull(comm,0)) 'max',MIN(sal+ifnull(comm,0)) 'min' FROM  emp;  -- 2900... why.

-- 8.emp 테이블을 조회하여 사번, 이름, 급여, 부서번호, 부서별 급여순위를 출력하세요. (부서별 급여순위 부분을 잘 보세요)
-- Rank() 함수
SELECT empno, ename,sal,deptno,RANK()over(PARTITION BY deptno ORDER BY sal DESC) 'RANK' FROM emp  ORDER BY 'RANK';
 
-- 9. panmae 테이블을 사용하여 1000 번 대리점의 판매 내역을 출력하되 판매일자, 제품코드, 판매량, 누적 판매금액을 아래와 같이 출력하세요
-- sum(컬럼)over(order by 정렬기준컬럼) : 누적합 구하는 함수

SELECT p_date,p_code,p_qty,p_total,SUM(p_total) OVER(ORDER BY p_total) AS total
FROM panmae 
WHERE p_store = 1000 ORDER BY p_total;

-- 10.emp 테이블을 사용하여 아래와 같이 부서별로 급여 누적 합계가 나오도록 출력하세요. ( 단 부서번호로 오름차순 출력하세요. )
-- sal이 동일하면 유일한 값인 empno으로 구분해야 정확한 값이 나온다.
SELECT deptno,ename,sal,SUM(sal) OVER(PARTITION BY deptno ORDER BY sal,empno ) AS total FROM emp; 