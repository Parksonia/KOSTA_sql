-- SQL 
-- DML(data management Language) :데이터 조작어(select,insert,delete,update)CRUD 
-- DDL(data definition Language) : 데이터 정의어(create,alter,drop,truncate,rename)
-- DCL (data control languation) : 데이터 제어어 (grant, revoke)
-- TCL (Transaction control language) : 트랜젝션 제어어 (commit,rollback)

-- ---------------------------------------------------------------------------------
-- DML
-- ---------------------------------------------------------------------------------

CREATE TABLE USER(
	id VARCHAR(10),
	NAME VARCHAR(20));
	

INSERT INTO user(id,NAME) VALUES('hong','홍길동');
INSERT INTO user VALUES('song','송길동'); -- 모든 컬럼 삽입의 경우 컬럼명 생략 가능(단,컬럼 순서대로입력)

INSERT INTO user(id) VALUES('gong'); -- name은 null로 들어감, 일부 컬럼만 삽입 시 생략 불가능

CREATE TABLE article (
	num INTEGER AUTO_INCREMENT primary KEY,
	title VARCHAR(50),
	content VARCHAR(200),
	writer VARCHAR(30)
);
-- num 의 경우 자동으로 번호 삽입됨,auto_increament(pk : 중복X)
-- auto_increment : 유일값, 삭제되면 번호가 줄어들지 않음

-- (article) data insert
-- 1. 'title1' ,'content1' 
INSERT INTO article (title,content) VALUES('title1' ,'content1'); 

-- 2. 'title2' 
INSERT INTO article (title) VALUES('title2');

-- 3. 'content3'
INSERT INTO article (content)VALUES('content3');

-- 4.'title4','content4','hong'
INSERT INTO article VALUES(null,'title4','content4','hong'); -- num의 경우 null입력하면 알아서 auto_increment가 숫자 입력함
INSERT INTO article (title,content,writer) VALUES('title5','content5','hong');

-- 5. 'title5','song'
INSERT INTO article (title,writer) VALUES('title5','song');

-- (emp)
-- 사번: 9999, 이름 : hong, 담당업무 : salesman , 담당매니절 :7369, 입사일 : 오늘,급여:1800, 부서번호:40
INSERT INTO emp VALUES(9999,'hong','SALESMAN',7369,CURDATE(),1800,null,40);

-- ---------------------------------------------------------------------------------
-- insert into select : select의 결과물을 insert시킴
-- select 테이블의 타입과 insert테이블의 속성들의 타입이 같아야함
-- ---------------------------------------------------------------------------------

CREATE TABLE emp_sub(
	id INT,
	NAME VARCHAR(30));

INSERT INTO emp_sub (id,NAME)
	SELECT empno,ename FROM emp WHERE deptno=10;	
	
-- ---------------------------------------------------------------------------------
SELECT @@AutoCommit;
-- SET AUTOCOMMIT = 1; -- autocommit이 1이면 rollback안됨
SET autocommit = 0;  -- commit해야지만 바뀜, rollback가능 
-- -------------------------------------------------------------------------------
-- update table set column_name1 = value1,column_name2= value2,.. where조건;
-- -------------------------------------------------------------------------------
UPDATE emp SET job ='CLERK', mgr=7782 WHERE ename='hong';
COMMIT;
ROLLBACK;

-- deptno이 10인 부서만 comm을 급여의 10%  더 준다.
UPDATE emp SET comm = ifnull(comm,0)+sal*0.01 WHERE deptno=10;
ROLLBACK;

-- SMITH와 같은 업무를 담당하는 사람들의 급여를 30%인상
UPDATE emp SET sal= sal+sal*0.03 
WHERE job=(SELECT job FROM emp where ename='smith');
ROLLBACK;

-- ---------------------------------------------------------------------------------
-- delete from table where 조건;
-- where조건절이 없으면 데이터가 다 날라가니 주의하기
-- ---------------------------------------------------------------------------------
-- emp에서 이름이 hong인  데이터 삭제
DELETE FROM emp WHERE ename='hong';
-- dept 에서 부서 번호가 40인 데이터 삭제 

START TRANSACTION;
DELETE FROM emp WHERE deptno=40;

START TRANSACTION; -- TRANSACTION start
DELETE FROM emp_sub; 
ROLLBACK;  -- commit하지않았으면 start tracnsaction으로 복구(롤백 됨)
COMMIT; -- 한번 commit하면 롤백 소용 없음


