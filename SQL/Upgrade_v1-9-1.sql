/* Projects */
alter table projects add projarchived nvarchar(1) not null default('N')
GO
alter table customfielddefs add lookupsortfield nvarchar(100) not null default ('')
GO

if exists(select name from sysobjects where name='projectrepository') drop table projectrepository
go

create table projectrepository
(
nodeid numeric(10,0) identity(1,1),
parentnodeid numeric(10,0),
projid numeric(10,0) not null,
nodetext nvarchar(100) not null,
navigateurl nvarchar(255) not null default(N''),
tooltip nvarchar(255) not null default(N''),
imageindex numeric(10,0) not null default(0),
ispostback bit not null default(0),
isfolder bit not null default(0),
sendparams nvarchar(255) not null default(''),
nodedata image,
contenttype nvarchar(100)
)
go

create index ind_projectrepository_nodeid on projectrepository(nodeid)
create index ind_projectrepository_parnetnodeid on projectrepository(parentnodeid)
create index ind_projectrepository_projid on projectrepository(projid)
go

