/*
This script will upgrade an EXISTING GEMINI database 
for Unicode support.

However, two columns int the following tables have to be converted
to the NTEXT data type via Enterprise Manager:

FIELD longdesc IN TABLE issues 
FIELD comment IN TABLE issuecomments
*/

if exists(select [name] from sysobjects where [name]='gemini_tmp_drop_constraint' and type='P')
	drop procedure gemini_tmp_drop_constraint 
go

create procedure gemini_tmp_drop_constraint 
@TableName varchar(100),
@ColName varchar(100)
as
begin

declare @sql nvarchar(4000)

select @sql='alter table '+@TableName+' drop constraint '+so.[name]
from sysobjects so join syscomments sc on sc.id=so.id join sysconstraints sc2 on sc.id=sc2.constid
join syscolumns sc3 on sc2.colid=sc3.colid and sc3.id=so.parent_obj
where so.type='D' and so.parent_obj=object_id(@TableName)  and sc3.[name]=@ColName

if @sql is not null 
exec(@sql)

end
go

/********************************************************/
/* data tables */
/********************************************************/

/* projects */
exec gemini_tmp_drop_constraint 'projects','projcode'
alter table projects alter column projcode nvarchar(10) not null
alter table projects add constraint projects_projcode default(N'') for projcode
exec gemini_tmp_drop_constraint 'projects','projname'
alter table projects alter column projname nvarchar(100) not null
alter table projects add constraint projects_projname default(N'') for projname
exec gemini_tmp_drop_constraint 'projects','projleader'
alter table projects alter column projleader nvarchar(100) not null
alter table projects add constraint projects_projleader default(N'') for projleader
exec gemini_tmp_drop_constraint 'projects','projdesc'
alter table projects alter column projdesc nvarchar(255) not null
alter table projects add constraint projects_projdesc default(N'') for projdesc
exec gemini_tmp_drop_constraint 'projects','projreadonly'
alter table projects alter column projreadonly nvarchar(1) not null
alter table projects add constraint projects_projreadonly default(N'N') for projreadonly

/* versions */
drop index versions.IND_VerNumber
exec gemini_tmp_drop_constraint 'versions','vernumber'
alter table versions alter column vernumber nvarchar(100) not null
alter table versions add constraint versions_vernumber default(N'') for vernumber
create index ind_vernumber on versions(vernumber)
exec gemini_tmp_drop_constraint 'versions','vername'
alter table versions alter column vername nvarchar(100) not null
alter table versions add constraint versions_vername default(N'') for vername
exec gemini_tmp_drop_constraint 'versions','verdesc'
alter table versions alter column verdesc nvarchar(255) not null
alter table versions add constraint versions_verdesc default(N'') for verdesc
 
/* components */
exec gemini_tmp_drop_constraint 'components','compname'
alter table components alter column compname nvarchar(100) not null
alter table components add constraint components_compname default(N'') for compname
exec gemini_tmp_drop_constraint 'components','compdesc'
alter table components alter column compdesc nvarchar(255) not null
alter table components add constraint components_compdesc default(N'') for compdesc

