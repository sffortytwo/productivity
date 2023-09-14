create table if not exists task_types (
    type varchar not null unique
);

insert into task_types (type) values ('task');
insert into task_types (type) values ('spike');

--

create table if not exists tasks (
    id uuid default gen_random_uuid() primary key not null,
    name varchar not null,
    task_type varchar not null,
    constraint fk_task_type foreign key(task_type) references task_types(type)
);

--

create table if not exists field_types (
    name varchar not null unique
);

insert into field_types (name) values ('varchar');
insert into field_types (name) values ('boolean');
insert into field_types (name) values ('integer');
insert into field_types (name) values ('date');
insert into field_types (name) values ('array');
insert into field_types (name) values ('object');

--

drop table fields;
create table if not exists fields (
    id uuid default gen_random_uuid() primary key not null,
    name varchar not null,
    field_type varchar not null,
    task_type varchar not null,
    constraint fk_field_type foreign key(field_type) references field_types(name),
    constraint fk_task_type foreign key(task_type) references task_types(type)
);

insert into fields (name, field_type, task_type) values ('priority', 'integer', 'task');

--

create table if not exists fields_tasks (
	task_id uuid not null,
	field_id uuid not null,
	value_integer integer,
	value_varchar varchar,
	value_date date,
	value_boolean boolean,
	value_json jsonb,
	constraint pk_fields_tasks primary key(task_id, field_id)
);

select * from fields;