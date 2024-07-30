-- SUB QUERY 
-- subquery는 일반적으로 where조건절에 많이 사용한다.
-- subquery의 경우 ( ) 로 감싸야 한다.

-- SELECT column1, column2,...
-- FROM TABLE
-- WHERE 조건 연산자(SELECT column1,column2m... FROM TABLE WHERE 조건)

-- =,<,>,!= , >,>=,<,<= : 단일 행 연산자. ->서브쿼리의 결과가 한 행일 때..?
-- in, exists,not exists, <any, >any, <all, >all : 다중 행 연산자  -> 서브쿼리의 결과가 다중행일 때 ㅇ

-- emp 테이블에서 CLARK 보다 급여를 많이 받는 사원의 사번,이름,급여 조회
SELECT empno,ename,sal
FROM emp 
WHERE sal> (SELECT sal FROM emp WHERE ename ='CLARK')
ORDER BY 3 desc;

-- JOIN으로도 조회 할 수 있지만, 테이블을 조인 조회해서 찾는것보다 서브쿼리가 더 성능이 좋다.   
SELECT e1.empno,e1.ename,e1.sal
FROM emp e1 left JOIN emp e2
ON e1.SAL > e2.SAL
WHERE e2.ENAME = 'CLARK'
ORDER BY 3 DESC;

-- emp 테이블에서 WARD 보다 더 커미션이 적은 사원의 이름과 커미션 조회
SELECT ename, comm FROM emp 
WHERE ifNull(comm,0) < IFNULL((SELECT comm from emp WHERE ename ='WARD'),0);

-- student,department 테이블을 이용하여 서진수 학생과 주전공이 동일한 학생들의 이름과 전공명 조회
SELECT s.name,s.deptno1,d.dname  
FROM student s  LEFT JOIN  department d
ON s.deptno1 = d.deptno
WHERE s.deptno1 =(SELECT deptno1 FROM student WHERE NAME ='서진수');

-- professor, department 테이블을 이용하여 
-- 박원범 교수보다 나중에 입사한 교수의 이름과 입사일 학과명 조회 
SELECT p.name, p.hiredate,d.dname
FROM professor p LEFT JOIN department d
ON p.deptno = d.deptno
WHERE p.hiredate >(SELECT hiredate FROM professor WHERE NAME ='박원범')
ORDER BY 2;

-- 컴퓨터 공학과 학생들의 평균 몸무게보다 많이 나가는 학생들의학번,이름,학과,몸무게 조회
-- student deptno1 있고, department deptno 와 같다.
--나의 오답
SELECT s.studno,s.name,d.dname,s.weight
FROM student s LEFT JOIN department d
ON s.deptno1 = d.deptno 
WHERE s.weight>(SELECT AVG(student.weight) FROM student  WHERE department.dname='컴퓨터공학과');

--정답
SELECT s2.studno,s2.NAME,d2.dname,s2.weight
FROM student s2 JOIN department d2
ON s2.deptno1 = d2.deptno
WHERE weight> (SELECT AVG(s1.weight) 
					FROM student s1 JOIN department d1
					ON s1.deptno1 = d1.deptno
					WHERE d1.dname = '컴퓨터공학과');

-- gogak,gift 테이블을 이용하여 노트북 상품을 탈 수 있는 고객의 고객번호,이름,포인트 조회

SELECT gno,gname,point
FROM gogak
WHERE POINT >(SELECT g_start FROM gift WHERE gname ='노트북');


-- (emp,dept) new york 에 근무하는 직원의 목록
-- join보다 subquery가 더 효율적이다.
SELECT * FROM emp
WHERE DEPTNO = (SELECT deptno FROM dept WHERE loc ='NEW YORK');

-- (student, professor) : 박원범 교수가 담당하는 학생목록 조회
SELECT *
FROM student s 
WHERE s.profno = (SELECT profno FROM professor WHERE NAME='박원범');

-- (gogak,gift) :안광훈 고객이 포인트로 받을 수 있는 상품목록 조회
SELECT gname FROM gift
where g_start <
(select point from gogak WHERE gname = '안광훈');

-- (emp,dept) : sales부서를 제외한 나머지 부서에 속한 직원의 사번,이름,부서명 조회
SELECT e.empno,e.ename,d.DNAME 
from emp e LEFT JOIN dept d
ON e.DEPTNO = d.deptno
WHERE e.deptno !=(SELECT deptno FROM dept WHERE dname ='SALES');

SELECT e.empno,e.ename,d.DNAME 
from emp e LEFT JOIN dept d
ON e.DEPTNO = d.deptno
WHERE e.deptno IN (SELECT deptno FROM dept WHERE dname <>'SALES'); -- <> :아닌 (!=)


-- (student,exam_01,hakjum) : 학점이 'B0'미만인 학생의 학번,이름,점수 조회

SELECT s.studno,s.NAME,e.total
FROM student s JOIN exam_01 e
ON s.studno = e.studno -- 서로 컬럼명이 동일하다면ON 대신에 USING(studno)으로 표현할 수 있다. 
WHERE e.total < (SELECT min_point FROM hakjum WHERE grade ='B0');

-- (student, exam_01,hakjum) : 학점이 A0인 학생의 학번,이름, 점수 조회
SELECT s.studno,s.NAME,e.total
FROM student s JOIN exam_01 e
ON s.studno = e.studno
WHERE e.total BETWEEN (SELECT min_point FROM hakjum WHERE grade ='A0')
				  AND (SELECT max_point FROM hakjum WHERE grade='A0');