/* issues */
exec gemini_tmp_drop_constraint 'issues','summary'
alter table issues alter column summary nvarchar(255) not null
alter table issues add constraint issues_summary default(N'') for summary
exec gemini_tmp_drop_constraint 'issues','userdata1'
alter table issues alter column userdata1 nvarchar(255) not null
alter table issues add constraint issues_userdata1 default(N'') for userdata1
exec gemini_tmp_drop_constraint 'issues','userdata2'
alter table issues alter column userdata2 nvarchar(255) not null
alter table issues add constraint issues_userdata2 default(N'') for userdata2
exec gemini_tmp_drop_constraint 'issues','userdata3'
alter table issues alter column userdata3 nvarchar(255) not null
alter table issues add constraint issues_userdata3 default(N'') for userdata3
exec gemini_tmp_drop_constraint 'issues','percentcomplete'
alter table issues alter column percentcomplete nvarchar(10) not null
alter table issues add constraint issues_percentcomplete default(N'') for percentcomplete
exec gemini_tmp_drop_constraint 'issues','estimatedeffortdays'
alter table issues alter column estimatedeffortdays nvarchar(10) not null
alter table issues add constraint issues_estimatedeffortdays default(N'') for estimatedeffortdays
exec gemini_tmp_drop_constraint 'issues','estimatedefforthours'
alter table issues alter column estimatedefforthours nvarchar(10) not null
alter table issues add constraint issues_estimatedefforthours default(N'') for estimatedefforthours
exec gemini_tmp_drop_constraint 'issuecomments','username'
alter table issuecomments alter column username nvarchar(255) not null
alter table issuecomments add constraint issuecomments_username default(N'') for username
exec gemini_tmp_drop_constraint 'issuehistory','history'
alter table issuehistory alter column history nvarchar(255) not null
alter table issuehistory add constraint issuehistory_history default(N'') for history
exec gemini_tmp_drop_constraint 'issuehistory','username'
alter table issuehistory alter column username nvarchar(255) not null
alter table issuehistory add constraint issuehistory_username default(N'') for username
exec gemini_tmp_drop_constraint 'issueattachments','contenttype'
alter table issueattachments alter column contenttype nvarchar(200) not null
alter table issueattachments add constraint issueattachments_contenttype default(N'') for contenttype
exec gemini_tmp_drop_constraint 'issueattachments','thefilename'
alter table issueattachments alter column thefilename nvarchar(200) not null
alter table issueattachments add constraint issueattachments_thefilename default(N'') for thefilename
drop index users.IND_UserName
exec gemini_tmp_drop_constraint 'users','username'
alter table users alter column username nvarchar(255) not null
alter table users add constraint users_username default(N'') for username
exec gemini_tmp_drop_constraint 'users','firstname'
alter table users alter column firstname nvarchar(255) not null
alter table users add constraint users_firstname default(N'') for firstname
exec gemini_tmp_drop_constraint 'users','surname'
alter table users alter column surname nvarchar(255) not null
alter table users add constraint users_surname default(N'') for surname
exec gemini_tmp_drop_constraint 'users','emailaddress'
alter table users alter column emailaddress nvarchar(255) not null
alter table users add constraint users_emailaddress default(N'') for emailaddress
exec gemini_tmp_drop_constraint 'users','roles'
alter table users alter column roles nvarchar(255) not null
alter table users add constraint users_roles default(N'') for roles
create index ind_username on users(username)

/* userroles */
exec gemini_tmp_drop_constraint 'userroles','roles'
alter table userroles alter column roles nvarchar(255) not null
alter table userroles add constraint userroles_roles default(N'') for roles
 
/* usersettings */
exec gemini_tmp_drop_constraint 'usersettings','sname'
alter table usersettings alter column sname nvarchar(50) not null
alter table usersettings add constraint usersettings_sname default(N'') for sname
exec gemini_tmp_drop_constraint 'usersettings','svalue'
alter table usersettings alter column svalue nvarchar(50) not null
alter table usersettings add constraint usersettings_svalue default(N'') for svalue

/* issue alerts */
exec gemini_tmp_drop_constraint 'issuealerts','alertcode'
alter table issuealerts alter column alertcode nvarchar(10) not null
alter table issuealerts add constraint issuealerts_alertcode default(N'') for alertcode

/* Issue Link Types */
exec gemini_tmp_drop_constraint 'issuelinktypes','linkname'
alter table issuelinktypes alter column linkname nvarchar(255) not null
alter table issuelinktypes add constraint issuelinktypes_linkname default(N'') for linkname
exec gemini_tmp_drop_constraint 'issuelinktypes','linkdesc'
alter table issuelinktypes alter column linkdesc nvarchar(255) not null
alter table issuelinktypes add constraint issuelinktypes_linkdesc default(N'') for linkdesc

/* Issue Links */
exec gemini_tmp_drop_constraint 'issuelinks','linkdirection'
alter table issuelinks alter column linkdirection nvarchar(10) not null
alter table issuelinks add constraint issuelinks_linkdirection default(N'O') for linkdirection

/********************************************************/
/* lookup tables */
/********************************************************/

/* issue types */
drop index issuetypelut.IND_Desc
alter table issuetypelut alter column typedesc nvarchar(100) not null
alter table issuetypelut alter column imagepath nvarchar(100) not null
create index ind_desc on issuetypelut(typedesc)

/* issue priority */
drop index issueprioritylut.IND_Desc
alter table issueprioritylut alter column prioritydesc nvarchar(100) not null
alter table issueprioritylut alter column imagepath nvarchar(100) not null
create index ind_desc on issueprioritylut(prioritydesc)

/* issue status */
drop index issuestatuslut.IND_Desc
alter table issuestatuslut alter column statusdesc nvarchar(100) not null
create index ind_desc on issuestatuslut(statusdesc)

/* issue resolution */
drop index issueresolutionlut.ind_desc
alter table issueresolutionlut alter column resdesc nvarchar(100) not null
create index ind_desc on issueresolutionlut(resdesc)

/* issue risk level */
drop index issuerisklevellut.ind_desc
alter table issuerisklevellut alter column riskdesc nvarchar(100) not null
alter table issuerisklevellut alter column imagepath nvarchar(100) not null
create index ind_desc on issuerisklevellut(riskdesc)

