USE mydb2;

SELECT * FROM emp;

-- 데이터 딕셔너리(사전) 
USE information_schema; 
SELECT * FROM TABLE_CONSTRAINTS WHERE TABLE_NAME='emp';

SELECT * FROM TABLE_CONSTRAINTS WHERE TABLE_NAME='test';


SELECT * FROM TABLES WHERE TABLE_NAME ='test';


USE mydb2;
-- 서브쿼리를 이용한 테이블 복사 - 제약조건은 복사가 되지 않는다 
CREATE TABLE emp2 AS SELECT * FROM emp;

INSERT INTO emp2(empno, ename) VALUES(8000, '김길동');

SELECT * FROM emp2;

ALTER TABLE emp2 ADD CONSTRAINT PRIMARY KEY (empno);  -- primary key  제약조건을 주려면 데이터가 
-- 중복되면 안되고 NULL  값이 있어도 안된다. 

DELETE FROM emp2 WHERE ename='김길동';

ALTER TABLE emp2 ADD CONSTRAINT PRIMARY KEY (empno);


CREATE TABLE emp3 AS SELECT empno, ename, sal, hiredate FROM emp WHERE deptno=10;
SELECT * FROM emp3;

-- 구조만 복사하기 
CREATE TABLE emp4 AS SELECT * FROM emp WHERE 1=0;

INSERT INTO emp4 SELECT * FROM emp WHERE deptno=10;

SELECT * FROM emp4;


-- 테이블 삭제 명령어 
DROP TABLE emp4;  -- 테이블 자체를 없앤다 , delete  는 테이블은 두고 데이터만 없앤다. 


SHOW TABLES;


-- DDL(Data Definition Language) - 테이블자체를 만들고 수정하게 삭제와관련된 , 
-- DML(Data Manifulation Language) - 테이블내의 데이터를 수정하고 삭제하고 추가하고 조회하고 
--                                     insert, delete, update, select 

-- 테이블 수정하기 
-- alter table  테이블명  컬럼추가 
ALTER TABLE emp3 ADD COLUMN read_yn CHAR(1);

SELECT * FROM emp3;


UPDATE emp3 SET read_yn='N';  -- where 조건절이 없으므러 한꺼번에 변경된다. 

SELECT * FROM emp3;


-- 컬럼 삭제 
ALTER TABLE emp3 DROP COLUMN read_yn;

SELECT * FROM emp3;


-- 컬럼 수정 
DESC emp3;


-- 실수형태로 저장 float(근사치)  decimal(정확하게)
-- 10진수 -> 2진수   실제데이터와 약간의 간격이 있는데  decimal 은 정확하게 
-- 컬럼 수정시 주의사항은  date -> varchar  모든 데이터가 수정가능한 공간 
-- 수정이 제한되는 경우가 많다 그럴경우 필드삭제를 하고 새로 추가하거나 
-- 미리 새로운 컬럼 만들어서 데이터 복수한다 
ALTER TABLE emp3 MODIFY COLUMN hiredate  VARCHAR(20);

DESC emp3;


-- char - 
-- varchar - 추가로 데이터 길이에 대한 정보를 가지고 다닌다. 
--         - 단편화 
--  메모리와 시간은 항상 반비례 

ALTER TABLE emp3 ADD constraint PRIMARY KEY (empno);
ALTER TABLE emp3 ADD PRIMARY KEY (empno);

SELECT * FROM emp3;

INSERT INTO emp3 VALUES(7782, 'test', 2000, '1999-01-01');

ALTER TABLE emp3 drop PRIMARY KEY ;

SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME='emp3';


-- 외부키 추가 삭제하기 - 외부키나 primary key에 이름 안주면 지가 알아서 
ALTER TABLE emp ADD constraint fk_emp_dept FOREIGN KEY (deptno)  REFERENCES dept(deptno); --  사용자가 이름지정
ALTER TABLE emp ADD  FOREIGN KEY (deptno)  REFERENCES dept(deptno); -- 시스템이 알아서 이름 붙임 

