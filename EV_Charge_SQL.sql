-- 유저 테이블
create table EV_user (
         user_no int auto_increment primary key,  -- 순서를 위한 자동 증가 번호
          user_id varchar(50) not null unique,    -- 사용자 ID
          user_password varchar(100) not null,         -- 비밀번호
         user_name varchar(20) not null,                -- 이름
         user_email varchar(50),               -- 이메일
         user_province VARCHAR(50),                   -- 도
         user_city VARCHAR(50)                    -- 시
      );
        
INSERT INTO EV_user (user_id, user_password, user_name, user_email, user_province, user_city) 
VALUES
('test', 'test123', 'test', 'test@naver.com', 'province', 'city');

select count(*) from EV_user where user_id='test';
select count(*) from EV_user where user_id='test' and user_password='test123';
select * from EV_user;

drop table EV_user;

commit;

-- 지역 테이블
create table erea (
    erea_id INT PRIMARY KEY,
    erea_province VARCHAR(50),
    erea_city VARCHAR(50)
);

INSERT INTO erea (erea_id, erea_province, erea_city) VALUES
(1, '서울특별시', '강남구'),
(2, '서울특별시', '강동구'),
(3, '경기도', '수원시'),
(4, '경기도', '고양시');

select count(*) from erea where user_id='test';
select count(*) from erea where user_id='test' and user_password='test123';
select * from erea;
-- 도 선택
select distinct erea_province
  from erea;
-- 시 선택
select distinct erea_city
  from erea
 where erea_province = '경기도';
