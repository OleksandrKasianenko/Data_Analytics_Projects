use analyst_junior_test_task;

#1
select country, job_title, age,  max(salary) from salary
where country = 'Australia'
group  by country, job_title, age
order by max(salary)  desc
limit 10 ;

#2
select round(avg(salary),0), max(salary),min(salary)  from salary ;

#3
select job_title, years_of_experience , 
case  when salary > '200000' then  '>200000'
  when salary >= '100000' then  '>100000'
   when salary = '50000' then '50000'
else '<50000'
end as segment 
 from salary;
 
 #4
Select job_title, count(*) from salary
group by job_title;

#5
Select country, race, count(*) from salary
where country = 'UK' 
group by country,race;

#6
select  job_title, round(avg(age),0) from salary
group by 
job_title

#7
select job_title, country, round(avg(salary),0) from salary
where country in ('UK','China', 'USA')
group by job_title,country

#8
select * from salary
where job_title like 'Di%'  or job_title like 'Sa%'

#9
select country, job_title, round(avg(years_of_experience),0) as years from salary
group by  job_title, country
order by years desc
limit 5

#10 
Select *, 
avg(age) over ( partition by job_title) as 'avg',
sum(age) over ( partition by job_title) as 'sum',
min(age) over ( partition by job_title) as 'min',
max(age) over ( partition by job_title) as 'max',
count(age) over ( partition by job_title) as 'count'
from salary
where gender = 'Male';

#11
select *,
  salary -  min(salary) over ( partition by job_title) as 'min'

from salary

#12
select * ,
ROW_NUMBER() over ( partition by job_title order by country) as 'ROW_NUMBER',
RANK() over ( partition by job_title order by country ) as 'RANK',
dense_rank() over  ( partition by job_title order by country ) as 'dense rank'
from salary

#13
select * from salary