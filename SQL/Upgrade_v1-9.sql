print 'COUNTERSOFT: Gemini v1.9 Database Upgrade Script **'
print 'COUNTERSOFT: Ignore this error message: Column names in each table must be unique.'

truncate table geminiinstall
insert into geminiinstall (attribute_key,attribute_value) values (N'VERSION',N'1.9')

/*************************************************************
* Issue status & resolution value changes
*************************************************************/
update issues set issstatus=1 where issstatus=6
update issues set issresolution=99 where issresolution=1
update issues set issresolution=1 where issresolution=4
update issues set issresolution=4 where issresolution=5
update issues set issresolution=5 where issresolution=99
go

if exists(select name from sysobjects where name='gemini_getlut_2') drop procedure gemini_getlut_2
if exists(select name from sysobjects where name='gemini_moveversiondown') drop procedure gemini_moveversiondown
if exists(select name from sysobjects where name='gemini_moveversionup') drop procedure gemini_moveversionup
go

/*drop procedure gemini_getlut_2
drop procedure gemini_moveversiondown
drop procedure gemini_moveversionup
go*/

if exists(select name from sysobjects where name='issuestatuslut') drop table issuestatuslut
if exists(select name from sysobjects where name='issuestatetransitionlut') drop table issuestatetransitionlut 
if exists(select name from sysobjects where name='issueresolutionlut') drop table issueresolutionlut
if exists(select name from sysobjects where name='issuetypelut') drop table issuetypelut
if exists(select name from sysobjects where name='issueprioritylut') drop table issueprioritylut
if exists(select name from sysobjects where name='issuerisklevellut') drop table issuerisklevellut
go

/* issue status */
create table issuestatuslut
(
statusid numeric(10,0) identity(1,1),
seq numeric(10,0) not null default(0),
isfinal bit not null default(0),
statusdesc nvarchar(100) not null,
statustype int not null default(0)
)
create index ind_id on issuestatuslut(statusid)
create index ind_desc on issuestatuslut(statusdesc)
create index ind_seq on issuestatuslut(seq)

insert into issuestatuslut (seq,isfinal,statusdesc) values (1,0,N'Unassigned')
insert into issuestatuslut (seq,isfinal,statusdesc,statustype) values (2,0,N'Assigned',1)
insert into issuestatuslut (seq,isfinal,statusdesc) values (3,0,N'In Progress')
insert into issuestatuslut (seq,isfinal,statusdesc) values (4,1,N'Closed')
insert into issuestatuslut (seq,isfinal,statusdesc) values (5,0,N'Reopened')

/* issue state transition */
create table issuestatetransitionlut
(
statusid numeric(10,0) not null,
otherstate numeric(10,0) not null default(0),
statetype int not null default(0) -- 0: PRE STATE 1: POST STATE
)
create index ind_id on issuestatetransitionlut(statusid)
create index ind_type on issuestatetransitionlut(statetype)

-- PRE STATES
insert into issuestatetransitionlut values (2,1,0)
insert into issuestatetransitionlut values (3,1,0)
insert into issuestatetransitionlut values (3,2,0)
insert into issuestatetransitionlut values (4,3,0)
insert into issuestatetransitionlut values (4,5,0)
-- POST STATES
insert into issuestatetransitionlut values (1,2,1)
insert into issuestatetransitionlut values (1,3,1)
insert into issuestatetransitionlut values (2,3,1)
insert into issuestatetransitionlut values (2,4,1)
insert into issuestatetransitionlut values (3,4,1)
insert into issuestatetransitionlut values (5,3,1)
insert into issuestatetransitionlut values (5,4,1)

/* issue resolution */
create table issueresolutionlut
(
resid numeric(10,0) identity(1,1),
seq numeric(10,0) not null default(0),
isfinal bit not null default(0),
resdesc nvarchar(100) not null
)
create index ind_id on issueresolutionlut(resid)
create index ind_seq on issueresolutionlut(seq)

insert into issueresolutionlut (seq,isfinal,resdesc) values (1,0,N'Unresolved')
insert into issueresolutionlut (seq,isfinal,resdesc) values (2,1,N'Won''t Fix')
insert into issueresolutionlut (seq,isfinal,resdesc) values (3,1,N'Duplicate')
insert into issueresolutionlut (seq,isfinal,resdesc) values (4,0,N'Cannot Reproduce')
insert into issueresolutionlut (seq,isfinal,resdesc) values (5,1,N'Complete')

/* issue risk level */
create table issuerisklevellut
(
rowid numeric(10,0) identity(1,1),
seq numeric(10,0) not null default(0),
riskid numeric(10,0) not null,
riskdesc nvarchar(100) not null,
imagepath nvarchar(100) not null
)
create index ind_id on issuerisklevellut(riskid)
create index ind_desc on issuerisklevellut(riskdesc)

insert into issuerisklevellut (seq,riskid,riskdesc,imagepath) values (1,1,N'No Risk',N'')
insert into issuerisklevellut (seq,riskid,riskdesc,imagepath) values (2,2,N'Low',N'')
insert into issuerisklevellut (seq,riskid,riskdesc,imagepath) values (3,3,N'Medium',N'')
insert into issuerisklevellut (seq,riskid,riskdesc,imagepath) values (4,4,N'High',N'')

/* issue types */
create table issuetypelut
(
rowid numeric(10,0) identity(1,1),
seq numeric(10,0) not null default(0),
typeid numeric(10,0) not null,
typedesc nvarchar(100) not null,
imagepath nvarchar(100) not null
)
create index ind_id on issuetypelut(typeid)
create index ind_desc on issuetypelut(typedesc)

