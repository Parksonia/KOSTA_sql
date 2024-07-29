-- 주석
# 주석
-- 컬럼명 대소문자 구분없이 사용 가능함 
-- ------------------------------------
-- ** select form : 데이터 조회 (검색) 
-- ------------------------------------
-- select 컬럼명1, 컬럼명2, ....from 테이블 명 : 테이블에 있는 원하는 데이터 조회할 때 사용
-- select * (모든 데이터 조회) from 테이블 명
SELECT * FROM emp;

-- emp테이블에서 ename,job,hiredate 컬럼 조회
SELECT ename,job,hiredate FROM emp;

-- student 테이블에서 학번,이름,학년,주전공학과번호 조회
SELECT studno,NAME,grade,deptno1 FROM student;

-- dept테이블 전체 컬럼 조회
SELECT * FROM dept;

-- where조건절을 통하여 원하는 행 조회
-- select from where: 행에 대한 조건절
-- where in () 속성의 데이터를 전체 중 일부만 조회하고 싶을 때 사용
SELECT * FROM emp WHERE deptno in(10,20);

-- 사번이 7782 인 직원의 사번,이름,job조회
SELECT empno,ｅname,job FROM emp WHERE empno = 7782;

-- job이 CLERK 인 직원의 모든 정보 조회
SELECT * FROM emp WHERE job ='CLERK';

-- emp테이블에서 급여가 1000이상인 직원의 사번,이름,급여 조회
SELECT empno,ename,sal FROM emp WHERE sal >= 1000;

-- student 테이블에서  4학년 학생들의 학번,이름,생일,전화번호,학년 조회
SELECT studno,NAME,birthday,tel,grade FROM student WHERE grade = 4;

-- student 테이블에서 1,2,4학년 학생들의 모든 컬럼 조회 (OR) 연산자 또는 IN() 활용
SELECT *FROM student WHERE grade=1 OR grade=2 OR grade =4;
SELECT * FROM student WHERE grade IN(1,2,4);
SELECT * FROM student WHERE grade !=3; #not grade = 3 또한 같음
SELECT * FROM student WHERE grade NOT IN(3);

-- student테이블에서 2,3학년 학생들의 모든 컬럼 조회
SELECT * FROM student WHERE grade IN(2,3);
SELECT * FROM student WHERE grade>=2 AND grade<=3;

-- emp테이블에서 업무가(job) CLERK이거나 SALESMAN인 직원의 사번,이름,업무 조회
SELECT empno,ename,job FROM emp WHERE job IN('CLERK','SALESMAN');

-- student테이블에서 4학년 이면서 학과번호가 101인 학생의 학번,이름,학년,학과번호조회
SELECT studno,NAME,grade,deptno1 FROM student WHERE grade = 4 AND deptno1 = 101;

-- student테이블에서 주전공이나 부전공이 101인 학생의 모든 항목 조회
SELECT * FROM student WHERE deptno1 = 101 or deptno2 = 101;

-- 날짜 형식도 비교 연산자 사용 가능하다.
SELECT * FROM emp WHERE hiredate >= '1985-01-01'; 

-- student테이블에서 1976년생 학생 조회 
SELECT * FROM student WHERE birthday >='1976-01-01'AND birthday<='1976-12-31';
SELECT * FROM student WHERE birthday BETWEEN '1976-01-01' AND '1976-12-31';

-- professor테이블에서 급여가 500대인 교수의 정보 조회
SELECT * FROM professor WHERE pay BETWEEN 500 AND 599;
SELECT * FROM professor WHERE pay>=500 AND pay<600; 

-- 쿼리문으로 데이터 정렬하기 ORDER BY ASC,DESC(오름차순,내림차순)
-- order  by : 정렬 (default는 오름차순이다.)
SELECT * FROM emp ORDER BY ename;  #가나다 순으로 정렬됨.
SELECT * FROM emp ORDER BY hiredate;
SELECT * FROM emp ORDER BY sal DESC; #desc 내림차순 정렬

-- emp테이블에서 부서번호가 10인 직원들의 정보를급여가 높은순으로조회
SELECT * FROM emp WHERE deptno = 10 ORDER BY sal DESC;

-- professor 테이블에서 급여가 500대인 교수의 정보를 급여순으로 조회
SELECT * FROM professor where pay BETWEEN 500 AND 599 ORDER BY pay;
 # 앞 조건이 우선으로 정렬되고 그 결과로 또 name이 정렬됨
select * FROM emp order BY deptno DESC ,eNAME DESC;

-- student테이블에서 학년순으로 정렬, 학년이 같을경우 키가 큰 순으로 정렬
SELECT * FROM student ORDER BY grade, height DESC;

-- DISTINCT : 중복 행 제거 
SELECT DISTINCT deptno FROM emp;

-- Like 연산자 활용
#like '%김'김으로 끝남, '김%' 김으로 시작, '김_' 김으로 시작하는 두글자 
SELECT * FROM student WHERE NAME LIKE '김%'; 
SELECT studno,NAME,jumin,birthday FROM student WHERE jumin LIKE '__08%'; #8월 생 조회

-- professor 테이블에서 email이 naver 인 교수 조회
SELECT * FROM professor WHERE email LIKE '%naver%';

-- 데이터 값이 null null이 아닌 값 조회 
-- IS NULL IS NOT NULL
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;

-- professor 테이블에서 hpage가 있는 교수 조회
SELECT * FROM professor WHERE hpage IS NOT NULL;

-- emp테이블에서 sal이 1000보다 크고
-- comm이 1000보다 작거나 없는 직원의 사번,이름,급여 커미션 조회

SELECT empno,ename,sal,comm FROM emp WHERE sal>1000 AND (comm <1000 OR comm IS NULL);

-- emp 테이블에서 모든 직원의 총급여(sal+comm) 조회
-- null값은 연산하게 되면 무조건 null이 나온다 따라서 ifnull()함수 사용하여 default값 지정
SELECT empno,ename,job,sal,comm, sal+ifnull(comm,0) AS 총급여 FROM emp; 

-- professor테이블에서 각 교수의 사번,이름,급여,보너스,총급여(pay+bonus) 조회
SELECT profno,NAME,pay,bonus,pay+ifnull(bonus,0)AS 총급여  FROM professor;