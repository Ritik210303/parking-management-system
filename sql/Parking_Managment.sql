-- Table 1 
create table customer
(
c_id varchar(15) constraint c1 primary key check(c_id like('D______N___')),
f_name varchar(10) not null,
m_name varchar(10),
l_name varchar(10) constraint c2 not null,
contact_no integer constraint c3 not null unique,
customer_lience_id varchar(20) constraint c4 not null unique,
address VARCHAR(20),
dob date not null,
age integer
);
insert into customer values('D170422N001','Naresh','Chirag','Patel',8796548701,'GJ23 20210166','Vadodra','17-08-00',22);
insert into customer(c_id,f_name,l_name,contact_no,customer_lience_id,dob) values('D170422N002','Miit','Desai',6978553601,'MH40 20215876','23-04-87');
insert into customer(c_id,f_name,l_name,contact_no,customer_lience_id,dob) values('D170422N003','Rushikesh','Yadav',7020326597,'GJ21 20212356','21-03-04');
insert into customer(c_id,f_name,l_name,contact_no,customer_lience_id,dob) values('D180422N001','Alphesh','Kumar',8799534097,'GJ21 20024556','22-02-02');
insert into customer values('D180422N002','Jivesh','Kshit','Kurve',9421872545,'MP23 20210166','Borsad','12-12-00',21);
insert into customer values('D190422N001','Nachiket','Rajpal','Shinde',8879564523,'GJ01 20190186','Ahemdabad','03-08-88',42);
select * from customer;
update customer set age= extract(year from current_date)- extract(year from dob);
update customer set m_name='Mohanbahi', address='Rajcoat' where f_name='Miit';
-- Table 2
CREATE table vehicle
(
v_number varchar(15) constraint v1 primary key check(v_number like('__ __ __ ____')),
c_id varchar(15) constraint v2 references customer(c_id),
v_name varchar(15),
v_category varchar(10) constraint v3 not null check(v_category in('7 seater','suv','sedan','bike','h-bag')),
auto_manual varchar(6) constraint v4 check(auto_manual in('auto','manual')),
AI_or_not varchar(3) constraint v5 check(AI_or_not in('yes','no')),
type varchar(10) check(type in('4 wheeler','2 wheeler'))
);
Insert into vehicle values('MH 40 BJ 2050','D170422N001','Fortuner','7 seater','manual','no','4 wheeler');
Insert into vehicle values('GJ 23 AK 1050','D170422N002','MG Hecto','suv','auto','yes','4 wheeler');
Insert into vehicle values('GJ 21 BA 2103','D170422N003','ciaz','sedan','manual','no','4 wheeler');
Insert into vehicle values('MP 41 PK 4560','D180422N001','Royls Royes','h-bag','auto','yes','4 wheeler');
Insert into vehicle values('TN 11 RP 2015','D180422N002','kia solet','suv','auto','yes','4 wheeler');
Insert into vehicle values('GJ 01 XY 4568','D190422N001','R15','bike','manual','no','2 wheeler');
select * from vehicle;
--table 3
create table parking_slot
(
parking_date date constraint ps4 not null,
arriving_time varchar(10) not null,
departure_time varchar(10) not null,
floor_no integer not null,
slot_no integer not null,
c_id varchar(15) constraint ps1 references customer(c_id),
v_number varchar(15) constraint ps2 references vehicle(v_number),
parking_hours number,
constraint ps3 primary key(parking_date,arriving_time,floor_no,slot_no)
);
insert into parking_slot values('17-04-22','1:30 PM','3:30 PM',2,211,'D170422N001','MH 40 BJ 2050',2);
insert into parking_slot values('17-04-22','12:00 PM','3:00 AM',1,121,'D170422N002','GJ 23 AK 1050',3);
insert into parking_slot values('17-04-22','2:35 AM','3:02 AM',3,305,'D170422N003','GJ 21 BA 2103',0.5);
delete from parking_slot where c_id='D170422N002';
insert into parking_slot values('18-04-22','4:05 PM','11:02 PM',0,045,'D180422N001','MP 41 PK 4560',6);
insert into parking_slot values('18-04-22','6:00 AM','9:00 PM',2,211,'D180422N002','TN 11 RP 2015',15);
insert into parking_slot values('19-04-22','9:10 AM','10:15 PM',3,377,'D190422N001','GJ 01 XY 4568',1);
select * from parking_slot;
Alter table parking_slot add allocated_time number;
Alter table parking_slot add depature_date date;
update parking_slot set depature_date='17-04-22' where c_id='D170422N001';
update parking_slot set depature_date='17-04-22' where c_id='D170422N002';
update parking_slot set depature_date='17-04-22' where c_id='D170422N003';
update parking_slot set depature_date='18-04-22' where c_id='D180422N001';
update parking_slot set depature_date='18-04-22' where c_id='D180422N002';
update parking_slot set depature_date='19-04-22' where c_id='D190422N001';
delete from parking_slot where c_id='D180422N002';
update parking_slot set v_number='TN 11 RP 2015' where c_id='D180422N002';
update parking_slot set allocated_time=1 where c_id='D190422N001';
-- table 4
CREATE table pay
(
p_id varchar(10) constraint pa1 primary key,
c_id varchar(15) constraint pa2 references customer(c_id),
b_id integer,
total_charge number,
p_date date,
on_line varchar(10),
off_line varchar(10)
);
insert into pay(p_id,c_id,b_id,total_charge,p_date,on_line) values('pid142','D170422N001',142,100,'16-04-22','Gpay');
insert into pay(p_id,c_id,b_id,total_charge,p_date,off_line) values('pid199','D170422N002',199,50,'17-04-22','cash');
update pay set total_charge=150 where p_id='pid199';
insert into pay(p_id,c_id,b_id,total_charge,p_date,on_line) values('pid184','D170422N003',184,50,'17-04-22','upi');
insert into pay(p_id,c_id,b_id,total_charge,p_date,off_line) values('pid203','D180422N001',203,300,'18-04-22','cash');
insert into pay(p_id,c_id,b_id,total_charge,p_date,on_line) values('pid264','D180422N002',264,750,'19-04-22','card');
insert into pay(p_id,c_id,b_id,total_charge,p_date,on_line) values('pid232','D190422N001',232,50,'19-04-22','paytm');
select * from pay;
alter table pay add mode_ VARCHAR(10);
update  pay set mode_='online' where on_line is not null;
update  pay set mode_='offline' where off_line is not null;
alter table pay drop column on_line;
alter table pay drop column off_line;
alter table pay drop column total_charge;
-- table 5
create table bill
(
b_id integer constraint b1 primary key,
c_id varchar(15) constraint b2 references customer(c_id),
total_charge number,
parking_hours number,
status varchar(10) constraint b3 check(status in('processing','pending','failed','compleded'))
);
insert into bill values(142,'D170422N001',100,2,'pending');
insert into bill values(199,'D170422N002',150,3,'processing');
insert into bill values(184,'D170422N003',50,0.5,'compleded');
insert into bill values(203,'D180422N001',300,6,'compleded');
insert into bill values(264,'D180422N002',750,15,'processing');
insert into bill values(232,'D190422N001',50,1,'pending');
select * from bill; 
select * from customer where f_name like 'R%';
select * from customer where m_name is null;
select v_name,v_number from vehicle where type='4 wheeler' and v_category='suv';
select * from customer where dob between '17-08-00' and '22-02-02';
select * from bill where total_charge >= 150 and total_charge<750;
select * from customer where l_name like '_a%';
select max(total_charge) as "maximum charge" from pay;
select * from vehicle order by v_name asc;
insert into customer values('D170422N050','Nisarg','Mihir','Patel',8796648701,'GA23 19850166','Anand','17-08-14',22);
delete from customer where c_id='D170422N050';
select * from customer natural join vehicle;
select * from customer left outer join vehicle on customer.c_id=vehicle.c_id;
select * from pay,bill where status='pending';
select * from vehicle right outer join parking_slot on vehicle.v_number=parking_slot.v_number;
select * from vehicle full outer join parking_slot on vehicle.v_number>=parking_slot.v_number;
select status,count(*) as "number of paytment",sum(total_charge) AS "TOTAL CHARGE" from bill group by status;
create table temp
(
ecode integer primary key,
ename char(10),
salary decimal(7,2),
gender char(1) check(gender in('M','F'))
);
insert into temp values(121,'Ritik',54789.32,'M');
insert into temp values(101,'Riti',75789.32,'F');
insert into temp values(211,'Sahil',50789.32,'M');
insert into temp values(311,'Aryan',64749.32,'M');
select * from temp;
truncate table temp;
select * from temp;
drop table temp;