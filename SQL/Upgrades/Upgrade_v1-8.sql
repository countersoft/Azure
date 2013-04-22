truncate table geminiinstall
insert into geminiinstall (attribute_key,attribute_value) values (N'VERSION',N'1.8')

/****************************************************
Version enhancements
*****************************************************/
alter table versions add verorder integer not null default (0)
alter table versions add verarchived bit not null default (0)
go

declare @projid numeric(10,0)
declare @verid numeric(10,0)
declare @counter numeric(10,0)
set @counter = 1

declare MyCursor cursor FORWARD_ONLY for select projid,verid from versions order by projid,verid

open MyCursor
fetch next from MyCursor into @projid,@verid
 
while (@@fetch_status=0) 
begin
update versions set verorder=@counter where verid=@verid
set @counter = @counter + 1
fetch next from MyCursor into @projid,@verid
end

close MyCursor
deallocate MyCursor
go

/****************************************************
Security Schemes
*****************************************************/
if exists(select name from sysobjects where name='securityschemes') drop table securityschemes

create table securityschemes
(
schemeid numeric(10,0) identity(1,1),
schemename nvarchar(255) not null default(''),
roles varchar(255) not null default(''),
canviewproject bit not null default 0,
created datetime not null default current_timestamp
)
create index ind_schemeid on securityschemes(schemeid)

-- Add default security schemes
insert into securityschemes (schemename,roles,canviewproject)
	values (N'Project Administration','P!V!',1)
insert into securityschemes (schemename,roles,canviewproject)
	values (N'Issue Administration','I!V!',1)
insert into securityschemes (schemename,roles,canviewproject)
	values (N'Issue Worker','C!L!W!M!U!A!V!',1)
insert into securityschemes (schemename,roles,canviewproject)
	values (N'Issue Creator','C!M!V!',1)
insert into securityschemes (schemename,roles,canviewproject)
	values (N'Viewer','V!',1)
insert into securityschemes (schemename,roles,canviewproject)
	values (N'No Access','',0)
go

truncate table userroles
go
alter table userroles add schemeid numeric(10,0) not null default (0)
go

alter table projects add schemeid numeric(10,0) not null default (0)
go

drop procedure gemini_getuserbyname
go

/****************************************************
Filter enhancements
*****************************************************/
alter table personalfilters add reportedbyuser nvarchar(100) not null default ('')
alter table personalfilters add createdafter nvarchar(100) not null default ('')
alter table personalfilters add createdbefore nvarchar(100) not null default ('')
alter table personalfilters add revisedafter nvarchar(100) not null default ('')
alter table personalfilters add revisedbefore nvarchar(100) not null default ('')
go

/****************************************************
UNICODE support

PLEASE USE THE SCRIPT UNICODEUPGRADE.SQL
*****************************************************/