SELECT * FROM information_schema.table_constraints WHERE TABLE_NAME='emp'; -- 제약조건 확인명령어 

--  외부키 삭제
alter table mydb2.emp drop foreign key emp_ibfk_1;  
alter TABLE mydb2.emp DROP foreign key fk_emp_dept;



-- 트랜잭션처리 
/*
은행에 가서 돈을 보내야지 

하나은행 --> 우리은행

1. 하나은행 db에서 돈이 나갔음이 저장되어야 한다 
2. 우리은행  db에 입금되었음이 저장되어야 한다 

이 두개의 동작은 하나의 목적을 위해 결합하고 있다. 이걸 트랜잭션(거래)라고 한다 
이중 하나의 거래가 무효가 되면 모든 거래를 무효화 해야 할때 이런 일련의 동작을 트랜잭션이라고 한다 

1) 예약할때 
2) 상품을 인터넷으로 주문 
   주문테이블, 결제테이블, 배송테이블, 포인트, 쿠폰테이블 
   전체가 데이터가 바뀌어야 한다. 


DDL - 복구불가능 
DML - 필요에 의해서 복구 가능 

프로그램처럼 변수 
autocommit  이 변수의 값을 FALSE로 바꿔놓고 

show variables like 'autocommit%';  -- autocommit 변수의 현재 상태를 보는것 
autocommit 를 해제하고 나서 insert, update 또는 delete 를 하면 원상복구가 가능하다. 
set autocommit = true;
set autocommit = false;

*/

show variables like 'autocommit%';

set autocommit = FALSE;  -- autocommit 라는 속성을 false로 주면 dml(insert, update, delete) 은 불확정상태 
-- commit :확정 또는  rollback:원상복구  명령어중 하나를 할때 까지 

show variables like 'autocommit%';

INSERT INTO mydb2.emp (empno, ename) VALUES (8004, '둘리');

SELECT * FROM emp;

ROLLBACK;  -- 지금 한 내용을 원상복구 하겠다. 


SELECT * FROM emp;

DELETE FROM emp;


ROLLBACK;


SELECT * FROM emp;


CREATE TABLE emp5 AS SELECT * FROM emp; -- ddl(create, alter, truncate, drop ....  무조건 확정)


ROLLBACK;

SELECT * FROM emp5;
TRUNCATE table emp5; -- 테이블은 두고 데이터 삭제 

ROLLBACK;

SELECT * FROM emp5;


SET autocommit=TRUE;


--  autocommit   변수 안건드리고 트랜잭션 처리하기 

START TRANSACTION;  -- commit  나 rollback 하기 전까지 미확정 상태 
SELECT * FROM emp2;
DELETE FROM emp2;
SELECT * FROM emp2;
ROLLBACK;
SELECT * FROM emp2;



-- 내장함수 : ifnull, count, sum, max, min, substring , date ..........
-- cast : 형전환 함수  node에 parseInt 문자열 -> 정수 

 
SELECT CAST('2020-10-19 12:35:29.123' AS DATE) AS 'DATE' ;  -- 명시적 형전환
SELECT CAST('2020-10-19 12:35:29.123' AS TIME) AS 'TIME' ;
SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME) AS 'DATETIME' ; 

--  유사함수로 convert  함수 

DESC emp3;

-- hiredate -> 문자열 

SELECT ename, TIMESTAMPDIFF(YEAR, CURDATE(), hiredate)  FROM emp3; -- 묵시적 형변환 : 시스템이 알아서 

SELECT ename,  CURDATE()-hiredate  FROM emp3;

SELECT ename,  CURDATE() - CAST(hiredate AS DATEtime)  FROM emp3;


-- 변수 만들어 사용하기 
-- 사용자변수는 @로 시작한다 

SET @myvar1=10;
SET @myvar2=20;

SELECT @myvar1;
SELECT @myvar2;
SELECT @myvar1+@myvar2;

select empno, ename from emp where deptno=10;

SET @deptno=10;
PREPARE myQuery FROM  'select empno, ename from emp where deptno=?';
EXECUTE myquery USING @deptno;