insert into issuetypelut (seq,typeid,typedesc,imagepath) values (4,1,N'Bug',N'images/Type_Bug.jpg')
insert into issuetypelut (seq,typeid,typedesc,imagepath) values (2,2,N'Enhancement',N'images/Type_Enhancement.jpg')
insert into issuetypelut (seq,typeid,typedesc,imagepath) values (1,3,N'New Feature',N'images/Type_NewFeature.jpg')
insert into issuetypelut (seq,typeid,typedesc,imagepath) values (3,4,N'Task',N'images/Type_Task.jpg')

/* issue priority */
create table issueprioritylut
(
rowid numeric(10,0) identity(1,1),
seq numeric(10,0) not null default(0),
priorityid numeric(10,0) not null,
prioritydesc nvarchar(100) not null,
imagepath nvarchar(100) not null
)
create index ind_id on issueprioritylut(priorityid)
create index ind_desc on issueprioritylut(prioritydesc)

insert into issueprioritylut (seq,priorityid,prioritydesc,imagepath) values (1,1,N'Trivial',N'images/Priority_Trivial.gif')
insert into issueprioritylut (seq,priorityid,prioritydesc,imagepath) values (2,2,N'Minor',N'images/Priority_Minor.gif')
insert into issueprioritylut (seq,priorityid,prioritydesc,imagepath) values (3,3,N'Major',N'images/Priority_Major.gif')
insert into issueprioritylut (seq,priorityid,prioritydesc,imagepath) values (4,4,N'Show Stopper',N'images/Priority_ShowStopper.gif')
go

/* Public/Private issues */
alter table issues add isprivate bit not null default (0)
alter table issuecomments add isprivate bit not null default (0)
go

/* Source Control */
if exists(select name from sysobjects where name='sourcecontrolissuefiles') drop table sourcecontrolissuefiles
go

create table sourcecontrolissuefiles
(
fileid numeric(10,0) identity(1,1),
issueid numeric(10,0) not null,
filename nvarchar(255) not null,
filepath nvarchar(255) not null,
sourcecontrolrepository nvarchar(255) not null default('')
)
go

create index ind_issueid on sourcecontrolissuefiles(issueid)
go

/* Issue comments */
alter table issuecomments add userid numeric(10,0) not null default(0)
go

/* Firefox compatibility fixes */
update issueprioritylut set imagepath=replace(imagepath,'\','/')
update issuetypelut set imagepath=replace(imagepath,'\','/')
go

/* Time Tracking */
if exists(select name from sysobjects where name='timetracking') drop table timetracking
go

create table timetracking
(
entryid numeric(10,0) identity(1,1),
projid numeric(10,0) not null,
issueid numeric(10,0) not null,
userid numeric(10,0) not null,
hours numeric(10,0) not null default(0),
minutes numeric(10,0) not null default(0),
timeentrydate datetime not null,
created datetime not null default current_timestamp
)
create index ind_entryid on timetracking(entryid)
create index ind_projid on timetracking(projid)
create index ind_issueid on timetracking(issueid)
go

alter table issues add estimatedays numeric(10,0) not null default(0)
alter table issues add estimatehours numeric(10,0) not null default(0)
alter table issues add estimateminutes numeric(10,0) not null default(0)
go

update issues set estimatedays=cast(estimatedeffortdays as numeric(10,0)) where isnumeric(estimatedeffortdays)=1
update issues set estimatehours=cast(estimatedefforthours as numeric(10,0)) where isnumeric(estimatedefforthours)=1
go

/* Views */
if exists(select name from sysobjects where name='issuesview') drop view issuesview
if exists(select name from sysobjects where name='issuestatusfinal') drop view issuestatusfinal
if exists(select name from sysobjects where name='issueresolutionfinal') drop view issueresolutionfinal
go

create view issuesview as
	select 
	a.issueid,
	isnull(b.compname,N'') as compname,
	isnull(c.typedesc,N'') as typedesc,
	isnull(d.prioritydesc,N'') as prioritydesc,
	isnull(e.statusdesc,N'') as statusdesc,
	isnull(f.resdesc,N'') as resdesc,
	isnull(g.projcode,N'') as projcode,
	isnull(h.reporteddesc,N'') as reporteddesc,
	isnull(i.assigneddesc,N'') as assigneddesc,
	isnull(j.verdesc,N'') as verdesc,
	a.projid,a.compid,a.fixedinverid,a.assignedto,a.reportedby,
	a.summary,a.longdesc,a.isstype,a.isspriority,a.issstatus,
	a.issresolution,a.created,a.revised,projcode+N'-'+cast(a.issueid as nvarchar(10)) as issuekey,
	a.startdate,a.duedate,
	a.risklevel,a.userdata1,a.userdata2,a.userdata3,a.percentcomplete,
	a.estimatedays,a.estimatehours,a.estimateminutes,
	isnull(k.riskdesc,N'') as riskdesc,
	a.isprivate
	from issues a
		left outer join (select compid,compname from components) b
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
		left outer join (select verid,vernumber as verdesc from versions) j
			on a.fixedinverid=j.verid
		left outer join (select riskid,riskdesc from issuerisklevellut) k
			on a.risklevel=k.riskid
 go

create view issuestatusfinal as
	select statusid,statusdesc from issuestatuslut where isfinal=1
 go

create view issueresolutionfinal as
	select resid,resdesc from issueresolutionlut where isfinal=1
 go
