--CREATE TABLE safety_schema.Login (
--    erp_id VARCHAR(10),
--    emp_name VARCHAR(50),
--    designation VARCHAR(50),
--    office_code VARCHAR(10),
--    device_id VARCHAR(255) ,
--    user_agent VARCHAR(255) ,
--    ip_address VARCHAR(255) ,
--    login_timestamp TIMESTAMP ,
--    logout_timestamp TIMESTAMP ,
--    otp_verified BOOLEAN
--);

--drop table safety_schema.login;
select * from safety_schema.dev_otp where xuuid like '90008282%';

select * from safety_schema.roles;

insert into safety_schema.roles
values ('A', '90012775', CURRENT_TIMESTAMP, 'ADMIN_ACCESS', 'ALL ACCESS');

select * from safety_schema.stell;

INSERT INTO safety_schema.stell
(ROLE_VALID_FLAG, STELL_VALID_FLAG, CREATE_ON, CREATE_BY, ROLE_DESCRIPTION,
ROLE_ID, STELL_DESC, STELL)
VALUES ('A', 'A', CURRENT_TIMESTAMP, '90012775', 'ALL ACCESS', '7', 'DIRECTOR(GENERATION)', '50032592');

INSERT INTO safety_schema.stell (ROLE_VALID_FLAG, STELL_VALID_FLAG, CREATE_ON, CREATE_BY, ROLE_DESCRIPTION, ROLE_ID, STELL_DESC, STELL) VALUES ('A', 'A', CURRENT_TIMESTAMP, '90012775', 'ALL ACCESS', '7', 'Testald0','555');


update safety_schema.stell
set stell='50031511'
where stell_desc='ADDL CHIEF ENGINEER';

--insert into safety_schema.vulnerabilities 
--(site_id, inspection_id, inspection_by, problem_id, location_remarks,
--problem_remarks, assigned_office_code, present_status, inspection_date, 
--pre_image, post_image)values 
--((CONCAT('SITE-', currval('safety_schema.vulnerabilities_site_id_serial_seq'))), 
--'4', 90012775, 1, 'ddd', 'dddddd', '3332401', 'INSPECTED', '2024-08-15','test.jpg', 'test.jpg')

select * from safety_schema.vulnerabilities;
--
--SELECT nextval('safety_schema.vulnerabilities_site_id_serial_seq');

--insert into safety_schema.vulnerabilities 
--(site_id, inspection_id, inspection_by, problem_id, location_remarks,
--problem_remarks, assigned_office_code, present_status, inspection_date, 
--pre_image, post_image)values 
--((CONCAT('3332401','_', nextval('safety_schema.vulnerabilities_site_id_serial_seq'))), 
--'4', 90012775, 1, 'ddd', 'dddddd', '3332401', 'INSPECTED', '2024-08-15','test.jpg', 'test.jpg')

--insert into safety_schema.vulnerabilities(site_id, inspection_id, inspection_by, problem_id, 
--location_remarks,problem_remarks, assigned_office_code, present_status, 
--inspection_date,pre_image, post_image)values((CONCAT('SITE','_', nextval('safety_schema.vulnerabilities_site_id_serial_seq'))),
--'4', 90012775, 1, 'ddd', 'dddddd', '3332401', 'INSPECTED', '2024-08-15','test.jpg', 'test.jpg')


--select * from safety_schema.stell where stell like '500327%';
--
--INSERT INTO safety_schema.stell
--VALUES ('50032705', 'CE(IT&C)', '5', 'ASSIGNER', '90012775', NOW(), 'A', 'A')

select description from safety_schema.problems where asset_type_id in 
(select asset_type_id from safety_schema.asset_type where network_type='LT'
and asset_name='EARTHING')


select * from safety_schema.problems
where asset_type_id='24';


select description from safety_schema.problems where asset_type_id in (select asset_type_id from safety_schema.asset_type where network_type='LT'and asset_name='EARTHING')

select problem_id from safety_schema.problems
where description='LT Earthing Broken or Detached Earth Wire';

insert into safety_schema.vulnerabilities
(site_id, inspection_id, inspection_by, problem_id, location_remarks,problem_remarks, 
assigned_office_code, present_status, inspection_date,pre_image, post_image)
values((CONCAT('3332402','_', nextval('safety_schema.vulnerabilities_site_id_serial_seq'))),
'4', 90012775, (select problem_id from safety_schema.problems
where description='LT Earthing Broken or Detached Earth Wire'), 'Rathtala', 'Earth Wire Detached', '3332402', 'INSPECTED', 
'2024-08-15 +05:30','', 'test.jpg')