-- 매개변수 2개 
SET @deptno=10;
SET @empno=7782;

PREPARE myQuery FROM  'select empno, ename from emp where deptno=? and empno=?';
EXECUTE myquery USING @deptno, @empno;

-----------------------------------------------------
SET @empno=8003;
SET @ename='조승연';
PREPARE insertQuery FROM  'insert into emp(empno, ename) values(?, ?)';
EXECUTE insertQuery USING @empno, @ename;


select empno, ename from emp;

-- 문제1. dept 테이블의 모든 요소 deptno, dname, loc 세개를 입력하도록 

SET @deptno=70;
SET @dname='개발1부';
SET @loc='광주시';

PREPARE insertQuery2 FROM  'insert into dept(deptno, dname, loc) values(?, ?, ?)';
EXECUTE insertQuery2 USING @deptno, @dname, @loc;

SELECT * FROM dept;


-- 문제2. dept 테이블의 데이터 수정하기  deptno조건으로 , dname, loc 수정하기 
SET @deptno=70;
SET @dname='개발2부';
SET @loc='인천시';

PREPARE updateQuery FROM  'update dept set dname=?, loc=? where deptno=?';
EXECUTE updateQuery USING @dname, @loc, @deptno;

SELECT * FROM dept;

-- 문자열을 다루는 함수들 
SELECT CONCAT('His name is ', 'Tom');

SELECT CONCAT(ename, '님의 급여는' , sal, '입니다.') AS "급 여" FROM emp;

-- 조승연님의 부서는 개발부입니다. ..............

SELECT concat(ename,'님의 부서는', ifnull(dname, '모름'), '입니다') AS title 
FROM emp A
LEFT OUTER JOIN dept B ON A.deptno=B.deptno;


-- select 쿼리에 프로그램적 요소를 넣는다. 
/*
	case 필드명 when 값1 then 결과1 
	            when 값2 then 결과2 
	            when 값3 then 결과3 
	            when 값4 then 결과4 
	            else '결과5'
	end 
*/

SELECT ename, case deptno when 10  then '개발1부'
                          when 20  then '개발2부'
                          when 30  then '개발3부'
                          when 40  then '개발4부'
                          when 50  then '개발5부'
                          ELSE '총무부' 
				  end AS dname 
FROM emp;

SELECT ename, sal FROM emp
ORDER BY sal desc;


SELECT ename, case when sal>=4000 then 'A'
                   when sal>=3000 then 'B' 
						 when sal>=2000 then 'C'
						 ELSE 'D'
				   END grade 
FROM emp;


-- use classsicmodels;
-- employees  테이블의 1.서울시 2.부산시 3.인천시 4.대구시 5.광주시 6.울산시 그밖에 .수원시 


SELECT CONCAT(firstName,' ',lastName)AS 이름,
 case officeCode when 1 then '서울시'
                  when 2 then '부산시'
                  when 3 then '인천시'
                  when 4 then '대구시'
                  when 5 then '광주시'
                  when 6 then '울산시'                  
                 ELSE '수원시'
               END '지역'
FROM employees;


-- ascii 함수 문자를 주면 아스키 코드값을 주는 함수 
/*
	1bit  - 0 또는 1만 저장하는 소자   2 4 8 16 32 64 128
	2bit   00 01 10 11 (4가지(          
	3bit   000  A 
	       001  B
	       010  C
	       011
	       100
	       101
	       110
	       111 

   컴퓨터는 0과 1로 구성  A 
   
   키보드에 있는 문자가 128개   7bit  ascii code 
   
   8bit -> 1개의 문자   
   
   ㅎ ㅏ ㄴ ㄱ ㅜ ㄱ  한국 (2byte) - ksc5601, euc-kr (웹개발시) 
	3byte - utf-8 이 표준  
*/

SELECT ASCII('A'), ASCII('B'), ASCII('0');

-- ascii -> 문자로 char함수 
SELECT CHAR(65), CHAR(97), CHAR(50);


-- 문자열의 길이 알아내는 함수 한문자당 - 8bit 
select BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc'); -- 24, 3, 3

select BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다');  -- 72 3 9