-- (emp2,dept2) : 포항 본사에서 근무하는 직원들의 사번, 이름,직급, 부서명 조회
-- in, exists,not exists, <any, >any, <all, >all : 다중 행 연산자  -> 서브쿼리의 결과가 다중행일 때 ㅇ
SELECT e.empno,e.NAME,e.POSITION,d.DNAME 
FROM emp2 e JOIN dept2 d
ON e.DEPTNO = d.DCODE
WHERE e.DEPTNO IN(SELECT dcode FROM dept2 WHERE AREA='포항본사');

-- (student, department) : 공과대학 학생들의 학번, 이름, 학년,주전공 조회
-- 1.공과대학에 해당하는 학부 조회
-- 2. 공과대학 학부에 해당하는 학과 조회
SELECT deptno
FROM department
WHERE part IN(SELECT deptno 
				 FROM department
				 WHERE part IN(SELECT deptno FROM department WHERE dname='공과대학'));
				
-- 3. 공과 대학 학과에 해당하는 학생 조회
SELECT studno, NAME, grade,deptno1
FROM student
WHERE deptno1 IN ( SELECT deptno
						FROM department
						WHERE part IN(SELECT deptno 
				 							FROM department
				 							WHERE part IN(SELECT deptno FROM department WHERE dname='공과대학')));
				 							
-- (emp2) : 과장 직급의 최소 연봉자보다 연봉이 높은 직원의 사번, 이름,연봉,직급 조회
SELECT empno, NAME,pay,POSITION FROM emp2
WHERE pay > (SELECT MIN(pay) FROM emp2 WHERE POSITION='과장');

-- ANY(...): 다중 행 중에서 어떤 하나만 충족 돼도 됨
-- 가장 작은 값보다도 크면 위와 똑같은 결과니까 ANY써서 표현해도 됨
SELECT empno, NAME,pay,POSITION 
FROM emp2
WHERE pay > ANY(SELECT pay FROM emp2 WHERE POSITION='과장');

-- (student) : 각 학년별(group by) 가장 큰 학생의 이름과 학년 키 조회
-- 두개의 컬럼 비교 가능
SELECT * 
FROM student 
WHERE(grade,height)IN ((4,160),(3,160));

SELECT * 
FROM student
WHERE (grade,height) IN (SELECT grade , Max(height) 
								FROM student 
								GROUP BY grade);
								
-- (student) : 2학년 학생들 중 몸무게가 가장 적게 나가는 학생보다 적은 학생의 이름,학년,몸무게 조회 
SELECT * 
FROM student   
WHERE weight < (SELECT min(weight) FROM student WHERE grade =2);

SELECT *
FROM student
WHERE weight < ALL (SELECT weight FROM student WHERE grade =2 );


-- (emp2, dept2) : 본인이 속한 부서의 평균 연봉보다 적게 받는 직원의 이름,연봉,부서명 조회
-- as를 사용하여 서브쿼리를 조회
-- 이너 쿼리가 메인 쿼리에 의존적이다. 
SELECT me.NAME, me.pay,d.DNAME
FROM emp2 me JOIN dept2 d
ON me.DEPTNO = d.DCODE 
WHERE pay < (SELECT AVG(pay)FROM emp2 WHERE deptno=me.DEPTNO); 

-- (professor, department) : 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름,입사일, 학과명 조회

SELECT p.profno,p.name, p.hiredate,d.dname  
FROM professor p JOIN department d
ON p.deptno = d.deptno
WHERE (p.deptno,p.hiredate) IN (SELECT deptno, min(hiredate) 
								FROM professor 
								GROUP BY deptno);

-- (student) :학년 별 나이가 가장 많은 학생의 학번, 이름, 나이 조회
SELECT studno,NAME,grade,YEAR(CURDATE())-YEAR(birthday) 나이
FROM student
WHERE(grade,birthday) IN (SELECT grade,min(birthday) FROM student GROUP BY grade);

-- (emp2) :직급별 최대 연봉을 받는 직원의 이름과 직급, 연봉 조회
-- 직급에 null이 아닌 공백이 있어 if조건으로 '사원'입력해줌, null이면 ifnull (사원)쓰면 됨
SELECT name,if(POSITION!='',POSITION,'사원')직급 ,pay 
FROM emp2
WHERE (POSITION,pay) IN(SELECT POSITION,MAX(pay) FROM emp2 GROUP BY POSITION);

-- (student,exam_01,department) : 같은 학과 같은 학년 학생의 평균 점수보다 높은
-- 학생의 학번, 이름,학과 ,학년, 점수 조회
-- 나의 오답
SELECT * 
FROM student s JOIN department d 
ON s.deptno1 = d.deptno
WHERE (s.grade,s.deptno1) IN(SELECT grade,deptno1 FROM student GROUP BY grade);

-- 선생님 답

-- 학년별 합계 평균 구하기 
SELECT s.deptno1, s.grade, AVG(e.total)
FROM student s JOIN exam_01 e
USING (studno)
GROUP BY s.deptno1, s.grade;


-- 위에서 구한 합계 평균 보다 높은 학생 구하기 
SELECT s.studno,s.name,s.deptno1,d.dname,s.grade,e.total
FROM student s JOIN exam_01 e 
ON s.studno = e.studno
JOIN department d
ON s.deptno1 = d.deptno
WHERE e.total> (SELECT AVG(total)FROM student s2 JOIN exam_01 e2 USING(studno)
					 WHERE s2.grade = s.grade AND s2.deptno1 =s.deptno1);