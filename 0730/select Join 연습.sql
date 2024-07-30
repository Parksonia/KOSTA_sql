-- JOIN

CREATE TABLE test1(
A VARCHAR(10)
);

CREATE TABLE test2(
B VARCHAR(10)
);

INSERT INTO test1 VALUES('a1');
INSERT INTO test1 VALUES('a2');test1

INSERT INTO test2 VALUES('b1');
INSERT INTO test2 VALUES('b2');
INSERT INTO test2 VALUES('b3');


-- JOIN == 카트리샨 곱 : 행은 곱하고 열은 더하기 
SELECT *
FROM test1 JOIN test2
ORDER BY 1,2;  -- 첫번째 기준으로 정렬 후 , 두번째 

-- 카트리샨 곱으로 새로운 테이블을 만들고 where조건절로 내가 원하는 데이터를 조회
SELECT *
FROM test1 JOIN test2
WHERE test1.A ='a1' AND test2.B ='b1';

-- emp , dept 테이블 조인(행은*, 열은+) 
SELECT *
FROM emp JOIN dept;

-- Ansi join(표준 join)
SELECT e.*,d.DNAME
FROM emp e JOIN dept d
WHERE e.deptno = d.deptno;

SELECT e.empno,e.ename, d.dname
FROM emp e,dept d
WHERE e.DEPTNO= d.deptno;

-- student, department 테이블을 이용하여 학번,이름,학과명 조회
SELECT s.studno,s.name,d.dname 
FROM student s JOIN department d
WHERE s.deptno1 = d.deptno;

-- student,department 테이블을 이용하여 학번, 이름 ,부전공학과 조회
SELECT s.studno,s.name,d.dname 
FROM student s JOIN department d
on s.deptno2 = d.deptno; -- null은 조회 안됨 조건이 만족 할 수  없으니 

-- LEFT JOin : 왼쪽이 기준이 되어 왼쪽은 다 나옴,따라서 오른쪽은 null 나오게됨  
SELECT s.studno,s.name,d.dname 
FROM student s LEFT JOIN department d
on s.deptno2 = d.deptno;  

SELECT s.studno,s.name,d1.dname,d2.dname 
FROM student s left join department d1
ON s.deptno1 = d1.deptno
LEFT JOIN department d2
ON s.deptno2 = d2.deptno;  -- 1차적으로 조인한 테이블가지고 또 2차 조인


SELECT s.studno, s.name, d1.dname, d2.dname
FROM student s, department d1, department d2
WHERE s.deptno1 = d1.deptno  AND s.deptno2 = d2.deptno;

-- student, professor  테이블을 이용하여 학번, 이름,담당 교수명을 조회
-- 담당교수가 없는 경우도 있으니, 기준을 student테이블로 left join함
SELECT s.studno, s.name, p.name AS 담당교수
FROM student s LEFT join professor p
ON s.profno = p.profno;

-- professor, deparment 테이블을 이용하여 교수번호, 교수명, 소속학과명 조회
-- join 단독으로 쓰면(inner)가 생략된 형태임
-- on : ~에 대하여
SELECT p.profno, p.name,d.dname
FROM professor p left join department d
ON p.deptno = d.deptno;

-- right join  : 오른쪽 테이블이 기준이됨, 오른쪽이  다 나옴,
SELECT s.studno,s.name,d.dname 
FROM student s right JOIN department d
on s.deptno2 = d.deptno; 

-- full outer join : union
SELECT s.studno,s.name,s.deptno2,d.dname 
FROM student s left outer JOIN department d
on s.deptno2 = d.deptno 
UNION
SELECT s.studno,s.name,s.deptno2,d.dname 
FROM student s right outer JOIN department d
on s.deptno2 = d.deptno; 

-- 기준이 되는 테이블에 따라right,left join을 적절하게 사용해야함
SELECT s.studno,s.name, d.dname
FROM department d RIGHT JOIN student s
ON d.deptno = s.deptno2;

-- exam_01, student 테이블을 이용하여 학번, 이름, 점수 조회 
SELECT s.studno, s.name,s.grade, e.total
FROM student s left JOIN exam_01 e
ON s.studno = e.studno ; 


SELECT s.studno, s.name,s.grade, e.total
FROM exam_01 e left JOIN student s
ON s.studno = e.studno 
ORDER BY 3,4 desc; -- 3:grade 4: total  

-- emp테이블에서 사번, 사원명, 관리자번호, 관리자명 조회
-- self join : 자기 자신의 테이블과 조인함

SELECT e1.empno, e1.ename,e1.mgr,e2.ename
FROM emp e1 left JOIN emp e2
ON e1.MGR = e2.empno;

-- student, exam_01,hakjum 테이블을 이용하여, 학번,이름, 학년, 점수, 학점 조회 
SELECT s.studno,s.name, s.grade,e.total,h.grade
FROM student s LEFT JOIN exam_01 e,hakjum h
ON s.studno = e.studno AND e.total>= h.min_point AND e.total<=h.max_point; -- 나의 오답

-- 1차적으로 테이블 조인을 하고 그 조회 테이블로 다시 조인을 해야함!
SELECT e.studno, s.name,s.grade ,e.total, h.grade
FROM exam_01 e LEFT JOIN student s
ON e.studno= s.studno
LEFT JOIN hakjum h
ON e.total BETWEEN h.min_point AND h.max_point
ORDER BY 3,4 DESC;  

-- gogak ,gift테이블을 이용하여 고객 이름,보유 포인트, 포인트로 받을 수 있는 가장 좋은 상품 이룸 조회
SELECT g.gname,g.point,gift.gname
FROM gogak g LEFT JOIN gift
ON g.point BETWEEN gift.g_start AND gift.g_end
ORDER BY 2 desc;

-- emp2,p_grade 테이블을 이용하여 이름,직위,급여, 같은직급의 최소,최대 급여 조회

SELECT e.NAME,e.`POSITION`, e.PAY,p.s_pay,p.e_pay 
FROM emp2 e LEFT JOIN p_grade p
ON e.`POSITION` = p.`position`;

-- emp2, p_grade 테이블을 이용하여 본인의 직급에 해당하는 최대 급여보다 많이 받는 직원이 
-- 이름, 직위,급여, 같은 직급의 최소,최대 급여 조회

SELECT e.NAME,e.`POSITION`, e.PAY,p.s_pay,p.e_pay 
FROM emp2 e LEFT JOIN p_grade p
ON e.`POSITION` = p.`position`
WHERE e.pay > p.e_pay;

-- emp2,p_grade 테이블을 이용하여 이름, 직급,나이,본인의 나이에 해당하는 예상 직급
SELECT e.name, e.POSITION, FORMAT(DATEDIFF(CURDATE(),e.birthday)/365,0) 나이 ,p.position
FROM emp2 e LEFT JOIN p_grade p
on FORMAT(DATEDIFF(CURDATE(),e.birthday)/365,0) BETWEEN p.s_age AND p.e_age
ORDER BY 3 DESC;

-- emp2, dept2 테이블을 이용하여 서울 지사에 근무하는 직원의 사번,이름,부서명 조회
SELECT e.EMPNO, e.NAME,d.DNAME 
FROM emp2 e LEFT JOIN dept2 d
ON e.DEPTNO = d.DCODE
WHERE AREA = '서울지사';
