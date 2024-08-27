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