/*****************************************************/
/* Custom Field Definitions */
/*****************************************************/

alter table customfielddefs alter column customfieldname nvarchar(100) not null
exec gemini_tmp_drop_constraint 'customfielddefs','screenlabel'
alter table customfielddefs alter column screenlabel nvarchar(100) not null
alter table customfielddefs add constraint customfielddefs_screenlabel default(N'') for screenlabel
exec gemini_tmp_drop_constraint 'customfielddefs','screendescription'
alter table customfielddefs alter column screendescription nvarchar(1910) not null
alter table customfielddefs add constraint customfielddefs_screendescription default(N'') for screendescription
exec gemini_tmp_drop_constraint 'customfielddefs','screentooltip'
alter table customfielddefs alter column screentooltip nvarchar(100) not null
alter table customfielddefs add constraint customfielddefs_screentooltip default(N'') for screentooltip
exec gemini_tmp_drop_constraint 'customfielddefs','regularexp'
alter table customfielddefs alter column regularexp nvarchar(500) not null
alter table customfielddefs add constraint customfielddefs_regularexp default(N'') for regularexp
exec gemini_tmp_drop_constraint 'customfielddefs','customfieldtype'
alter table customfielddefs alter column customfieldtype nvarchar(1) not null
alter table customfielddefs add constraint customfielddefs_customfieldtype default(N'T') for customfieldtype
exec gemini_tmp_drop_constraint 'customfielddefs','defaultvalue'
alter table customfielddefs alter column defaultvalue nvarchar(500) not null
alter table customfielddefs add constraint customfielddefs_defaultvalue default(N'') for defaultvalue
exec gemini_tmp_drop_constraint 'customfielddefs','lookupname'
alter table customfielddefs alter column lookupname nvarchar(255) not null
alter table customfielddefs add constraint customfielddefs_lookupname default(N'') for lookupname
exec gemini_tmp_drop_constraint 'customfielddefs','lookupvaluefield'
alter table customfielddefs alter column lookupvaluefield nvarchar(255) not null
alter table customfielddefs add constraint customfielddefs_lookupvaluefield default(N'') for lookupvaluefield
exec gemini_tmp_drop_constraint 'customfielddefs','lookuptextfield'
alter table customfielddefs alter column lookuptextfield nvarchar(255) not null
alter table customfielddefs add constraint customfielddefs_lookuptextfield default(N'') for lookuptextfield

/*****************************************************/
/* Saved Custom Fields */
/*****************************************************/

exec gemini_tmp_drop_constraint 'customfielddata','fielddata'
alter table customfielddata alter column fielddata nvarchar(3990) not null
alter table customfielddata add constraint customfielddata_fielddata default(N'') for fielddata
go

/*****************************************************/
/* Personal Issue Filters */
/*****************************************************/

exec gemini_tmp_drop_constraint 'personalfilters','filtername'
alter table personalfilters alter column filtername nvarchar(100) not null
alter table personalfilters add constraint personalfilters_filtername default(N'') for filtername
exec gemini_tmp_drop_constraint 'personalfilters','keywords'
alter table personalfilters alter column keywords nvarchar(100) not null
alter table personalfilters add constraint personalfilters_keywords default(N'') for keywords
exec gemini_tmp_drop_constraint 'personalfilters','issueid'
alter table personalfilters alter column issueid nvarchar(100) not null
alter table personalfilters add constraint personalfilters_issueid default(0) for issueid
exec gemini_tmp_drop_constraint 'personalfilters','sortfield'
alter table personalfilters alter column sortfield nvarchar(100) not null
alter table personalfilters add constraint personalfilters_sortfield default(N'') for sortfield

/* securityschemes */
exec gemini_tmp_drop_constraint 'securityschemes','schemename'
alter table securityschemes alter column schemename nvarchar(255) not null
alter table securityschemes add constraint securityschemes_schemename default(N'') for schemename
exec gemini_tmp_drop_constraint 'securityschemes','roles'
alter table securityschemes alter column roles nvarchar(255) not null
alter table securityschemes add constraint securityschemes_roles default(N'') for roles

drop index geminiinstall.ind_attribute_key
alter table geminiinstall alter column attribute_key nvarchar(100) 
alter table geminiinstall alter column attribute_value nvarchar(1000) 
create index ind_attribute_key on geminiinstall(attribute_key)
go

if exists(select [name] from sysobjects where [name]='gemini_tmp_drop_constraint' and type='P')
	drop procedure gemini_tmp_drop_constraint 
go
