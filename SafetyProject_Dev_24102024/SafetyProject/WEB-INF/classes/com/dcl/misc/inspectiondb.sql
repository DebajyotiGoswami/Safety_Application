select * from safety_schema.office where office_type='Division';


select * from safety_schema.team_assignment ta, safety_schema.inspectdtls id
where ta.inspection_id=id.inspection_id
and ta.emp_assigned_by='90012775';

alter table safety_schema.images alter column inspection_image type text;
alter table safety_schema.images alter column inspection_image DROP NOT NULL;

alter table safety_schema.images alter column rectification_image type text;
alter table safety_schema.images alter column rectification_image DROP NOT NULL;

ALTER TABLE safety_schema.images ADD COLUMN inspection_image_id VARCHAR(100);
ALTER TABLE safety_schema.images ADD COLUMN rectification_image_id VARCHAR(100);


select * from safety_schema.inspectdtls where pre_image is not null;


select * from safety_schema.inspectdtls i, safety_schema.teamassign t
where i.inspection_id=t.inspection_id;

ALTER TABLE safety_schema.inspectdtls ADD COLUMN inspection_by_name VARCHAR(100);