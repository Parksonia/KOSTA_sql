-- ------------------------------------------
-- 문자열 함수
-- ------------------------------------------

-- concat : 문자열을 이을 때 사용하는 함수 
-- ex) SMITH(CLERK)
SELECT CONCAT(ename,'(',job,')') AS "nameAndJob" FROM emp;
SELECT ename AS 이름, hiredate AS 입사일 FROM emp; #as

-- SMITH's sal is $800
SELECT CONCAT(ename,'''s sal is $',sal) from emp WHERE ename ='SMITH';

-- FORMAT : #,###,###.## 숫자형 데이터의 포맷을 지정하여 문자열로 변경
SELECT FORMAT(250500.1254,2); #소수점을 두자리로 출력
SELECT FORMAT(1000,0); # 소수점 없이 출력하고 싶어도 0이라도 써줘야함
-- emp테이블에서 sal을 3자리당  ,를 넣어 조회
SELECT empno,ename,format(sal,0) FROM emp ORDER BY sal;

-- insert : 문자열 내의 지정된 위치에 특정 문자 수 만큼 문자열을 변경.
SELECT INSERT('http://naver.com',8,5,'kosta'); #컬럼의 8번째자리부터 5개를kostㅁ로 바꿈
 -- student 테이블에서 주민번호 뒤 7자리를 *로 대체하여 조회(학번,이름,주민번호,학년)
SELECT studno,NAME,insert(jumin,7,7,'*******')AS ,grade FROM student;
-- gogak테이블의 고객번호, 이름 조회(단,이름은 가운데 글자를 *로 대체)
SELECT gno,insert(gname,2,1,'*')AS 이름  FROM gogak;

-- instr : 문자열 내에서 특정 문자의 위치를 구한다 
SELECT INSTR('http://naver.com','.'); 
-- student 테이블에서 전화번호의 ) 위치를 조회
SELECT DISTINCT instr(tel,')') FROM student;


-- substr : 문자열 내에서 부분 문자열 추출
SELECT SUBSTR('http://naver.com',8,5); #시작위치부터, 몇개(길이)
SELECT SUBSTR('http://naver.com',8); #시작 위치
SELECT SUBSTR('http://naver.com',1,4);
-- student테이블의 전화번호에서 지역번호 출력
SELECT SUBSTR(tel,1,INSTR(tel,')')-1) FROM student;
SELECT SUBSTR(tel,INSTR(tel,')')+1,INSTR(tel,'-')-INSTR(tel,')')-1) FROM student; # -과 )사이의 갯수를 구해야 길이가 나옴
-- student 테이블에서 주민번호 상에서 9월생인 학생의 학번 이름 주민번호 조회
SELECT studno, NAME,jumin FROM student WHERE SUBSTR(jumin,3,2)='09';
-- substring : substr과 같다.
SELECT studno, NAME,jumin FROM student WHERE SUBString(jumin,3,2)='09';

-- length : 문자열의 바이트 수 구하기 (영문 한글자 : 1 byte,한글 한글자 :3byte)
SELECT LENGTH('stiven');
SELECT LENGTH('스티븐');

-- professor 테이블에서 email의 바이트 수 
SELECT LENGTH(email) FROM professor;
SELECT email,
		 substr(email,INSTR(email,'@')+1) AS eserver,
		 LENGTH(substr(email,INSTR(email,'@')+1))AS LENGTH 
FROM professor;

-- char_length :문자열의 글자수 (바이트수 x)
SELECT CHAR_LENGTH('stiven'), CHAR_LENGTH('스티븐');

-- professor 테이블에서 email 의 이메일 서버를 kosta.com으로 변경하여 조회
SELECT insert(email,instr(email,'@')+1,LENGTH(substr(email,INSTR(email,'@')+1)),'kosta.com') as email FROM professor;


-- LOWER(=LCASE) : 데이터를 소문자로 변경하여 조회
-- UPPER(=UCASE) : 데이터를 대문자로 변경하여 조회
SELECT LOWER('Abc'),LCASE('ABc'), UPPER('Abc'),UCASE('abC');

-- TRIM : 앞 뒤 공백 제거 
SELECT LENGTH('  test  '),LENGTH(TRIM('  test  '));
SELECT LENGTH('  t e s t  '),LENGTH(TRIM('  t e s t  '));
-- LTRIM: 왼쪽 공백 제거
SELECT LENGTH('  test  '),LENGTH(LTRIM('  test  '));

-- RTRIM : 오른쪽 공백 제거
SELECT LENGTH('  test  '),LENGTH(RTRIM('  test  '));

-- LPAD : 왼쪽을 특정 문자로 채워 넣기
SELECT LPAD(email,20,'#') FROM professor;
SELECT LPAD(email,20,'123456789') FROM professor;

-- RPAD : 오른쪽 공백을 특정 문자로 채워넣기
SELECT RPAD(email,20,'#') FROM professor;

-- ------------------------------------------
-- 날짜 함수 
-- ------------------------------------------

-- CURDATE,CURRENT_DATE
SELECT CURDATE(),CURRENT_DATE();

-- ADDDATE,DATE_ADD :연,월,일을 더하거나, 뺀다.
SELECT ADDDATE(CURDATE(),INTERVAL-1 YEAR); # 연도를 빼기
SELECT ADDDATE(CURDATE(),INTERVAL-1 MONTH); # 월  빼기
SELECT ADDDATE(CURDATE(),INTERVAL-1 DAY); # 날 빼기
SELECT ADDDATE(CURDATE(),-1); #기본은 날이다.
SELECT ADDDATE(ADDDATE(adddate(CURDATE(),INTERVAL-1 YEAR),INTERVAL-1 MONTH),INTERVAL-1 DAY);

-- emp 테이블에서 각 직원의 입사일과 10년 기념일 조회
SELECT ename,hiredate,ADDDATE(hiredate,INTERVAL + 10 YEAR)AS "입사10주년" FROM emp;

-- CURTIME,CURRENT_TIME
SELECT CURTIME(),CURRENT_TIME;
SELECT CURTIME(),ADDtime(CURTIME(),'1:10:5');

-- NOW() : 현재 날짜와 시간
SELECT NOW();
SELECT NOW(), ADDTIME(NOW(),'2 1:10:5'); #day hh:mm:ss 

-- DATEDIFF : 날짜 간격 계산
-- emp테이블에서 각 직원의 입사 일 수 조회
SELECT hiredate,datediff(CURDATE(),hiredate) FROM emp;
SELECT DATEDIFF(CURDATE(),19920110) ;
-- student 테이블에서 학생들의 학번,이름,생일,태어난 일수 조회
SELECT studno,NAME,birthday,format(DATEDIFF(CURDATE(),birthday)/365,0) AS 나이  FROM student; # 나이로 바꾸어 조회

-- emp 테이블에서 각 직원의 사번,이름,입사일,연차 조회
SELECT empno,ename,hiredate,format(DATEDIFF(CURDATE(),hiredate)/365,0)  연차  FROM emp;

SELECT empno,
		 ename,
		 hiredate,
		 format(DATEDIFF(CURDATE(),hiredate)/365,0)  연차
FROM emp
ORDER BY 4 DESC; # 컬럼의 순번으로 정렬을 많이 함

-- date_format 날짜 형식 지정
SELECT DATE_FORMAT('2024-07-29','%M %D %Y');
SELECT NOW(),DATE_FORMAT(NOW(), '%c %d %y %l:%i:%s %a'); 

-- 월: %M(February), %b(Feb), %m(02), %c(2)
-- 연: %Y(2024), %y(24)
-- 일 : %d(07), %c(7), %D(7th)
-- 요일 : %W(Monday),%a(Mon)
-- 시간 : %H(16) , %l(4)
-- %r : hh:mm:ss  (AM,PM)
-- 분: %i 
-- 초 : %s(한자리만) , %S(두자리 확보)

-- DATE_SUB :날짜 빼기
SELECT CURDATE(), DATE_SUB(CURDATE(),INTERVAL 10 DAY);
SELECT CURDATE(),DATE_ADD(CURDATE(),INTERVAL -10 DAY);

-- DATE_ADD : 날짜 더하기
SELECT CURDATE(),DATE_ADD(CURDATE(),INTERVAL 10 DAY);

-- DAY, DAYOFMONTH : 날짜에서 일만  추출
SELECT CURDATE(),DAY(CURDATE()), DAYOFMONTH(CURDATE());

-- emp2 테이블에서 생일이 15일 사람의 사번,이름,생일 조회
SELECT empno,NAME,birthday FROM emp2 WHERE DAY(birthday) = 15 ;

-- MONTH, YEAR :날짜에서 월,연 추출
SELECT CURDATE(),MONTH(CURDATE()),YEAR(CURDATE());

-- student테이블에서 이번달 생일인 사람의 학번,이름,학년 생일 조회
SELECT studno,NAME,grade,birthday FROM student WHERE MONTH(birthday) = MONTH(CURDATE());

-- HOUR,MINUTE,SECOND : 시간에서 시,분,초 추출
SELECT NOW(),Hour(NOW()),MINUTE(NOW()),SECOND(NOW());
SELECT CURTIME(),Hour(CURTIME()),MINUTE(CURTIME()),SECOND(CURTIME()) ;

-- NAYNAME, DAYOFWEEK(요일을 숫자로 표시) : 날짜에서 요일 추출
#일요일 :1 월요일:2...
SELECT CURDATE(),DAYNAME(curdate()),DAYOFWEEK(CURDATE()); 

-- professor테이블에서 금요일에 입사한 교수 번호,이름,입사일 조회
SELECT profno,NAME,hiredate FROM professor WHERE dayofweek(hiredate)=6;

-- str_to_date : 문자열을 날짜 타입으로 변환
SELECT DAYNAME(STR_TO_DATE('1992-01-10','%Y-%m-%d'));
SELECT DAYNAME('1992-01-10');


-- EXTRACT 
SELECT CURDATE(),EXTRACT(MONTH from CURDATE()) AS MONTH;
SELECT CURDATE(),EXTRACT(year from CURDATE()) AS year;
SELECT CURDATE(),EXTRACT(day from CURDATE()) AS day;
SELECT CURDATE(),EXTRACT(week from CURDATE()) AS week;
SELECT CURDATE(),EXTRACT(Quarter FROM CURDATE()) AS QUARTER; --분기 
SELECT CURDATE(),EXTRACT(YEAR_MONTH FROM CURDATE()) AS "year_month";

SELECT CURTIME(), EXTRACT(HOUR FROM CURTIME()) AS HOUR;
SELECT CURTIME(), EXTRACT(MINUTE FROM CURTIME()) AS MINUTE;
SELECT CURTIME(),EXTRACT(SECOND FROM CURTIME()) AS SECOND;

-- emp 테이블에서 1사분기에 입사한 직원의 사번,이름,입사일 조회
SELECT empno,ename,hiredate FROM emp WHERE EXTRACT(QUARTER FROM hiredate)=1 ; 

-- emp 테이블에서 모든 직원의 사번, 이름,입사일, 입사분기 조회
SELECT empno,ename,hiredate,EXTRACT(QUARTER FROM hiredate) AS 입사분기  FROM emp;


-- ------------------------------------------
-- 숫자 함수  
-- ------------------------------------------