-- BIT_LENGTH: 데이터를 저장하는데 필요한 비트 수  영어 1byte 만 차지한다. 
-- LENGTH - 차지하는 바이트 숫자 
-- char_length - 문자가 몇개냐 
-- 24, 문제 3개 차지한 바이트수 3
-- 한글은 utf-8 한글자 저장하는데 3byte 

-- concat 업그레이드  concat_ws('끼워넣어야할 문자', str1, str2, ....)

SELECT CONCAT_WS('/', '2021', '11', '11');
SELECT CONCAT_WS('-', '2021', '11', '11');
SELECT CONCAT_WS('/', '사과', '배', '귤', '포도');

USE mydb2;

CREATE TABLE tb_score ( id INT, NAME VARCHAR(20), kor smallint, eng smallint, mat smallint);
INSERT INTO tb_score VALUES( 1, '홍길동', 90, 90 , 90),
( 2, '임꺽정', 70, 90 , 90),
( 3, '장길산', 80, 70 , 70),
( 4, '장승업', 60, 40 , 50),
( 5, '홍경래', 90, 50 , 80),
( 6, '허난설헌', 100, 90 , 90),
( 7, '김정하', 70, 90 , 60);

SELECT * from tb_score; 


SELECT  CONCAT_WS(' ', id, NAME, kor, eng, mat, kor+eng+mat) from tb_score;


-- 문제.총점 평균  A,B,CD
-- 이름 총점 평균 등급 

SELECT NAME, total, average, case when average>=90 then 'A'
                                  when average>=80 then 'B'
                                  when average>=70 then 'C'
                                  when average>=60 then 'D'
                                  ELSE 'F'
                              END grade 
FROM 
(
	SELECT NAME, kor+eng+mat AS total, (kor+eng+mat)/3 AS average  
	FROM tb_score
)AS A;

SELECT * from information_schema.columns 
WHERE table_schema='mydb2' and TABLE_NAME='tb_score'; 

SELECT COUNT(*) from information_schema.columns 
WHERE table_schema='mydb2' and TABLE_NAME='tb_score'; 


-- /score/list : 과제를 이메일로 파일 두개로 보내기 score.js, score_list.html 파일 두개만 보내기 


-- 문자열의 위치를 찾아주는 함수들 
-- ELT(위치값, str1, str2, str3, .....)  뒤에 있는 str들로부터 해당 위치의 문자를 찾아 반환한다 
-- dbms 들은 위치값이 0부터 시작하지 않고 1부터 시작한다 

SELECT ELT(2, '하나', '둘', '셋');
SELECT ELT(1, '사과', '바나나', '딸기', '포도');
SELECT ELT(2, '사과', '바나나', '딸기', '포도');
SELECT ELT(3, '사과', '바나나', '딸기', '포도');
SELECT ELT(5, '사과', '바나나', '딸기', '포도'); -- error 시 NULL값

-- ELT 힘수와의 차이점 - 위치가 아니고 데이터다 
SELECT FIELD('둘', '하나', '둘', '셋');
SELECT FIELD('딸기', '사과', '바나나', '딸기', '포도');
SELECT FIELD('수박', '사과', '바나나', '딸기', '포도'); -- error 시 0 


SELECT FIND_IN_SET('하나', '하나,둘,셋,넷'); -- 구분자 필요
-- 젤 중요함, 다른 dbms 에서도 많이 사용한다 
SELECT INSTR('하나둘셋', '둘');

-- like 처럼 사용한다.  
USE mydb2;
SELECT * FROM emp WHERE ename LIKE 's%';
SELECT * FROM emp WHERE instr(ename, 's')>0; 

-- ltrim, rtrim, trim 
-- 데이터베이스에 데이터가 입력될때 특정 문자들이 문제가 되는 경우가 많다. 
-- 특정문자중에 ' 어포스트로피 -> '' 두개로 바꾸어서 저장하라 
-- 공백   스페이스conan스페이스 
-- 검색시  userid='conan' 
-- 데이터 입력시 공백을 제거하고 입력해야 하고, 서버에서도 떄로는 공백을 제거해서 처리해야 한다 
-- ltrim - 왼쪽의 공백을 제거한다 
-- rtrim - 오른쪽의 공백을 제거한다 
-- trim  은 왼쪽 오른쪽 둘다의 공백을 제거한다 

