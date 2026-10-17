-- data clenaing

select * from project;

-- 1 removing duplication 
-- 2 Standardization of Data
-- 3 null values 
-- 4 removing columns 


-- copy of the intier data

 
create table project_1
like project;


-- all data insert the new table for project_1
select * from project_1;


-- insert data of all values in the new copy of schemas
insert project_1
select *
from project;



-- removing duplicated data
select *, 
row_number() over(
partition by company,industry,total_laid_off,percentage_laid_off,'date')as row_num
from project_1;

with duplicat_cte as
(
select *, 
row_number() over(
partition by company,location,total_laid_off,percentage_laid_off,'date',stage ,country,funds_raised_millions)as row_num
from project_1
)
select *
from duplicat_cte
where row_num > 1;


select * 
from project_1
where company ='Casper';


-- delete the duplicated value in 



with duplicat_cte as
(
select *, 
row_number() over(
partition by company,location,total_laid_off,percentage_laid_off,'date',stage ,country,funds_raised_millions)as row_num
from project_1
)

delete
from duplicat_cte
where row_num > 1;


CREATE TABLE `project_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from project_2;

insert into project_2
select *, 
row_number() over(
partition by company,location,total_laid_off,percentage_laid_off,'date',stage ,country,funds_raised_millions)as row_num
from project_1;

select *
 from project_2
 where row_num > 1;
 
 -- deleting
 
 delete
 from project_2
 where row_num > 1;
 
 select *
 from project_2;
 
 
 -- -- 2 Standardization of Data
 -- company apply
 select company, trim(company)
 from project_2;
 
 update project_2
 set company = trim(company);
 
 
select *
 from project_2
 where industry like 'Crypto%';
 
 
 update project_2
 set industry = 'Crypto%'
 where industry like 'Crypto%';
 
  select distinct country,trim(TRAILING '.' FROM country)
 from project_2
 order by 1;
 
 update  project_2
 SET country =trim(TRAILING '.' FROM country)
 WHERE country like  'United States%';
 
 
   select `date`
 from project_2;
 
 update project_2
 set `date` = str_to_date(`date` , '%m/%d/%Y');
 
 alter table  project_2
 modify column `date` date;
 
 select * from project_2;
 
 --  3 null values 
 
  select *
  from project_2
  where total_laid_off is null
  and percentage_laid_off is null;
  
  
  update project_2 
  set industry = null
  where industry = '';
  
  
    select *
  from project_2
  where industry  is null
  or indusrty = '';
  
  
    
select *
from project_2
where company like 'Bally%';

select * 
from project_2 t1
join   project_2 t2
on t1.company = t2.company 
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;


update project_2 t1
join   project_2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;


select *
from project_2;


select *
  from project_2
  where total_laid_off is null
  and percentage_laid_off is null;
  

delete
from project_2
where total_laid_off is null
and percentage_laid_off is null;

select * 
from project_2;


alter table project_2
drop column row_num;

