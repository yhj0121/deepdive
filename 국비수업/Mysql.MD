데이터 베이스 정의와 특징

데이터 베이스

데이터의 집합

-여러 명의 사용자나 응용 프로그램이 공유하는 데이터

-동시에 접근 가능해야

-데이터 저장 공간 자체

dbms 프로그램

데이터 를 관리 운영하는 역활

이전에 파일시스템의 문제점에서 출발함

파일시스템의 단점

1.특정 프로그램에 종속된다

2.일관성이 없다 파일들이 서로 유기적 관계까 이씾 않아서

특정파일만 수정하다보면 다른 파일이 수정 안되는 문제가 발생한다.

ex)학생의 자료를 저장하는데 학적과 관련한것은

학적부 파일에 저장하고

성적과 관련된것은 성적파일에 저장한다고 할떄

각 파일은 서로 유기적인 어떤 관계를 갖기 않으므로 홍길동이란 학생이 휴학을 했다면

학적부파일에서 휴학임을 표시 해야하한다.

프로그램도 복잡하고 실수도 파일에 각각 다른 정보를 저장할 수 잇고 보안성도 없어서 파일을 실수로 삭제하거나 수정할 수도 있다.

이런 성격을 동털어서 일관성이라 하는데 일관성 결어가 파일시스템의 가장 큰 문제이다.

콘솔에서 mysql clinet 작동하기

시작 cmd 만일 포트번호가 다를 경우 포트번호  기술해워야한다 mysql은 기본적은 3306

mysql -u root -p —port+3306

데베 만들기

1.mydb라는 데이터 베이스 만들기 utf8은 한글 설정

create database mydb default character set utf8 collate utf8_general_ci;

2.계정 만들어서 권환 부여하기 - 계정 만들고 권한 부여하는데 mysql은 한번에 가능

계정 만들기

create user '아이디@주소' identified by '비밀번호';

create user 'user01@localhost' identified by '1234';

mydb에 접근 가능하긴한데 들어와서 해라user01

grant all privileges on 데이터베이스이름.* to 아이디@localhost identified by '비번';

grant all privileges on mydb.* to user01@localhost identified by '1234';

- 원하는 컬럼명을 직접 기술하는것이 속도가 빠르다
- 

```sql
select customernumber, customername from customers;
```

- -테이블명에 ailas 주고 ailas를 이용하여 데이터 전달 가능

```sql
select a .customernumber, a.customername, a.city
from customers a
where a.city <> 'Nantes';

select count(*) from products
where buyPrice between 50 and 60;
```

- - 대소문자 무시

```sql

select * from customers
where customernumber in(151,187,201,204,209,112,114)
use mydb
create table score (

```

- 조건문 가능

```sql
id int primary key auto_increment,
name varchar(40),
kor int,
eng int,
mat int

);

insert into score(name, kor, eng, mat) values('홍길동', 90, 90, 90);
insert into score(name, kor, eng, mat) values('임꺽정', 80, 80, 70);
insert into score(name, kor, eng, mat) values('장길산', 60, 90, 80);
insert into score(name, kor, eng, mat) values('홍경래', 100, 100, 90);
insert into score(name, kor, eng, mat) values('장승업', 90, 90, 100);

```

- 데이터 삽입
- 
- 서브 쿼리 : 과호안에 쿼리가 먼저 실행

```sql
select a.*, total/3 average from
(
select name, kor,eng,mat ,(kor+eng+mat) total
from score
)a;
```

- 데이터베이스의 정렬 기능
 asc: 오름차순 생략 가능 desc 내림차순

```sql

select customernumber, city, customername from customers
order by customername desc;
```

```sql
- 도시 오름차순 이름 내림차춤
select customernumber, city, customername from customers
order by customername desc, city asc;
```

```sql
select customernumber, city, customername from customers
where customerNumber <=300
order by customername desc, city asc;
```