SELECT CONCAT('*', '           왼쪽         ', '*');
SELECT CONCAT('*', LTRIM('           왼쪽         '), '*');
SELECT CONCAT('*', rTRIM('           왼쪽         '), '*');
SELECT CONCAT('*', TRIM('           왼쪽         '),  '*');

SELECT repeat('반복', 5);  -- 특정 단어를 반복해서 문장만들기 

SELECT REPLACE('이것이 mysql 이다', '이것이', 'This is'); -- 앞의 문장에서 두번째 단어 찾아서 세번째로 바꾸기 

-- 함수는 표준이라 아니라서  dbms마다 함수이름도 다르고 사용법 다르다 
-- 오라클 같은 경우에는 select 뒤에 from 절 생략이 안된다. 
-- 오라클 SELECT CONCAT('*', '           왼쪽         ', '*') from dummy 
-- 오라클, mssql, mysql(무료) - mariadb 
-- mariadb : 일정 버전 이상부터는 서로 차이가 많이 난다. mysql이 오라클을 따라간다 

-- substring(단어, 시작위치, 단어개수) 단어를 잘라낸다 

SELECT SUBSTRING('2021-11-12', 1, 4); -- db 는 1부터 시작한다 
SELECT SUBSTRING('2021-11-12', 6, 2); -- 월 추출
SELECT SUBSTRING('2021-11-12', 9, 2); -- 일 추출 

SELECT YEAR('2021-11-12');  -- 숫자로 출력 
SELECT month('2021-11-12');
SELECT day('2021-11-12');

-- ['cafe', 'daum', 'net']
SELECT SUBSTRING_INDEX('cafe.daum.net', '.', 1);
SELECT SUBSTRING_INDEX('cafe.daum.net', '.', 2);
SELECT SUBSTRING_INDEX('cafe.daum.net', '.', 3);

-- 수학함수들 - 쿼리를 사용하지 않고 자바나 nodejs 에 데이터를 다 들고와서 
--- 자바나 nodejs로 해결하려고 한다. 
-- 데이타가 10만건 정도 가정해보면 -> 컴퓨터 메모리에 올릴려면 메모리가 감당이 안된다.
-- 디비안에서 계산해서 원하는 데이터는 10~50 건이내만 불러가야 한다 

--
SELECT abs(34), ABS(-90);  -- 절대값 
SELECT CEILING(4.7), CEILING(4.1);  -- 무조건 올림함수  
SELECT FLOOR(4.7), FLOOR(4.1); -- 무조건 내림함수 
SELECT ROUND(4.7);  -- 반올림 
select ROUND(1223.87633, 3);  -- 어디서 반올림할지 위치 지정값이 반드시 있다 

-- 진법변환 

SELECT CONV('AA', 16, 2);   -- 숫자, 그숫자의 진법, 바꾸고자 하는 진법
-- AA 16 진수 - 2진수로         

SELECT CONV('AA', 16, 10);

SELECT pi(), DEGREES(PI()), RADIANS(180) ;   -- degrees 원주율을 각도로 바꾼다, <-> radians  
  
-- mod : 나머지 구하는 연산자 

SELECT MOD(157, 10), 157 % 10, 157 MOD 10;
 

-- 제곱(pow), 제곱근(sqrt)
SELECT POW(2,3), SQRT(16);
 
-- 랜덤값 추출하기 
SELECT RAND();  -- 0 ~ 1사이의 실수값을 내부 시계를 이용해서 계속 다른 값을 추출한다 

SELECT floor(RAND()*10+1);

-- sign

SELECT SIGN(180);

-- truncate 버림 -- 특정위치값 이후로 버림
SELECT TRUNCATE(1234.1378, 3);
SELECT TRUNCATE(1234.1378, -3);



