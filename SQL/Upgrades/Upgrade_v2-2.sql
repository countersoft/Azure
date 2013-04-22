--*********************************************************************************
--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 2.2 UPGRADE SCRIPT
--
--*********************************************************************************
--*********************************************************************************
TRUNCATE TABLE geminiinstall
INSERT INTO geminiinstall (attribute_key,attribute_value) VALUES (N'VERSION',N'2.2')
GO

/* issue alerts */
IF EXISTS(SELECT name FROM sysobjects WHERE name='issuealerts') DROP TABLE issuealerts
GO

/* issue alerts */
create table issuealerts
(
alertid numeric(10,0) identity(1,1),
issueid numeric(10,0) not null default 0,
projid numeric(10,0) not null default 0,
userid numeric(10,0) not null default 0,
servicecomment nvarchar(50) not null default (''),
alertdata image,
created datetime not null default current_timestamp
)
go
create index ind_id on issuealerts(issueid,projid)
create index ind_issueid on issuealerts(issueid)
create index ind_projid on issuealerts(projid)
GO

/* affected version */
IF EXISTS(SELECT name FROM sysobjects WHERE name='affectedversion') DROP TABLE affectedversion
GO

create table affectedversion
(
	affectedversionid numeric(10,0) identity(1,1),
	issueid numeric(10,0) not null,
	versionid numeric(10,0) not null,
	created datetime not null default current_timestamp,
	tstamp timestamp not null
)
GO

create index ind_av_id on affectedversion(affectedversionid)
create index ind_av_issueid on affectedversion(issueid)
create unique index ind_ad_issueverid on affectedversion(issueid,versionid)
GO

-- Fix issue with all projects reporting.
alter table personalfilters alter column projids nvarchar(500) not null 
GO

-- IssueFilter
alter table personalfilters add affectedversions nvarchar(100) not null default('')
GO

-- users
alter table users add comment nvarchar(500) not null default('')
GO
alter table users add active bit not null default(1)
GO

/* Settings */
update geminiappsettings set settingdesc = 'The language file to use as default' where settingname = 'DefaultCultureName'
GO
delete from geminiappsettings where settingname = 'InstalledLanguages'
go
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('InstalledLanguages','General','US English|en-US|UK English|en-GB|German|de-DE|Spanish|es-ES|Italian|it-IT|French|de-FR|Japanese|ja-JP|Portuguese|pt-PT|Chinese|zh-CHS|Russian|ru-RU|Greek|el-GR|Dutch|nl-NL|Polish|pl-PL', 'Installed languages')
GO
delete from geminiappsettings where settingname = 'InstalledThemes'
go
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('InstalledThemes','General','Default|Blue|Army|AVG', 'Installed themes')
GO
delete from geminiappsettings where settingname = 'DictionaryFolder'
go
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SchedulerDebugMode','SMTP','NO', 'Debug output from Scheduler Service')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPServer','SMTP','127.0.0.1', 'SMTP server name/IP')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPServerPort','SMTP','25', 'Default SMTP server port')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPPOPBeforeSMTP','SMTP','NO', 'Do we POP3 before SMTP send')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPAuthenticationMode','SMTP','None', 'How to authenticate with SMTP server')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPAuthenticationUsername','SMTP','', 'Username for SMTP server authentication')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPAuthenticationPassword','SMTP','', 'Password for SMTP server authentication')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('EmailAlertsPollInterval','SMTP','5', 'Batch minutes')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('EmailAlertsEnabled','SMTP','YES', 'Enable email alerts?')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPEncodingType','SMTP','UTF8', 'UTF8 encoding?')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPFromEmailAddress','SMTP','gemini@mycompany.com', 'From email address')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPFromDisplayName','SMTP','Gemini Issue Tracker', 'From email display name')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPUseSSL','SMTP','NO', 'Use SSL with SMTP server?')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('SMTPSSLMode','SMTP','Auto', 'SMTP SSL mode: Auto, Ssl2, Ssl3, Tls1')
GO
INSERT INTO geminiappsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('EmailAlertEngine','SMTP','SchedulerService', 'How to send alerts: SchedulerService, MailPlugin')
GO

/* Multi resource assignment */
IF EXISTS(SELECT name FROM sysobjects WHERE name='issueresource') DROP TABLE issueresource
GO

create table issueresource
(
	issueresourceid numeric(10,0) identity(1,1),
	issueid numeric(10,0) not null,
	userid numeric(10,0) not null,
	created datetime not null default current_timestamp,
	tstamp timestamp not null
)
GO

create index ind_ir_id on issueresource(issueresourceid)
create index ind_ir_issueid on issueresource(issueid)
create unique index ind_ir_issueuserid on issueresource(issueid,userid)
GO

alter table projects add resourcemode numeric(10,0) not null default(0)
go
alter table projects add componentmode numeric(10,0) not null default(0)
GO

/* Multi components */
IF EXISTS(SELECT name FROM sysobjects WHERE name='issuecomponent') DROP TABLE issuecomponent
GO

create table issuecomponent
(
	issuecomponentid numeric(10,0) identity(1,1),
	issueid numeric(10,0) not null,
	componentid numeric(10,0) not null,
	created datetime not null default current_timestamp,
	tstamp timestamp not null
)
GO

create index ind_ic_id on issuecomponent(issuecomponentid)
create index ind_ic_issueid on issuecomponent(componentid)
create unique index ind_ic_issueuserid on issuecomponent(issueid,componentid)
GO

insert into issuecomponent (issueid, componentid)
select issueid, compid from issues where compid is not null and compid > 0
GO

insert into issueresource (issueid, userid)
select issueid, assignedto from issues where assignedto is not null and assignedto > 0
GO

declare @str as NVARCHAR(4000)
select @str = o.[name] from sysobjects o join syscolumns c on o.id = c.cdefault
where c.[name] = 'assignedto' and c.id = object_id('issues') 
exec('alter table issues drop constraint '+@str)
GO

drop index issues.ind_compid
GO

alter table issues drop column assignedto , compid
GO

