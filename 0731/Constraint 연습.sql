-- ---------------------------------------------------------------------------------
-- constraint : 제약 조건
-- ---------------------------------------------------------------------------------
-- not null , unique, primary key, foreign key, check
-- ---------------------------------------------------------------------------------
-- primary key: 동일한 데이터 허용하지 않고 ,null값도 허용하지 않는다(unique,not null)
-- not null : null값 허용하지 않는다.

CREATE TABLE temp (
	id INT PRIMARY KEY, 
	NAME VARCHAR(30) NOT null
);

DROP TABLE temp;

INSERT INTO temp VALUES (1001,'temp1');
INSERT INTO temp VALUES (1001,'temp1'); -- primary key error

INSERT INTO temp (NAME) VALUES('temp3'); -- PRIMARY KEY ERROR
INSERT INTO temp (id,NAME) VALUES (NULL,'temp3'); -- primary key error

INSERT INTO temp (id) VALUES(1003) -- not null error
INSERT INTO temp (id,NAME) VALUES(1004, NULL) -- not null error

CREATE TABLE temp2 (
	email VARCHAR(50) unique
);

-- unique : 중복허용 안하나, null은 된다.
INSERT INTO temp2 VALUES('hong@kosta.org');
INSERT INTO temp2 VALUES(NULL); -- null은 허용
INSERT INTO temp2 VALUES('hong@kosta.org');  -- 중복 값 허용 불가 

-- check : 
CREATE TABLE temp3 (
	NAME VARCHAR(20) not NULL,
	age INT DEFAULT 1 CHECK(age>0)); -- 기본값 1, 값의 범위 제한


INSERT INTO temp3 (NAME) VALUES('hong');
insert INTO temp3 (NAME,age) VALUES('song',20);
INSERT INTO temp3 (NAME,age) VALUES('gong',-1); -- check error  :age범위 벗어남

-- auto_increment, primary key
DROP TABLE article;
CREATE TABLE article (
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	content VARCHAR(1000),
	writer VARCHAR(30)
); 

INSERT INTO article (title,content) VALUES('제목1','내용1');
SELECT * FROM article;

INSERT INTO article (title,content,writer) VALUES('제목2','내용2','hong');

-- foreign key
DROP TABLE user;
DROP TABLE article;

CREATE TABLE user(
	id VARCHAR(20) PRIMARY KEY,
	NAME VARCHAR(50) NOT NULL
);
-- 제약 조건 방식 1
-- REFERENCES 테이블명(속성) : 테이블에 존재하는 속성 값만 삽입 가능, null은 가능하다.

CREATE TABLE article (
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(1000),
	writer VARCHAR(20) REFERENCES user(id) 
);

INSERT INTO article (title,content,writer) VALUES('제목1','내용1','hong'); -- error :user에'writer'인 'hong없음'


INSERT INTO user(id,NAME) VALUES ('hong','홍길동');
INSERT INTO user(id,NAME) VALUES ('song','홍길동');

INSERT INTO article (title,content,writer) VALUES('제목1','내용1','hong'); -- success 
INSERT INTO article (title,content,writer) VALUES('제목1','내용1',NULL); --  null은 허용 

SELECT * FROM article;
SELECT * FROM user;

DELETE FROM user WHERE id ='hong'; -- error: article에서 참조하는 데이터가 있어서 삭제 불가능
DELETE FROM user WHERE id ='song';  -- success : article에서 참조하는 데이터가 없기때문에 삭제 가능

-- 제약 조건 방식 2
DROP TABLE article;
CREATE TABLE article(
	num INT AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(1000),
	writer VARCHAR(20),
	PRIMARY KEY(num),
	FOREIGN KEY (writer) REFERENCES user(id)
);	


-- 제약 조건 방식 3
DROP TABLE article;
CREATE TABLE article(
	num INT,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(1000),
	writer VARCHAR(20)
);


ALTER TABLE article ADD PRIMARY KEY(num);  -- PRIMARY KEY객체 생성
ALTER TABLE article DROP PRIMARY KEY; -- primary key 객체 삭제

ALTER TABLE article ADD CONSTRAINT article_pk PRIMARY KEY(num);
ALTER TABLE article ADD CONSTRAINT article_fk FOREIGN KEY(writer) REFERENCES user(id);

-- ---------------------------------------------------------------------------------
-- constraint 외부에서 작성
-- ---------------------------------------------------------------------------------

CREATE TABLE dept3(
	dcode VARCHAR(6) PRIMARY KEY,
	dname VARCHAR(30) NOT NULL,
	pdept VARCHAR(16),
	AREA VARCHAR(26)
);

CREATE TABLE tcons(
	NO INT,  -- primary key
	name VARCHAR(20),  -- not null
	jumin VARCHAR(13), -- not null, unique
	AREA INT, -- check 1,2,3,4
	deptno VARCHAR(6) -- foreign key
);

SELECT* FROM tcons;

DROP TABLE tcons;

-- primary key : pk_tcons_no
ALTER TABLE tcons ADD  CONSTRAINT pk_tcons_no primary KEY(NO);

-- not null :name
ALTER TABLE tcons MODIFY COLUMN NAME VARCHAR(20) NOT NULL;

-- not null :jumin
ALTER TABLE tcons MODIFY COLUMN jumin VARCHAR(20) not NULL;

-- unique : uk_tcons_jumin
ALTER TABLE tcons ADD  CONSTRAINT uk_tcons_jumin UNIQUE(jumin);
-- check
ALTER TABLE tcons ADD CONSTRAINT ck_tcons_area CHECK(AREA IN(1,2,3,4));
-- foreign key : deptno
ALTER TABLE tcons ADD CONSTRAINT fk_tcons_deptno FOREIGN KEY(deptno) REFERENCES dept3(dcode);

alter TABLE tcons DROP PRIMARY KEY ;
ALTER TABLE tcons DROP FOREIGN KEY fk_tcons_deptno;
ALTER TABLE tcons DROP constraint uk_tcons_jumin ;
ALTER TABLE tcons DROP constraint ck_tcons_area  ;
 