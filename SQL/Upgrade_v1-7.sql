/*****************************************************/
/* Personal Issue Filters */
/*****************************************************/
if exists(select name from sysobjects where name='personalfilters') drop table personalfilters

create table personalfilters
(
filterid numeric(10,0) identity(1,1),
filtername varchar(100) not null default (''),
userid numeric(10,0) not null default(0),
projid numeric(10,0) not null default(0),
compid numeric(10,0) not null default(0),
fixedinverid numeric(10,0) not null default(0),
assignedto numeric(10,0) not null default (0),
isstype numeric(10,0) not null default(0),
isspriority numeric(10,0) not null default(0),
issstatus numeric(10,0) not null default(0),
issresolution numeric(10,0) not null default(0),
risklevel numeric(10,0) not null default(0),
customfieldid numeric(10,0) not null default(0),
keywords varchar(100) not null default (''),
showtimings bit not null default(0),
excludeclosed bit not null default(0),
searchcomments bit not null default(0),
systemfilter numeric(10,0) not null default(0),
issueid varchar(100) not null default(0),
sortfield varchar(100) not null default (''),
sortdirection numeric(10,0) not null default(0),
created datetime not null default current_timestamp
)
create index ind_id on personalfilters(filterid)
create index ind_id2 on personalfilters(userid,projid)

/*****************************************************/
/* Reset User Password */
/*****************************************************/
alter table USERS add ResetPWD varbinary(16) NULL