- **- primary key 지정 방법
ddl**(data definitin language - 전체 구조 결정한다. 테이블 만들고 수정 삭제
create drop alter
- dml(data manipultion language) 데이터 조작어 테이블내의 데이터만
- insert updatae delete
- dcl :grant rollback commit revoke

### primary key

pk특징: 중복 제외 null 값도 못들어감

```sql
alter table emp add constraint PK_EMP primary key(empno);
desc emp;
-- emp 테이블의 deptno는 dept테이블 deptno와 참조 관계(foreign key) 관계 되어있음
```

;

 join 연산이랑 서브쿼리 라는 연산을 통해서 두개의 테이블로 부텉 데이터 만들어 낸다
 emp 테이블의 부서번호를 보고 dept 테이블로 부터 부서명을 가져오려 한다.

 join 연산이나 서브쿼리 연산이 foreign 키가 없 다고 안돌아 가지는 않는다.(조회)
 데이터 입력시 두 테이블에 강한 제약을 가해야 한다

/*
1.emp 테이블 입장에서는
1)dept테이블에 존재하지 않는 부서번호가 입력되면 안된다.
2) 부서번호 50 넣으면 에러가 발생하도록 해야한다

2)dept 테이블 입장
새로운 부서번호 넣는거는 관게 없는데
기존 emp 테이블에 있는 부서 번호를 없애면 10번을 없앤다면
테이블 삭제시 문제가 발생해야한다. 나를 참조하는 테이블이 있기 때문에

**foreign key 줄수 있는 조건**
참조가 이뤄지는 테이블의 필드가 primary key거나 unique 제약조건이어야 한다.

**alter 사용법**

alter table 테이블 명 add [constraint 제약조건이름] [대괄호]-생략 가능,
foreign key(필드)
reference 테이블(필드)

alter table emp add foreign key(deptno) references dept(deptno);
-- dept테이블에 primary key 추가해야함alter
-- primary key를 부여할 떄 오류가 발생하느 ㄴ경우는 이미 존재하는 경우

alter table dept add primary key(deptno);

desc dept;
-- 안전 장치가 되어있디
delete from dept where deptno=10;

drop table dept cascade;

- - dept 참조하는 테이블부터 샂게하던가 또는 나를 참조하느 모든 foreign key 삭제하고나서
-- 테이블 삭제해줌

### 조인

- **조인 연산**: 두개 이상의 테이블이 특정 조건에 맞추어서 결합하기

조인 유형: inner join, outer join,self join

**1.inner joi**

```sql

select ename, dname
from emp
inner join dept on emp.deptno=dept.deptno;
```

**문제:이름이 pamela인 고객이름 직원이름 직원 라스트내임 찾기**

```sql
select c.customername, employees.firstname, employees.lastname
from customers c
inner join employees  on c.salesRepEmployeeNumber = employees.employeenumber
where  employees.firstname = 'Pamela';
```

**inner join 두개의 테이블을 결합하여 만드는데 양쪽 다 필드값이 존재해야함**

**inner는 함치는 값이 있어야함**

**2.outer join**

outer 특징

 **1.outer join 연산 left하고 right
 from절에 가까운게left left outer join하면 left쪽 table 내용 다 출력**

2. **from절에서 조금이라도 먼게 right**

```sql
select ename, dname
from emp
left outer join dept on emp.deptno=dept.deptno;
```

```sql
- 할당받지 못한것도옴
select ename, dname
from emp
right outer join dept on emp.deptno=dept.deptno;
```

```sql
select a.firstname, a.officecode, b.city, b.addressline1, b.phone
from employees a
inner join offices b on a.officeCode=b.officeCode;
```

```sql
- select a.shippeddate, c.productname, b.quantityordered, b.priceeach
-- from orders a
-- left outer join orderdetails b on a.ordernumber = b.ordernumber
-- left outer join products c on b.productcode = c.productcode;
```