-- 날짜관련 함수들 - 개발때 많이쓴다. 마감 할때 
-- adddate - 잘짜 더하기, subdate 빼기 

SELECT ADDDATE('2021-11-12',  INTERVAL 31 DAY),  ADDDATE('2021-11-12',  INTERVAL 2 MONTH);

-- 오늘부터 6개월 이후 

SELECT ADDDATE(NOW(), INTERVAL 6 MONTH);

SELECT ADDDATE(curdate(), INTERVAL 6 MONTH);

SELECT subdate(curdate(), INTERVAL 6 MONTH);

SELECT ADDTIME(NOW(), '1:0:0');  -- 시간:분:초

SELECT YEAR(CURDATE()), month(CURDATE()), DAY(CURDATE()), DAYOFMONTH(CURDATE()); 


SELECT hour(CURTIME()), MINUTE(CURTIME()), CURRENT_TIME, CURTIME();
 
SELECT DATEDIFF( NOW(), '2021-05-07'); -- 날짜와 날짜 사이의 간격 , timediff 


-- 말일까지 몇일 남았는지  last_day, datediff  젤 중요 

SELECT LAST_DAY(NOW());
 
SELECT DATEDIFF( LAST_DAY(NOW()), NOW());


SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());



-- union 연산과 union all 연산 

USE mydb2;
select ename from emp where deptno=10
UNION ALL 
select ename from emp2 where deptno=10;

-- union all 로 묶을때 서로 데이터 타입과 위치, 개수만 맞으면 묶을 수 있다 

select ename, empno from emp where deptno=10
UNION ALL 
select dname, deptno from dept;

-- 중복제거해서 가져옴 
select ename, empno from emp where deptno=10
UNION  
select dname, deptno from dept;


select ename, empno from emp where deptno=10
UNION  
select ename, empno from emp2 where deptno=10

-- 관공서 사이트 구축하면 기본 50개 이상 ~ 100 200 
-- 게시글을 많이 안쓸떄  게시판 100개를 한테이블을 썻던 시대가 있었어 
-- 구분자를 두로 게시글들을 구분 
-- 게시글이 너무 많이 올라오면 속도가 느련다. 테이블들을 분리시켜서 
-- 테이블 하나당 게시판 하나 
-- 검색참에 검색을 하면 테이블이 다 다른데 어떻게 검색을 하지 ?
-- 검색한 결과들을 하나로 묶어서 가져오는걸 union이라고 한다 


-- 페이징 쿼리 : dbms 마다 다르다 , mysql 이 젤 쉽다. 
-- limit 명령어 : limit start, count
-- select, from, where, order limit  순임 

USE employees;
SELECT * FROM employees  LIMIT  0,  10;   
SELECT * FROM employees  LIMIT 10,  10;
SELECT * FROM employees  LIMIT 20,  10;
SELECT * FROM employees  LIMIT 30,  10;


USE mydb2;

CREATE TABLE visit_count2 ( id INT, DAY1 INT, DAY2 INT, DAY3 INT, DAY4 INT, DAY5 int );
INSERT INTO visit_count2 values(1, 200, 300, 400, 500, 500);
INSERT INTO visit_count2 VALUES(2, 220, 303, 440, 550, 700);
-- 데이터는 열로 되어 있는데 


SELECT * FROM visit_count2;

-- 행으로 바꿔서 가져올떄 
SELECT DAY1 FROM visit_count2 where id=2
UNION ALL 
SELECT DAY2 FROM visit_count2 WHERE id=2
UNION ALL 
SELECT DAY3 FROM visit_count2 WHERE id=2
UNION ALL 
SELECT DAY4 FROM visit_count2 WHERE id=2
UNION ALL 
SELECT DAY5 FROM visit_count2 WHERE id=2;



-- mysql 도 내부에 스크립트 언어가 있음 저장프로시저
-- 전자세금계산서 롯데정보통신 , 전표를 한달에 몇백만건, 마감을 친다. 
-- 데이터베이스 내에서 마감처리를 프로그램을 해결 한다. 
-- mysql 내에서 프로시저라는것을 통해서 자동처리를 해준다 

