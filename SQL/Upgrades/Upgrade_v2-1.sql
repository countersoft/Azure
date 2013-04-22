--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 2.1.x UPGRADE SCRIPT
--
--*********************************************************************************
--*********************************************************************************
TRUNCATE TABLE geminiinstall
INSERT INTO geminiinstall (attribute_key,attribute_value) VALUES (N'VERSION',N'2.1')
GO

/* Issues - Add resolved and closed dates */
ALTER TABLE issues ADD	resolveddate DATETIME, closeddate DATETIME
GO

/* Project Resource - Add ID */
ALTER TABLE projectresource ADD	rowid NUMERIC(10, 0) NOT NULL IDENTITY (1, 1)
GO

ALTER TABLE issuestatetransitionlut ADD	rowid NUMERIC(10, 0) NOT NULL IDENTITY (1, 1)
GO

/* issue votes */
IF EXISTS(SELECT name FROM sysobjects WHERE name='issuevotes') DROP TABLE issuevotes
GO

/* issue votes */

CREATE TABLE issuevotes
(
voteid NUMERIC(10,0) IDENTITY(1,1),
issueid NUMERIC(10,0) NOT NULL,
userid NUMERIC(10,0) NOT NULL,
created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
tstamp TIMESTAMP NOT NULL
)
GO

create unique index ind_issuevoteissueuser on issuevotes(issueid,userid)
GO

/* App Settings */
IF EXISTS(SELECT name FROM sysobjects WHERE name='geminiappsettings')
	DROP TABLE geminiappsettings
GO

CREATE TABLE geminiappsettings
(
	settingid INT NOT NULL IDENTITY(1,1),
	settingname NVARCHAR(200) NOT NULL,
	settingcategory NVARCHAR(200) NOT NULL,
	settingvalue NVARCHAR(3000) NOT NULL,
	settingdesc NVARCHAR(600) NOT NULL,
	tstamp TIMESTAMP NOT NULL 
)
GO


INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('OrganisationName','Licensing','', 'The name of the company')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('RegistrationCode','Licensing','', 'The license key')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
VALUES('AlwaysUseFullGeminiURL','General','NO', 'Set this to NO if do not want the full gemini url to be enforced')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('FullGeminiURL','General','http://localhost/gemini/', 'The url to the gemini installation (requires the trailing ''/'')')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('GeminiAdmins','General','admin@abc.com', 'The email address of the gemini admin')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('WelcomeTitle','General','Welcome', 'The welcome title, which will be displayed in the main page')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('WelcomeMessage','General','Customise this message via the admin app setting page.', 'The welcome message which will be displayed in the main page')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('DictionaryFolder','General','controls/FreeTextBox/dic', 'The path to the FreeTextBox spell checker')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('ProjReposFileClick','General','None', 'Default Project Repository File Click Behaviour (None or View)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('EnableHTMLPosts','General','YES', 'Controls if HTML tags can be entered into text boxes')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('CharSetForExcel','General','ISO-8859-1', 'The character set used when exporting issues to Excel')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SessionRefresher','General','600', 'Make a never expired session (refresh in seconds)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('Theme','General','Default', 'Default application theme')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('LayoutMode','Language','', 'The way to render HTML (ltr,rtl or leave blank)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('LanguageFilePath','Language','Language', 'The the relative path to the language files')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('DefaultCultureName','Language','en-GB', 'The the language file to use as default')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('InstalledLanguages','General','English|en-GB|German|de-DE|Spanish|es-ES|Italian|it-IT|French|de-FR|Japanese|ja-JP|Portuguese|pt-PT|Chinese|zh-CHS|Russian|ru-RU', 'Installed languages')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('InstalledThemes','General','Default|Blue|Army', 'Installed themes')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('DateFormat','Language','EU', 'The way we enter dates (EU or US)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('TimeInWorkingDay','Issue','7:30', 'The time in a working day (HH:MM)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('GlobalAssignResourceAtIssueCreation','Issue','NO', 'Controls if ALL USERS can assign resource to an issue during issue creation')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('IssueDescriptionType','Issue','RichText', 'The type of input box to use for issue description (Text, FreeTextBox or RichText)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('IssueCommentType','Issue','RichText', 'The type of input box to use for issue comment (Text, FreeTextBox or RichText)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('IssueLinkQualifier','Issue','GEM:', 'Any issue id with this qualified found will automatically link to the issue')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('AutoAlertForIssueCreator','Alerts','NO', 'Controls if the user creating an issue is automatically an ISSUE WATCHER (get issue alerts)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('AutoAlertForIssueResource','Alerts','NO', 'Controls if the user working on an issue is automatically an ISSUE WATCHER (get issue alerts)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('PluginPath','Alerts','bin/plugins', 'The path to plugin directory under bin folder (required)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('ShowUserRegistrationLink','Security','YES', 'Controls whether the logon page displays a link that would allow anyone to register as a member')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('AllowAnonymousUsers','Security','YES', 'Controls if anonymous users can access Gemini (e.g. no logon required)')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('ViewAllProjects','Security','YES', 'Are all projects visible to everyone?')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('AlwaysShowGeminiStats','Security','YES', 'Controls if the Gemini statistics panel is always shown on the main page. This panel is visible if the user is admin or ViewAllProjects is YES.')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('ResetPasswordSubject','Security','Gemini Password Reset Request', 'The email subject line used for sending password reset requests')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('ResetPasswordMessage','Security','Please click on the link below to reset your Gemini password.', 'The email message used for sending password reset requests')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('NewUserResetPassword','Security','BLANK', 'When creating a new user, you can send a reset password request:
			- AUTO      = Will always send reset password.
			- BLANK     = Will send a reset password only if password is blank.
			- NEVER     = Will not send a reset password.')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SSOPasswordType','Security','PLAIN', 'Single Sign On [method of passing user credentials (SSO.aspx)]
				- DBHASHED= This is taking the actual password as it is on the DB (converted to base 64 string) and hash it with a key that is in the web.config (SSOKey). 
				- DB      =	This is taking the actual password as it is on the DB (converted to base 64 string). 
				- HASHED  = This is taking the clear text password and hash it with a key that is in the web.config (SSOKey, see below). 
				- PLAIN   = This is just sending the password as clear text. ')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SSOKey','Security','', 'This key will be used to decrypt the passowrd to the SSO.aspx page')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('WebServicesAccessCode','Security','ABC123', 'This code will be checked against when a non WSE web service is called')
GO

INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('UseAccessCodeForSourceControl','Security','NO', 'Should we authenticate access to the AddSCFile.aspx?')
GO

ALTER TABLE personalfilters ADD projids NVARCHAR(100) NOT NULL DEFAULT('')
GO
UPDATE personalfilters SET projids = CAST(projid as NVARCHAR(100))
GO

/*************************************************************
* Creates the initial root for a project.
* used on project repository home page.
*************************************************************/

if exists(select name from sysobjects where name='gemini_projreposcreateinitialroot') 
	drop procedure gemini_projreposcreateinitialroot
go

create procedure gemini_projreposcreateinitialroot
	@projid numeric(10,0)
as
begin

declare @projcode nvarchar(20)

select @projcode=projcode from projects where projid=@projid

insert into projectrepository(parentnodeid, projid, nodetext, navigateurl, tooltip, ispostback, isfolder, sendparams, imageindex,nodedata)
values(NULL,@projid,@projcode,@projcode,'Project Root Folder',1,1,'Project Root Folder',0,NULL)

end
go


/*************************************************************
* get lut entries.
* used on issues page.
*************************************************************/
if exists(select name from sysobjects where name='gemini_getlutentries') 
	drop procedure gemini_getlutentries
 go

create procedure gemini_getlutentries
	@projid numeric(10,0)
as
begin

/* issue types */
select 0 as seq,0 as typeid,N'Any' as typedesc, 0 as tstamp
union all
select seq,typeid,typedesc, tstamp from issuetypelut order by seq

/* issue priorities */
select 0 as seq,0 as priorityid,N'Any' as prioritydesc, 0 as tstamp
union all
select seq,priorityid,prioritydesc, tstamp from issueprioritylut order by seq

/* issue status */
select 0 as seq,0 as statusid,N'Any' as statusdesc, 0 as tstamp
union all
select seq,statusid,statusdesc, tstamp from issuestatuslut order by seq

/* issue resolution */
select 0 as seq,0 as resid,N'Any' as resdesc, 0 as tstamp
union all
select seq,resid,resdesc, tstamp from issueresolutionlut order by seq

/* project components */
select 0 as compid,N'Any' as compname, N'' as comporder, 0 as tstamp
union all
select compid,compname,compname as comporder, tstamp from components where projid=@projid order by comporder

/* project versions */
select -1 as verid,-2 as verorder,N'Any' as vername, 0 as tstamp
union all
select 0 as verid,-1 as verorder,N'Unscheduled' as vername, 0 as tstamp
union all
select verid,verorder,vername, tstamp from versions where projid=@projid and verarchived=0 order by verorder

/* project resources */
select -1 as userid,N'Any' as username, 0 as tstamp, '' as ord
union all
select 0 as userid,N'Unassigned' as username, 0 as tstamp, '' as ord
union all
select distinct a.userid,b.firstname + N' ' + b.surname as username, b.tstamp, b.firstname + N' ' + b.surname as ord
	from projectresource a, users b
	where (a.projid=@projid or @projid = -2) and b.userid=a.userid
	order by ord

/* issue risk level */
select 0 as seq,0 as riskid,N'Any' as riskdesc, 0 as tstamp
union all
select seq,riskid,riskdesc, tstamp from issuerisklevellut order by seq

end
 go
 
 /*************************************************************
* get luts for when creating new issues.
*************************************************************/
if exists(select name from sysobjects where name='gemini_getlut_1') 
	drop procedure gemini_getlut_1
 go

create procedure gemini_getlut_1
	@projid numeric(10,0)
as
begin

/* project components */
select compid,compname,tstamp from components where projid=@projid and compreadonly='N'
	order by compname

/* issue types */
select typeid,typedesc, tstamp from issuetypelut order by seq

/* issue priorities */
select priorityid,prioritydesc, tstamp from issueprioritylut order by seq

/* project resources (active only) */
select 0 as userid,N'!!2Nobody' as username, 0 as tstamp
union all
select a.userid, b.firstname + N' ' + b.surname as username, a.tstamp from projectresource a, users b
	where a.projid=@projid and b.userid=a.userid and a.isactive = 'y'
	--order by b.username
    order by username

/* future versions */
select 0 as verid,-1 as verorder,N'None2' as vername, 0 as tstamp
union all
select verid,verorder,vername, tstamp from versions where projid=@projid and verarchived=0 and verreleased=N'N' order by verorder

/* risk */
select seq,riskid,riskdesc, tstamp from issuerisklevellut order by seq
end
 go

/*************************************************************
* get luts for when updating existing issues.
*************************************************************/
if exists(select name from sysobjects where name='gemini_getissueupdatedata') 
	drop procedure gemini_getissueupdatedata
 go

create procedure gemini_getissueupdatedata
	@projid numeric(10,0),
	@issueid numeric(10,0)
as
begin

declare @currentstatusid numeric(10,0)

/* project components */
select compid,compname,tstamp from components where projid=@projid and compreadonly='N'
	order by compname

/* future versions */
select 0 as verid,-1 as verorder,N'None2' as vername, 0 as tstamp
union all
select verid,verorder,vername, tstamp from versions where projid=@projid 
and verarchived=0 order by verorder

/* project resources (active only) */
select 0 as userid,N'!!2Nobody' as username, 0 as tstamp
union all
select a.userid,b.firstname + N' ' + b.surname as username, a.tstamp from projectresource a, users b
	where a.projid=@projid and b.userid=a.userid and a.isactive = 'y'
	--order by b.username
	order by username

/* issue types */
select typeid,typedesc, tstamp from issuetypelut order by seq

/* issue priority */
select priorityid,prioritydesc, tstamp from issueprioritylut order by seq

/* issue status */
select @currentstatusid=issstatus from issues where issueid=@issueid
exec gemini_getvalidissuestatusvalues @currentstatusid

/* issue resolution */
select resid,resdesc, tstamp from issueresolutionlut order by seq

/* issue risk level */
select riskid,riskdesc, tstamp from issuerisklevellut order by seq

end
 go

/*************************************************************
* get project repository information for the tree view.
* used on project repository home page.
*************************************************************/

if exists(select name from sysobjects where name='gemini_getallprojectrepositoryfortree') 
	drop procedure gemini_getallprojectrepositoryfortree
go

create procedure gemini_getallprojectrepositoryfortree
	@projid numeric(10,0)
as
select nodeid,parentnodeid,projid,nodetext,navigateurl,tooltip,imageindex,ispostback,isfolder,sendparams, tstamp from projectrepository where projid=@projid order by parentnodeid,isfolder desc,nodetext
go


if exists(select name from sysobjects where name='issuestatusunassigned' and type='V')
	drop view issuestatusunassigned
go

create view issuestatusunassigned as
	select statusid,statusdesc from issuestatuslut where statusid=1
go

if exists(select name from sysobjects where name='issuesview' and type='V')
	drop view issuesview
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
	a.tstamp,
	isnull(j.verorder,0) as verorder,
	isnull(j.verarchived,0) as verarchived,
	isnull(j.verreleased,N'') as verreleased,
	a.resolveddate, a.closeddate,
	(select count(*) from issuevotes v where v.issueid=a.issueid) as issuevotes,
	d.seq as priorityseq
	from issues a
		left outer join (select compid,compname,compdesc from components) b
			on a.compid=b.compid
		left outer join (select typeid,typedesc from issuetypelut) c
			on a.isstype=c.typeid
		left outer join (select priorityid,prioritydesc,seq from issueprioritylut) d
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
		left outer join (select verid,vernumber,vername,verdesc,verorder,verarchived,verreleased from versions) j
			on a.fixedinverid=j.verid
		left outer join (select riskid,riskdesc from issuerisklevellut) k
			on a.risklevel=k.riskid
 go

if exists(select name from sysobjects where name='gemini_getprojectsummary') 
	drop procedure gemini_getprojectsummary
go

create procedure gemini_getprojectsummary
	@projid numeric(10,0),
	@canviewprivate bit
as
begin

/* project details */
select projid,projcode,projname,projleader,projdesc,projreadonly,projarchived,created from projects where projid=@projid

/* components (number of open issues) */
select a.compid,a.compname,isnull(b.issuecount, 0) as issuecount from components a 
left outer join 
(select compid, count(*) as issuecount from issues where projid=@projid 
	and issstatus != (select statusid from issuestatusfinal) 
	and ( isprivate = 0 or @canviewprivate = 1)
	group by compid) b
on a.compid=b.compid
where a.projid=@projid
order by a.compname

/* future versions (number of open issues) */
select 0 as verid,-1 as verorder,N'* Unscheduled *' as vername,count(*) as issuecount from issues
where projid=@projid 
and issstatus != (select statusid from issuestatusfinal)
and fixedinverid=0
and ( isprivate = 0 or @canviewprivate = 1)
group by fixedinverid
union all
select a.verid,a.verorder,a.vername,isnull(b.issuecount, 0) as issuecount from versions a
left outer join
(select fixedinverid, count(*) as issuecount from issues where projid=@projid
	and issstatus != (select statusid from issuestatusfinal)
	and ( isprivate = 0 or @canviewprivate = 1)
	group by fixedinverid) b 
on a.verid=b.fixedinverid
where a.projid=@projid and a.verreleased='N' and a.verarchived=0
order by verorder

/* issues by type (all issues) */
select a.typeid,a.typedesc,isnull(b.issuecount, 0) as issuecount 
	from issuetypelut a 
	left outer join 
	(select isstype, count(*) as issuecount from issues where projid=@projid
	and issstatus != (select statusid from issuestatusfinal)
	and ( isprivate = 0 or @canviewprivate = 1)
	group by isstype) b
	on a.typeid=b.isstype
order by a.seq

/* issues by priority (all issues) */
select a.priorityid,a.prioritydesc,isnull(b.issuecount, 0) as issuecount 
	from issueprioritylut a 
	right outer join -- v2.0
	(select isspriority, count(*) as issuecount from issues where projid=@projid
	and issstatus != (select statusid from issuestatusfinal)
	and ( isprivate = 0 or @canviewprivate = 1)
	group by isspriority) b
	on a.priorityid=b.isspriority
order by a.seq

/* issues by status (all issues) */
select a.statusid,a.statusdesc,isnull(b.issuecount, 0) as issuecount 
	from issuestatuslut a 
	left outer join 
	(select issstatus, count(*) as issuecount from issues where projid=@projid
	and ( isprivate = 0 or @canviewprivate = 1)
	group by issstatus) b
	on a.statusid=b.issstatus
order by a.seq

/* issues by resolution (all issues) */
select a.resid,a.resdesc,isnull(b.issuecount, 0) as issuecount 
	from issueresolutionlut a 
	left outer join 
	(select issresolution, count(*) as issuecount from issues where projid=@projid
	and ( isprivate = 0 or @canviewprivate = 1)	
	group by issresolution) b
	on a.resid=b.issresolution
order by a.seq

/* issues by risk level */
select a.riskid,a.riskdesc,isnull(b.issuecount, 0) as issuecount 
	from issuerisklevellut a 
	left outer join 
	(select risklevel, count(*) as issuecount from issues where projid=@projid
	and issstatus != (select statusid from issuestatusfinal)
	and ( isprivate = 0 or @canviewprivate = 1)
	group by risklevel) b
	on a.riskid=b.risklevel
order by a.seq

/* issues by resources */
select a.userid,a.issuecount,isnull(d.fullname,N'* Unassigned *') as fullname from 
	(
	select assignedto as userid, count(*) as issuecount from issues 
			where assignedto=0 and projid=@projid and issstatus != (select statusid from issuestatusfinal)
			and ( isprivate = 0 or @canviewprivate = 1)
			group by assignedto
	union all
	select b.userid,isnull(c.issuecount, 0) as issuecount
		from projectresource b
		left outer join -- v2.0
			(select assignedto, count(*) as issuecount from issues where projid=@projid
			and issstatus != (select statusid from issuestatusfinal)
			and ( isprivate = 0 or @canviewprivate = 1)
			group by assignedto) c on b.userid=c.assignedto
	where b.projid=@projid
	) a
	left outer join 
		(select userid, firstname + ' ' +surname as fullname from users) d on a.userid=d.userid
order by fullname

end
go

/*************************************************************
* gemini_getallissuelinks
*************************************************************/
if exists(select name from sysobjects where name='gemini_getallissuelinks') 
	drop procedure gemini_getallissuelinks
 go

create procedure gemini_getallissuelinks
	@issueid numeric(10,0),
	@canviewprivate bit
as
begin
	select a.issuelinkid,a.linktypeid,c.linkname,c.linkdesc,a.linkdirection,a.otherissueid as issueid,b.projcode,b.summary,b.typedesc,b.isstype,b.statusdesc,b.issuekey
	,a.created,a.tstamp, b.isprivate from issuelinks a 
		left outer join issuesview b on a.otherissueid=b.issueid
		left outer join issuelinktypes c on a.linktypeid=c.linktypeid
	where a.issueid=@issueid and ( isprivate = 0 or @canviewprivate = 1)
	union all
	select a.issuelinkid,a.linktypeid,c.linkname,c.linkdesc,case a.linkdirection when N'I' then N'O' when N'O' then N'I' end as linkdirection,a.issueid as issueid,b.projcode,b.summary,b.typedesc,b.isstype,b.statusdesc,b.issuekey
	,a.created,a.tstamp, d.isprivate from issuelinks a 
		left outer join issuesview b on a.issueid=b.issueid
		left outer join issuelinktypes c on a.linktypeid=c.linktypeid
		left outer join issuesview d on a.otherissueid=d.issueid
	where a.otherissueid=@issueid
	order by a.linktypeid,a.linkdirection

end
 go

/*************************************************************
* gemini_getvalidissuestatusvalues
*
* Get valid pre and post issue states based upon the current
* issue status
*************************************************************/
if exists(select name from sysobjects where name='gemini_getvalidissuestatusvalues') 
	drop procedure gemini_getvalidissuestatusvalues
 go

create procedure gemini_getvalidissuestatusvalues
@currentstatusid numeric(10,0)
as
begin

-- get the current state and flag it as -1
if @currentstatusid is not null 
begin
	select statusid,statusdesc,-1 as statetype,seq
	from issuestatuslut 
	where statusid=@currentstatusid
	union all
	select a.otherstate as statusid,min(b.statusdesc) as statusdesc,min(a.statetype) as statetype,min(b.seq) as seq
	from issuestatetransitionlut a, issuestatuslut b
	where a.statusid=@currentstatusid and a.otherstate=b.statusid
	and a.otherstate <> @currentstatusid
	group by otherstate 
	order by seq
end
else
begin
	select statusid,statusdesc,-1 as statetype,seq
		from issuestatuslut order by seq
end
end
 go
 
 
 /**** REMOVE SPs ****/
 if exists(select name from sysobjects where name='gemini_getproject') 
	drop procedure gemini_getproject
 go

if exists(select name from sysobjects where name='gemini_getprojectviaissue') 
	drop procedure gemini_getprojectviaissue
 go
 
 if exists(select name from sysobjects where name='gemini_getclosedstatus') 
	drop procedure gemini_getclosedstatus
 go

if exists(select name from sysobjects where name='gemini_getassignedstatus') 
	drop procedure gemini_getassignedstatus
 go

if exists(select name from sysobjects where name='gemini_getissuestatusvalues') 
	drop procedure gemini_getissuestatusvalues
 go

if exists(select name from sysobjects where name='gemini_getissueresolutionvalues') 
	drop procedure gemini_getissueresolutionvalues
 go

if exists(select name from sysobjects where name='gemini_getxplutentries') 
	drop procedure gemini_getxplutentries
 go

if exists(select name from sysobjects where name='gemini_createissuehistory') 
	drop procedure gemini_createissuehistory
 go
 
 if exists(select name from sysobjects where name='gemini_createproject') 
	drop procedure gemini_createproject
 go
 
 if exists(select name from sysobjects where name='gemini_createprojectusingtemplate') 
	drop procedure gemini_createprojectusingtemplate
 go
 
 if exists(select name from sysobjects where name='gemini_updateproject') 
	drop procedure gemini_updateproject
 go

if exists(select name from sysobjects where name='gemini_assignprojectresource') 
	drop procedure gemini_assignprojectresource
 go

if exists(select name from sysobjects where name='gemini_updateprojectresource') 
	drop procedure gemini_updateprojectresource
 go

if exists(select name from sysobjects where name='gemini_removeprojectresource') 
	drop procedure gemini_removeprojectresource
 go

if exists(select name from sysobjects where name='gemini_getavailableresources') 
	drop procedure gemini_getavailableresources
 go

if exists(select name from sysobjects where name='gemini_getuserprojectwatchcode') 
	drop procedure gemini_getuserprojectwatchcode
 go

if exists(select name from sysobjects where name='gemini_updateuserprojectwatchcode') 
	drop procedure gemini_updateuserprojectwatchcode
 go

if exists(select name from sysobjects where name='gemini_createversion') 
	drop procedure gemini_createversion
 go

if exists(select name from sysobjects where name='gemini_getversion') 
	drop procedure gemini_getversion
 go

if exists(select name from sysobjects where name='gemini_updateversion') 
	drop procedure gemini_updateversion
 go

if exists(select name from sysobjects where name='gemini_deleteversion') 
	drop procedure gemini_deleteversion
 go

if exists(select name from sysobjects where name='gemini_getprojectversions') 
	drop procedure gemini_getprojectversions
 go

if exists(select name from sysobjects where name='gemini_getprojectversionsbytype') 
	drop procedure gemini_getprojectversionsbytype
 go

if exists(select name from sysobjects where name='gemini_createcomponent') 
	drop procedure gemini_createcomponent
 go
 
 if exists(select name from sysobjects where name='gemini_getcomponent') 
	drop procedure gemini_getcomponent
 go

if exists(select name from sysobjects where name='gemini_updatecomponent') 
	drop procedure gemini_updatecomponent
 go

if exists(select name from sysobjects where name='gemini_deletecomponent') 
	drop procedure gemini_deletecomponent
 go
 
 if exists(select name from sysobjects where name='gemini_getissuesforproject') 
	drop procedure gemini_getissuesforproject
 go

if exists(select name from sysobjects where name='gemini_getissuesforuser') 
	drop procedure gemini_getissuesforuser
 go

if exists(select name from sysobjects where name='gemini_getissuesforcomponent') 
	drop procedure gemini_getissuesforcomponent
 go

if exists(select name from sysobjects where name='gemini_getissuesforversion') 
	drop procedure gemini_getissuesforversion
 go

if exists(select name from sysobjects where name='gemini_getissueusingview') 
	drop procedure gemini_getissueusingview
 go

if exists(select name from sysobjects where name='gemini_updateissue') 
	drop procedure gemini_updateissue
 go

if exists(select name from sysobjects where name='gemini_updateissuedesc') 
	drop procedure gemini_updateissuedesc
 go

if exists(select name from sysobjects where name='gemini_updateissuepercentcomplete') 
	drop procedure gemini_updateissuepercentcomplete
 go

if exists(select name from sysobjects where name='gemini_deleteattachment') 
	drop procedure gemini_deleteattachment
 go

if exists(select name from sysobjects where name='gemini_deletemainattachment') 
	drop procedure gemini_deletemainattachment
 go

if exists(select name from sysobjects where name='gemini_deleteissue') 
	drop procedure gemini_deleteissue
 go

if exists(select name from sysobjects where name='gemini_createissuecomment') 
	drop procedure gemini_createissuecomment
 go

if exists(select name from sysobjects where name='gemini_getissuecomment') 
	drop procedure gemini_getissuecomment
 go

if exists(select name from sysobjects where name='gemini_updateissuecomment') 
	drop procedure gemini_updateissuecomment
 go

if exists(select name from sysobjects where name='gemini_markclosingcomment') 
	drop procedure gemini_markclosingcomment
 go

if exists(select name from sysobjects where name='gemini_unmarkclosingcomment') 
	drop procedure gemini_unmarkclosingcomment
 go

if exists(select name from sysobjects where name='gemini_deleteissuecomment') 
	drop procedure gemini_deleteissuecomment
 go

if exists(select name from sysobjects where name='gemini_createuser') 
	drop procedure gemini_createuser
 go

if exists(select name from sysobjects where name='gemini_getuserid') 
	drop procedure gemini_getuserid
 go

if exists(select name from sysobjects where name='gemini_getallusers') 
	drop procedure gemini_getallusers
 go

if exists(select name from sysobjects where name='gemini_getallusersforproject') 
	drop procedure gemini_getallusersforproject
 go

if exists(select name from sysobjects where name='gemini_getalluserrolesforproject') 
	drop procedure gemini_getalluserrolesforproject
 go

if exists(select name from sysobjects where name='gemini_updateuser') 
	drop procedure gemini_updateuser
 go

if exists(select name from sysobjects where name='gemini_updateuserprofile') 
	drop procedure gemini_updateuserprofile
 go

 if exists(select name from sysobjects where name='gemini_updateuserpassword') 
	drop procedure gemini_updateuserpassword
 go

if exists(select name from sysobjects where name='gemini_deleteuser') 
	drop procedure gemini_deleteuser
 go

if exists(select name from sysobjects where name='gemini_authenticateuser') 
	drop procedure gemini_authenticateuser
 go

if exists(select name from sysobjects where name='gemini_createattachment') 
	drop procedure gemini_createattachment
 go

if exists(select name from sysobjects where name='gemini_getattachmentinfo') 
	drop procedure gemini_getattachmentinfo
 go

if exists(select name from sysobjects where name='gemini_getattachment') 
	drop procedure gemini_getattachment
 go

if exists(select name from sysobjects where name='gemini_createissuewatch') 
	drop procedure gemini_createissuewatch
 go

if exists(select name from sysobjects where name='gemini_deleteissuewatch') 
	drop procedure gemini_deleteissuewatch
 go

if exists(select name from sysobjects where name='gemini_isuserwatchingissue') 
	drop procedure gemini_isuserwatchingissue
 go

if exists(select name from sysobjects where name='gemini_getissuealerts') 
	drop procedure gemini_getissuealerts
 go

if exists(select name from sysobjects where name='gemini_getusersettings') 
	drop procedure gemini_getusersettings
 go

if exists(select name from sysobjects where name='gemini_getroadmap') 
	drop procedure gemini_getroadmap
 go

if exists(select name from sysobjects where name='gemini_getchangelog') 
	drop procedure gemini_getchangelog
 go

if exists(select name from sysobjects where name='gemini_getworkload') 
	drop procedure gemini_getworkload
 go

if exists(select name from sysobjects where name='gemini_issuelinktypes') 
	drop procedure gemini_issuelinktypes
 go

if exists(select name from sysobjects where name='gemini_createissuelinktype') 
	drop procedure gemini_createissuelinktype
 go

if exists(select name from sysobjects where name='gemini_deleteissuelinktype') 
	drop procedure gemini_deleteissuelinktype
 go

if exists(select name from sysobjects where name='gemini_createissuelink') 
	drop procedure gemini_createissuelink
 go

if exists(select name from sysobjects where name='gemini_deleteissuelink') 
	drop procedure gemini_deleteissuelink
 go

if exists(select name from sysobjects where name='gemini_getissuesforprojectlite') 
	drop procedure gemini_getissuesforprojectlite
 go

if exists(select name from sysobjects where name='gemini_getcustomfieldssummary') 
	drop procedure gemini_getcustomfieldssummary
 go

if exists(select name from sysobjects where name='gemini_DeleteCustomField' and type='P') 
	drop procedure gemini_DeleteCustomField
go

if exists(select name from sysobjects where name='gemini_CreateCustomField' and type='P') 
	drop procedure gemini_CreateCustomField
go

if exists(select name from sysobjects where name='gemini_GetCustomField' and type='P') 
	drop procedure gemini_GetCustomField
go

if exists(select name from sysobjects where name='gemini_getprojectcustomfields' and type='P') 
	drop procedure gemini_getprojectcustomfields
go

if exists(select name from sysobjects where name='gemini_UpdateCustomField' and type='P') 
	drop procedure gemini_UpdateCustomField
go

if exists(select name from sysobjects where name='gemini_getcustomfieldsforcreate') 
	drop procedure gemini_getcustomfieldsforcreate
 go

if exists(select name from sysobjects where name='gemini_getcustomfieldsforedit') 
	drop procedure gemini_getcustomfieldsforedit
 go

if exists(select name from sysobjects where name='gemini_getcustomfieldsforview') 
	drop procedure gemini_getcustomfieldsforview
 go

if exists(select name from sysobjects where name='gemini_savecustomfielddata') 
	drop procedure gemini_savecustomfielddata
 go

if exists(select name from sysobjects where name='gemini_getcustomfielddata') 
	drop procedure gemini_getcustomfielddata
 go

if exists(select name from sysobjects where name='gemini_getfilteredissuesbatch') 
	drop procedure gemini_getfilteredissuesbatch
 go

if exists(select name from sysobjects where name='gemini_getfilteredissues_export') 
	drop procedure gemini_getfilteredissues_export
 go

if exists(select name from sysobjects where name='gemini_getxpfilteredissues_export') 
	drop procedure gemini_getxpfilteredissues_export
 go

if exists(select name from sysobjects where name='gemini_getfilteredissues') 
	drop procedure gemini_getfilteredissues
 go

if exists(select name from sysobjects where name='gemini_getxpfilteredissues') 
	drop procedure gemini_getxpfilteredissues
 go

if exists(select name from sysobjects where name='gemini_createpersonalfilter' and type='P') 
	drop procedure gemini_createpersonalfilter
go

if exists(select name from sysobjects where name='gemini_getpersonalfilter' and type='P') 
	drop procedure gemini_getpersonalfilter
go

if exists(select name from sysobjects where name='gemini_getallpersonalfilter' and type='P') 
	drop procedure gemini_getallpersonalfilter
go

if exists(select name from sysobjects where name='gemini_deletepersonalfilter' and type='P') 
	drop procedure gemini_deletepersonalfilter
go

if exists(select name from sysobjects where name='gemini_moveissue' and type='P') 
	drop procedure gemini_moveissue
go

if exists(select name from sysobjects where name='gemini_getissuemovedata' and type='P') 
	drop procedure gemini_getissuemovedata
go

if exists(select name from sysobjects where name='gemini_copyissue' and type='P') 
	drop procedure gemini_copyissue
go

if exists(select name from sysobjects where name='gemini_updateuserresetpassword') 
	drop procedure gemini_updateuserresetpassword
 go

if exists(select name from sysobjects where name='gemini_authenticateuserreset') 
	drop procedure gemini_authenticateuserreset
 go

if exists(select name from sysobjects where name='gemini_createsecurityscheme') 
	drop procedure gemini_createsecurityscheme
 go

if exists(select name from sysobjects where name='gemini_getsecurityscheme') 
	drop procedure gemini_getsecurityscheme
 go

if exists(select name from sysobjects where name='gemini_getsecurityschemewithusage') 
	drop procedure gemini_getsecurityschemewithusage
 go

if exists(select name from sysobjects where name='gemini_getallsecurityschemes') 
	drop procedure gemini_getallsecurityschemes
 go

if exists(select name from sysobjects where name='gemini_updatesecurityscheme') 
	drop procedure gemini_updatesecurityscheme
 go

if exists(select name from sysobjects where name='gemini_deletesecurityscheme') 
	drop procedure gemini_deletesecurityscheme
 go

if exists(select name from sysobjects where name='gemini_getprojectsecurityscheme') 
	drop procedure gemini_getprojectsecurityscheme
 go

if exists(select name from sysobjects where name='gemini_updatestatus') 
	drop procedure gemini_updatestatus
 go

if exists(select name from sysobjects where name='gemini_updateresolution') 
	drop procedure gemini_updateresolution
 go

if exists(select name from sysobjects where name='gemini_deleteissuestatetransitions') 
	drop procedure gemini_deleteissuestatetransitions
 go

if exists(select name from sysobjects where name='gemini_getissuestatus') 
	drop procedure gemini_getissuestatus
 go

if exists(select name from sysobjects where name='gemini_getsourcecontrolfilesforissue') 
	drop procedure gemini_getsourcecontrolfilesforissue
 go

if exists(select name from sysobjects where name='gemini_addsourcecontrolfilesforissue') 
	drop procedure gemini_addsourcecontrolfilesforissue
 go

if exists(select name from sysobjects where name='gemini_renamesourcecontrolfilesforissue') 
	drop procedure gemini_renamesourcecontrolfilesforissue
 go

if exists(select name from sysobjects where name='gemini_removesourcecontrolfilesforissue') 
	drop procedure gemini_removesourcecontrolfilesforissue
 go

if exists(select name from sysobjects where name='gemini_createtimeentry') 
	drop procedure gemini_createtimeentry
 go

if exists(select name from sysobjects where name='gemini_gettimeentry') 
	drop procedure gemini_gettimeentry
 go

if exists(select name from sysobjects where name='gemini_getissuetimeentries') 
	drop procedure gemini_getissuetimeentries
 go

if exists(select name from sysobjects where name='gemini_deletetimeentry') 
	drop procedure gemini_deletetimeentry
 go

if exists(select name from sysobjects where name='gemini_moveversiondown') 
	drop procedure gemini_moveversiondown
 go

if exists(select name from sysobjects where name='gemini_moveversionup') 
	drop procedure gemini_moveversionup
 go

if exists(select name from sysobjects where name='gemini_projreposdeletenode') 
	drop procedure gemini_projreposdeletenode
go

if exists(select name from sysobjects where name='gemini_getprojectrepository') 
	drop procedure gemini_getprojectrepository
go

if exists(select name from sysobjects where name='gemini_projreposcreatedir') 
	drop procedure gemini_projreposcreatedir
go

if exists(select name from sysobjects where name='gemini_projreposcreatefile') 
	drop procedure gemini_projreposcreatefile
go

if exists(select name from sysobjects where name='gemini_projreposupdatefile') 
	drop procedure gemini_projreposupdatefile
go

if exists(select name from sysobjects where name='gemini_projreposrenamenode') 
	drop procedure gemini_projreposrenamenode
go

if exists(select name from sysobjects where name='gemini_createprojectattribute') 
	drop procedure gemini_createprojectattribute
go

if exists(select name from sysobjects where name='gemini_deleteprojectattribute') 
	drop procedure gemini_deleteprojectattribute
go

if exists(select name from sysobjects where name='gemini_getprojectattribute') 
	drop procedure gemini_getprojectattribute
go

if exists(select name from sysobjects where name='gemini_getprojectattributes') 
	drop procedure gemini_getprojectattributes
go

if exists(select name from sysobjects where name='gemini_updateprojectattribute') 
	drop procedure gemini_updateprojectattribute
go

if exists(select name from sysobjects where name='gemini_moveprojectattributedown') 
	drop procedure gemini_moveprojectattributedown
 go

if exists(select name from sysobjects where name='gemini_moveprojectattributeup') 
	drop procedure gemini_moveprojectattributeup
 go

if exists(select name from sysobjects where name='gemini_getallcustomfields') 
	drop procedure gemini_getallcustomfields
 go

if exists(select name from sysobjects where name='gemini_getallresources') 
	drop procedure gemini_getallresources
 go

if exists(select name from sysobjects where name='gemini_getpassword') 
	drop procedure gemini_getpassword
 go

if exists(select name from sysobjects where name='gemini_createissue') 
	drop procedure gemini_createissue
 go

if exists(select name from sysobjects where name='gemini_getprojectresources') 
	drop procedure gemini_getprojectresources
 go

if exists(select name from sysobjects where name='gemini_deleteissueattachments') 
	drop procedure gemini_deleteissueattachments
 go

if exists(select name from sysobjects where name='gemini_deleteissuetimeentries') 
	drop procedure gemini_deleteissuetimeentries
 go

if exists(select name from sysobjects where name='gemini_deletecommentattachment') 
	drop procedure gemini_deletecommentattachment
 go

if exists(select name from sysobjects where name='gemini_inferuserid') 
	drop procedure gemini_inferuserid
 go

if exists(select name from sysobjects where name='gemini_getissuereportersforproject') 
	drop procedure gemini_getissuereportersforproject
 go

if exists(select name from sysobjects where name='gemini_applyprojectsecurityscheme') 
	drop procedure gemini_applyprojectsecurityscheme
 go

if exists(select name from sysobjects where name='gemini_getprojectsecurityschemeusers') 
	drop procedure gemini_getprojectsecurityschemeusers
 go

if exists(select name from sysobjects where name='gemini_getProjectComponents') 
	drop procedure gemini_getProjectComponents
 go

if exists(select name from sysobjects where name='gemini_getallprojects') 
	drop procedure gemini_getallprojects
 go