select * from safety_schema.office

--ALTER TABLE safety_schema.inspectdtls
--ALTER COLUMN inspection_id TYPE VARCHAR(50)
--ALTER COLUMN solution_id TYPE VARCHAR(50)
--ALTER COLUMN site_id TYPE VARCHAR(50)

ALTER TABLE safety_schema.inspectdtls
ALTER COLUMN post_image TYPE TEXT


select * from safety_schema.teamassign
where assigned_date>='2024-09-27';


select inspection_id, emp_assigned_by, emp_assigned_to,office_code_to_inspect, inspection_from_date, inspection_to_date, status from safety_schema.team_assignment where inspection_from_date<= now() and emp_assigned_to= '90012775'

select * from safety_schema.dev_otp
order by cr_dt;
;


select * from safety_schema.inspectdtls 
where inspection_by='90015419'

select * from  safety_schema.teamassign 
where emp_assigned_by='90006788';

select latitude, longitude, count(distinct site_id)
from safety_schema.inspectdtls 
where inspection_by='90010101'
group by latitude, longitude

select * from safety_schema.login;


alter table safety_schema.inspectdtls add column severity varchar(20);

select * from safety_schema.problems;

ALTER TABLE safety_schema.teamassign
ALTER COLUMN inspected_by TYPE VARCHAR(50)


update safety_schema.stell

select emp_assigned_by, count(distinct inspection_id) 
from safety_schema.teamassign
group by emp_assigned_by

select * from safety_schema.inspectdtls where site_id='354110224091700';

UPDATE safety_schema.inspectdtls
SET inspection_by_name= 'Debajyoti Goswami'
where site_id='354110224091700';


select inspection_by, count(distinct inspection_id) 
from safety_schema.inspectdtls
group by inspection_by


select * from safety_schema.hq_office_list;

select 
CASE 
WHEN substr(office_name, length(office_name)- 2, 3) = 'CCC' then 'CCC'
WHEN substr(office_name, length(office_name)- 5, 6) = 'REGION' then 'REGION'
WHEN substr(office_name, length(office_name)- 7, 8) = 'DIVISION' then 'DIVISION'
WHEN substr(office_name, length(office_name)- 3, 4) = 'ZONE' then 'ZONE'
ELSE 'OTHER'
END, count(distinct office_code) 
from safety_schema.office
--where substr(office_name, length(office_name)- 2, 3) <> 'CCC'
group by CASE 
WHEN substr(office_name, length(office_name)- 2, 3) = 'CCC' then 'CCC'
WHEN substr(office_name, length(office_name)- 5, 6) = 'REGION' then 'REGION'
WHEN substr(office_name, length(office_name)- 7, 8) = 'DIVISION' then 'DIVISION'
WHEN substr(office_name, length(office_name)- 3, 4) = 'ZONE' then 'ZONE'
ELSE 'OTHER'
END

SELECT * FROM SAFETY_SCHEMA.OFFICE
WHERE SUBSTR(OFFICE_NAME, LENGTH(OFFICE_NAME)- 7, 8) = 'DIVISION'

SELECT * FROM SAFETY_SCHEMA.OFFICE
WHERE SUBSTR(OFFICE_NAME, LENGTH(OFFICE_NAME)- 2, 3) = 'CCC'


SELECT * FROM SAFETY_SCHEMA.STELL
where stell= '50032737';



select * from safety_schema.inspectdtls
where inspection_id= '3534000241023053339'
and site_id= '3532410230533390';

select * from safety_schema.images

select * from safety_schema.inspectdtls

select count(*) from safety_schema.inspectdtls

select * from safety_schema.inspectdtls i , safety_schema.images i2, 
safety_schema.office o, safety_schema.insprobmaster i3 , safety_schema.asset_type at2
where i.inspection_id = i2.inspection_id 
and i.site_id = i2.site_id 
and i.assigned_office_code =o.office_code
and i.inspection_id = '3153402240910094609'
and i.problem_id = i3.problem_id 
and i3.asset_type_id = at2.asset_type_id

select * from safety_schema.inspectdtls
where inspection_id
in
( select inspection_id from safety_schema.images)

select * from safety_schema.office
where office_type = '';

select distinct office_type from safety_schema.office;

select count(*)
from safety_schema.office

select * from safety_schema.hq_office_list;

insert into safety_schema.hq_office_list
(office_level, office_name, flag, office_code)
values ('DIVISION', 'KALYANI DIVISION', 'A', '3332000');





