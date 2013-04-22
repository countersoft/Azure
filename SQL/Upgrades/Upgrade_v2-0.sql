--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 2.0 UPGRADE SCRIPT
--
--*********************************************************************************
--*********************************************************************************
truncate table geminiinstall
insert into geminiinstall (attribute_key,attribute_value) values (N'VERSION',N'2.0')
go

/* Timestamp addition */
alter table projects add tstamp timestamp not null
go
alter table projectresource add tstamp timestamp not null
go
alter table versions add tstamp timestamp not null
go
alter table components add tstamp timestamp not null
go
alter table issues add tstamp timestamp not null
go
alter table issuecomments add tstamp timestamp not null
go
alter table issueattachments add tstamp timestamp not null
go
alter table users add tstamp timestamp not null
go
alter table userroles add tstamp timestamp not null
go
alter table usersettings add tstamp timestamp not null
go
alter table issuelinktypes add tstamp timestamp not null
go
alter table issuelinks add tstamp timestamp not null
go
alter table customfielddefs add tstamp timestamp not null
go
alter table customfielddata add tstamp timestamp not null
go
alter table personalfilters add tstamp timestamp not null
go
alter table securityschemes add tstamp timestamp not null
go
alter table sourcecontrolissuefiles add tstamp timestamp not null
go
alter table timetracking add tstamp timestamp not null
go
alter table projectrepository add tstamp timestamp not null
go
alter table issuetypelut add tstamp timestamp not null
go
alter table issueprioritylut add tstamp timestamp not null
go
alter table issuestatuslut add tstamp timestamp not null
go
alter table issuestatetransitionlut add tstamp timestamp not null
go
alter table issueresolutionlut add tstamp timestamp not null
go
alter table issuerisklevellut add tstamp timestamp not null
go

/* View enhancements */
if exists(select name from sysobjects where name='issuesview') drop view issuesview
go

create view issuesview as
	select 
	a.issueid,
	isnull(b.compname,N'') as compname,
	isnull(b.compdesc,N'') as compdesc,
	isnull(c.typedesc,N'') as typedesc,
	isnull(d.prioritydesc,N'') as prioritydesc,
	isnull(e.statusdesc,N'') as statusdesc,
	isnull(f.resdesc,N'') as resdesc,
	isnull(g.projcode,N'') as projcode,
	isnull(h.reporteddesc,N'') as reporteddesc,
	isnull(i.assigneddesc,N'') as assigneddesc,
	isnull(j.vernumber,N'') as vernumber,
	isnull(j.vername,N'') as vername,
	isnull(j.verdesc,N'') as verdesc,
	a.projid,a.compid,a.fixedinverid,a.assignedto,a.reportedby,
	a.summary,a.longdesc,a.isstype,a.isspriority,a.issstatus,
	a.issresolution,a.created,a.revised,projcode+N'-'+cast(a.issueid as nvarchar(10)) as issuekey,
	a.startdate,a.duedate,
	a.risklevel,a.userdata1,a.userdata2,a.userdata3,a.percentcomplete,
	a.estimatedays,a.estimatehours,a.estimateminutes,
	isnull(k.riskdesc,N'') as riskdesc,
	a.isprivate,
	a.tstamp
	from issues a
		left outer join (select compid,compname,compdesc from components) b
			on a.compid=b.compid
		left outer join (select typeid,typedesc from issuetypelut) c
			on a.isstype=c.typeid
		left outer join (select priorityid,prioritydesc from issueprioritylut) d
			on a.isspriority=d.priorityid
		left outer join (select statusid,statusdesc from issuestatuslut) e
			on a.issstatus=e.statusid
		left outer join (select resid,resdesc from issueresolutionlut) f
			on a.issresolution=f.resid
		left outer join (select projid,projcode from projects) g
			on a.projid=g.projid
		left outer join (select userid,firstname + N' ' + surname as reporteddesc from users) h
			on a.reportedby=h.userid
		left outer join (select userid,firstname + N' ' + surname as assigneddesc from users) i
			on a.assignedto=i.userid
		left outer join (select verid,vernumber,vername,verdesc from versions) j
			on a.fixedinverid=j.verid
		left outer join (select riskid,riskdesc from issuerisklevellut) k
			on a.risklevel=k.riskid
 go


/* Project & Version attribute handling */
if exists(select name from sysobjects where name='projectattributes') drop table projectattributes
go
create table projectattributes
(
attributeid numeric(10,0) identity(1,1),
projid numeric(10,0) not null,
attributename nvarchar(100) not null,
attributevalue nvarchar(2000) not null default(N''),
attributeorder int not null default(0),
tstamp timestamp not null
)
go
create index ind_projectattributes_projid on projectattributes(projid)
create index ind_projectattributes_attributeid on projectattributes(attributeid)
go

