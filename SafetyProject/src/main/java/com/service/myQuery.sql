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


alter table safety_schema.inspectdtls add column severity varchar(20);

select * from safety_schema.problems;

