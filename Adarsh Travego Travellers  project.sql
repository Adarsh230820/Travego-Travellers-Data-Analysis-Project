            --task 1 
            
	--create a schema named travego
    
 drop schema if exists Travego;
create schema if not exists Travego;
USE Travego;
 
--Create the tables mentioned above with the mentioned column names

Drop table if exists Passenger;
create table if not exists Passenger(
Passenger_id int primary key,
Passenger_name varchar(20),
Category varchar(20),
Gender varchar(20),
Boarding_City varchar(20),
Destination_City varchar(20),
Distance int,
Bus_Type varchar(20)
);

Drop table if exists price;
create table if not exists price(
id int primary key,
Bus_type varchar(20),
Distance int,
Price int
);

--c.	Insert the data in the newly created tables using sql script or using MySQL UI. 


insert into Passenger values
(1, 'Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
(2, 'Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
(3, 'Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
(4, 'Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper'),
(5, 'Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper'),
(6, 'Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
(7, 'Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper'),
(8, 'Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
(9, 'Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');
insert into price values 
(1, 'sleeper', '350', '770'),
(2, 'Sleeper', 500, 1100),
(3, 'Sleeper', 600, 1320),
(4, 'Sleeper', 700, 1540),
(5, 'Sleeper', 1000, 2200),
(6, 'Sleeper', 1200, 2640),
(7, 'Sleeper', 1500, 2700),
(8, 'Sitting', 500, 620),
(9, 'Sitting', 600, 744),
(10, 'Sitting', 700, 868),
(11, 'Sitting', 1000, 1240),
(12, 'Sitting', 1200, 1488),
(13, 'Sitting', 1500, 1860);

                           --task2
--How many females and how many male passengers traveled a minimum distance of 600 KMs

select * from Passenger;
select * from Price;
select count(*) 'Count of female passengers travelled a minimum distance of 600kms' from passenger 
where gender = 'F' and distance >= 600;

select * from Passenger;
select * from Price;
select count(*) 'Count of male passengers travelled a minimum distance of 600kms' from passenger 
where gender = 'M' and distance >= 600;

--Find the minimum ticket price of a Sleeper Bus

select * from Passenger;
select * from Price;
select min(price) from price where lower(bus_type) like 'sleeper';

--Select passenger names whose names start with character 'S' 

select passenger_name from passenger where passenger_name like 'S%';

--Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

select passenger_name, price from passenger p1 left join price p2 
using(distance,bus_type)
where p1.distance = 1000 and p1.bus_type = 'Sitting'
union
select passenger_name, price from passenger p1 right join price p2 
using(distance,bus_type)
where p2.distance = 1000 and p2.bus_type = 'Sitting';

--What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus?  

select ifnull(passenger_name,'Pallavi') as name,p1.bus_type, price from passenger p1 left join price p2 
using(distance,bus_type)
where p1.distance = (select distance from passenger where passenger_name='Pallavi' and (boarding_city='Panaji' and destination_city='Bengaluru' or boarding_city='Bengaluru' and destination_city='Panaji')) and p1.bus_type in ('Sitting','Sleeper')
union
select ifnull(passenger_name,'Pallavi') as name,p2.bus_type, price from passenger p1 right join price p2 
using(distance,bus_type)
where p2.distance = (select distance from passenger where passenger_name='Pallavi' and (boarding_city='Panaji' and destination_city='Bengaluru' or boarding_city='Bengaluru' and destination_city='Panaji')) and p2.bus_type in ('Sitting','Sleeper'); 

--What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

update passenger set category = 'Non-AC' where bus_type = 'Sleeper';
select  * from passenger;

--List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. 

select distinct distance as 'Unique distances from passenger table in descending order'
 from passenger order by distance desc;

--Display the passenger name and percentage of distance traveled by that passenger from the total distance traveled by all passengers without using user variables 



select passenger_name, (sum(distance)/(select sum(distance) from passenger)) * 100 as 'Percentage of distance travelled by that passenger from the total distance travelled by all passengers' 
from passenger group by passenger_name;


