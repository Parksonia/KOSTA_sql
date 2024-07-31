-- ---------------------------------------------------------------------------------
-- 계정 관리 : root만 계정 설정  가능 
-- ---------------------------------------------------------------------------------

-- 계정 생성, 비밀번호 설정
CREATE user kosta IDENTIFIED BY '7564';
-- CREATE user 'test'@'%' IDENTIFIED BY '7564'  #username: test , % : 모든 IP에서 접근 가능

ALTER user kosta IDENTIFIED BY '1234';  -- 비밀번호를 7564 ->1234  로 변경

-- kosta 계정에 testdb24 select,insert,update권한 부여
GRANT SELECT,INSERT,UPDATE ON testdb24.* TO 'kosta'; -- kosta계정에게 testdb24의 모든테이블(*) 에 해당 권한을 줌(select,insert,update)

-- test계정에 testdb24의 모든 권한 부여
GRANT ALL PRIVILEGES ON testdb24.* TO 'kosta';

-- test계정에 모든 데이터베이스의 모든 권한 부여
GRANT ALL PRIVILEGES ON *.* TO 'kosta';


-- 부여된 권한 확인
SHOW GRANTS FOR 'kosta'; 
-- grant usage on *.* to 'kosta' : usage권한 지정자는 권한 없음을 나타냄 (권한은 없지만 계정은 있음을 의미)

-- kosta계정에서 update권한만 회수
REVOKE UPDATE ON testdb24.* FROM 'kosta';

-- kosta계정에서 모든 권한  회수
REVOKE ALL PRIVILEGES ON testdb24.* FROM 'kosta';

REVOKE ALL PRIVILEGES ON *.* FROM 'kosta';

CREATE user 'test'@'%' IDENTIFIED BY '1234';  -- 계정 추가 생성 

GRANT SELECT,INSERT,UPDATE ON testdb24.* TO 'test'@'%';
REVOKE ALL PRIVILEGES ON testdb24.* FROM 'test';

-- ---------------------------------------------------------------------------------
-- kosta계정에서 확인
-- ---------------------------------------------------------------------------------
SELECT * FROM emp; -- success
DELETE * FROM dept WHERE id=40; -- error : delete권한 없기 때문

-- 계정 삭제 
DROP user test;
DROP user kosta;