if exists(select name from sysobjects where name='projectversionattributes') drop table projectversionattributes
go
create table projectversionattributes
(
attributeid numeric(10,0) identity(1,1),
projid numeric(10,0) not null,
attributename nvarchar(100) not null,
attributeorder int not null default(0),
defaultvalue nvarchar(2000) not null,
tstamp timestamp not null
)
go
create index ind_projectversionattributes_projid on projectversionattributes(projid)
create index ind_projectversionattributes_attributeid on projectversionattributes(attributeid)
go

if exists(select name from sysobjects where name='projectversionattributevalues') drop table projectversionattributevalues
go
create table projectversionattributevalues
(
attributevalueid numeric(10,0) identity(1,1),
attributeid numeric(10,0) not null,
projid numeric(10,0) not null,
verid numeric(10,0) not null,
attributevalue nvarchar(2000) not null default(N''),
tstamp timestamp not null
)
go
create index ind_projectversionattributevalues_projid on projectversionattributevalues(projid)
create index ind_projectversionattributevalues_verid on projectversionattributevalues(verid)
create index ind_projectversionattributevalues_attributeid on projectversionattributevalues(attributeid)
go

if exists(select name from sysobjects where name='userissuesview') drop table userissuesview
go
create table userissuesview
(
itemid numeric(10,0) identity(1,1),
userid numeric(10,0) not null,
projectid numeric(10,0) not null default(0),
issueattribute numeric(10,0) not null,
customfieldid numeric(10,0) not null default(0),
displayorder numeric(10,0) not null,
tstamp timestamp not null
)
go
create index ind_userissuesview_itemid on userissuesview(itemid)
create index ind_userissuesview_userid on userissuesview(userid)
create index ind_userissuesview_projectid_userid on userissuesview(userid,projectid)
go

/* Personal Filters -- multi-select support */
if exists(select name from sysobjects where name='personalfilters_before_upgrade') drop table personalfilters_before_upgrade
go
select * into personalfilters_before_upgrade from personalfilters
go

if exists(select name from sysobjects where name='personalfilters') drop table personalfilters
go
create table personalfilters
(
filterid numeric(10,0) identity(1,1),
filtername nvarchar(100) not null default (''),
userid numeric(10,0) not null default(0),
projid numeric(10,0) not null default(0),
components nvarchar(100) not null default(''),
versions nvarchar(100) not null default(''),
resources nvarchar(100) not null default (''),
issuetype nvarchar(100) not null default(''),
issuepriority nvarchar(100) not null default(''),
issuestatus nvarchar(100) not null default(''),
issueresolution nvarchar(100) not null default(''),
risklevel nvarchar(100) not null default(''),
keywords nvarchar(100) not null default (''),
excludeclosed bit not null default(0),
systemfilter numeric(10,0) not null default(0),
issueid nvarchar(100) not null default(0),
sortfield nvarchar(100) not null default (''),
sortdirection numeric(10,0) not null default(0),
reportedbyuser nvarchar(100) not null default (''),
createdafter nvarchar(100) not null default (''),
createdbefore nvarchar(100) not null default (''),
revisedafter nvarchar(100) not null default (''),
revisedbefore nvarchar(100) not null default (''),
created datetime not null default current_timestamp,
tstamp timestamp not null
)
go
create index ind_id on personalfilters(filterid)
create index ind_id2 on personalfilters(userid,projid)
go

insert into personalfilters 
(filtername,userid,projid,components,versions,resources,
issuetype,issuepriority,issuestatus,issueresolution,risklevel,
keywords,excludeclosed,systemfilter,issueid,
sortfield,sortdirection,created,
reportedbyuser,createdafter,createdbefore,revisedafter,revisedbefore)
select 
filtername,userid,projid,
cast(compid as nvarchar(100)) + '|' as components,
cast(fixedinverid as nvarchar(100)) + '|' as versions,
cast(assignedto as nvarchar(100)) + '|' as resources,
cast(isstype as nvarchar(100)) + '|' as issuetype,
cast(isspriority as nvarchar(100)) + '|' as issuepriority,
cast(issstatus as nvarchar(100)) + '|' as issuestatus,
cast(issresolution as nvarchar(100)) + '|' as issueresolution,
cast(risklevel as nvarchar(100)) + '|' as risklevel,
keywords,excludeclosed,systemfilter,issueid,
sortfield,sortdirection,created,
reportedbyuser,createdafter,createdbefore,revisedafter,revisedbefore
from personalfilters_before_upgrade
go

/* Time Tracking */
alter table timetracking add comment nvarchar(2000) not null default('')
go

/* Closing Comment */
alter table issuecomments add isclosing bit not null default(0)
go

/* This code handles bug GEM-407 */
declare @projid numeric(10,0)
declare MyCursor cursor FORWARD_ONLY for select projid from projects

open MyCursor
fetch next from MyCursor into @projid
 
while (@@fetch_status=0) 
begin

update issues set assignedto=0
	where assignedto>0 and projid=@projid and assignedto not in (select userid from projectresource where projid=@projid)

fetch next from MyCursor into @projid
end

close MyCursor
deallocate MyCursor
go




