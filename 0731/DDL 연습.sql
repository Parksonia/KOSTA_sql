-- ---------------------------------------------------------------------------------
-- DDL(data definition Language) : 데이터 정의어(create,alter,drop,truncate,rename)
-- ---------------------------------------------------------------------------------

-- database생성

CREATE DATABASE kostatest;

-- database 삭제
DROP DATABASE kostatest;

-- table생성

-- data type
-- char: ~255 , varchar : ~65535
-- longtext : ~4,294,967,295
-- BLOB : 바이너리타입, 파일을 저장 할 수 있다. 

-- bit,tiny
-- bool : 데이터 삭제하지 않고 boolean으로 탈퇴 여부를 설정 

-- datetime
-- timestamp : 타임 존 정보까지 담고 있다.



CREATE TABLE person(
	id INT,
	last_name VARCHAR(255),
	first_name VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(255)
);

-- table 삭제 
DROP TABLE person;

 
-- create table as :테이블 복제 와 값까지 저장
CREATE TABLE emp_sub2 AS SELECT empno,ename,job,hiredate,sal FROM emp where deptno=10;
SELECT * FROM emp_sub2;

-- emp, dept테이블을 조인해서 emp_dept 테이블 생성
-- 컬럼은: emp의 모든 컬럼, 부서명 

CREATE TABLE emp_dept 
AS SELECT e.* , d.DNAME FROM emp e LEFT JOIN dept d ON e.DEPTNO = d.DEPTNO ; -- using(deptno)

SELECT * FROM emp_dept;   

-- 데이터를 제외하고 테이블 틀만 복사해서 새로운 테이블 생성
CREATE TABLE emp_cpy AS 
SELECT * FROM emp WHERE 1=2; -- where조건절을 거짓으로 만들면,slect되는 데이터가 없어서 틀만 복사됨  

-- truncate : 테이블 비우기, 초기화 (구조는 그대로 )
TRUNCATE TABLE emp_sub2;


DROP TABLE user;
CREATE TABLE user(
	id INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(20)
	
);
INSERT INTO user(NAME) VALUES('홍길동');
INSERT INTO user(NAME) VALUES('김길동');
INSERT INTO user(NAME) VALUES('송길동');
INSERT INTO user(NAME) VALUES('박길동');
INSERT INTO user(NAME) VALUES('강길동');

DELETE FROM user; -- 그냥 데이터를 삭제하는거라 autoincrement도 삭제된 번호 이후의 값이 들어감
TRUNCATE TABLE user;  --완전 초기화 테이블을 다시 만드는것과같다.


-- ---------------------------------------------------------------------------------
-- alter table  : 테이블의 구조 변경
-- ---------------------------------------------------------------------------------
-- add column :테이블 컬럼 추가

ALTER TABLE person 
ADD COLUMN email VARCHAR(255);

-- drop column :테이블의 컬럼 삭제
ALTER TABLE person 
DROP COLUMN email;

-- modify column : 컬럼(타입 등) 변경
ALTER TABLE person
MODIFY COLUMN address VARCHAR(300);

-- RENAME column : 컬럼 이름 변경
ALTER TABLE person 
RENAME column city TO AREA;

CREATE TABLE dept_t AS
SELECT * FROM dept; 

SELECT * FROM dept_t;

-- 컬럼 추가 & 기본값(default) 설정
ALTER TABLE dept_t
ADD COLUMN LOC2 VARCHAR(255) DEFAULT 'SEOUL';

-- LOC2를 AREA로 변경 
ALTER TABLE dept_t
RENAME COLUMN LOC2 TO AREA;

-- table rename
RENAME TABLE dept_t TO dept_temp;
