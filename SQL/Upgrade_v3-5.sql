--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 3.5
--
-- DATA MIGRATION SCRIPT: Prepare 3.1 Gemini database schema for use with 3.5
--
--*********************************************************************************
--*********************************************************************************
TRUNCATE TABLE gemini_install
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'3.5')
GO

--*********************************************************************************
-- Application Settings
--*********************************************************************************
INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('EnabledEmailAlertTypes','Alerts','2047', 'Globally enabled/disabled email issue alert types')
GO
INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('BackupPath','Backup','c:\', 'Default backup path for ZIP files')
GO
UPDATE gemini_applicationsettings SET 
	settingvalue = 'US English|en-US|UK English|en-GB|German|de-DE|Spanish|es-ES|Italian|it-IT|French|fr-FR|Japanese|ja-JP|Portuguese|pt-PT|Chinese Simplified|zh-CHS|Chinese Traditional|zh-TW|Russian|ru-RU|Greek|el-GR|Dutch|nl-NL|Polish|pl-PL|Brazilian Portuguese|pt-BR|Czech|cs-CZ|Slovak|sk-SK|Swedish|se-SE|Hindi|hi-IN|Danish|da-DK'
	where settingname = 'InstalledLanguages'
GO

--*********************************************************************************
-- Mailbox Processor
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_mailboxprocessor') DROP TABLE gemini_mailboxprocessor
GO

CREATE TABLE gemini_mailboxprocessor
(
	popmailboxid NUMERIC(10,0) NOT NULL IDENTITY(1,1) CONSTRAINT gemini_mailboxprocessor_mailboxid_pk PRIMARY KEY,
	popname NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_popname_def DEFAULT(''),
	popserver NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_popserver_def DEFAULT(''),
	popserverport NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_popserverport_def DEFAULT(0),
	popmailbox NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_popmailbox_def DEFAULT(''),
	popusername NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_popusername_def DEFAULT(''),
	poppassword NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_poppassword_def DEFAULT(''),
	popsubjectlikeregexpression NVARCHAR(100),
	popsubjectnotlikeregexpression NVARCHAR(100),
	popauthenticationmode NVARCHAR(100) NOT NULL,
	popdebugfilepath NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_popdebugfilepath_def DEFAULT(''),	
	popusessl bit NOT NULL CONSTRAINT gemini_mailboxprocessor_popusessl_def DEFAULT(0),
	popdeletemessages bit NOT NULL CONSTRAINT gemini_mailboxprocessor_popdeletemessages_def DEFAULT(0),
	popdebugmode bit NOT NULL CONSTRAINT gemini_mailboxprocessor_popdebugmode_def DEFAULT(0),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_userid_def DEFAULT(-1) CONSTRAINT gemini_mailboxprocessor_userid_fk REFERENCES gemini_users(userid),
	issuetypeid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_issuetypeid_fk FOREIGN KEY REFERENCES gemini_issuetypes(typeid),
	issuecomponentid NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_issuecomponentid_def DEFAULT('0'),
	issuepriorityid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_issueprioriotyid_fk FOREIGN KEY REFERENCES gemini_issuepriorities(priorityid),
	issueseverityid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_issueseverityid_fk FOREIGN KEY REFERENCES gemini_issueseverity(severityid),
	issuerisklevelid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_issuerisklevelid_fk FOREIGN KEY REFERENCES gemini_issuerisklevels(risklevelid),
	visibility NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_visibility_def DEFAULT(1),
	visibilitymembertype NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_visibilitymembertype_def DEFAULT(1),
	created DATETIME NOT NULL CONSTRAINT gemini_mailboxprocessor_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL	
)
GO

--*********************************************************************************
-- Versions
--*********************************************************************************
ALTER TABLE gemini_versions ADD	startdate DATETIME NOT NULL CONSTRAINT gemini_versions_startdate_def DEFAULT CURRENT_TIMESTAMP
GO
ALTER TABLE gemini_versions ADD releasedate DATETIME NOT NULL CONSTRAINT gemini_versions_releasedate_def DEFAULT DATEADD (month,2,CURRENT_TIMESTAMP)
GO

--*********************************************************************************
-- Versions Milestone
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_versionmilestone') DROP TABLE gemini_versionmilestone
GO

CREATE TABLE gemini_versionmilestone
(
	milestoneid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_versionmilestone_milestoneid_pk PRIMARY KEY,
	versionid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_versionmilestone_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid),
	milestonename NVARCHAR(100) NOT NULL CONSTRAINT gemini_versionmilestone_milestonename_def DEFAULT (''),
	milestonedesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_versionmilestone_milestonedesc_def DEFAULT (''),	
	milestonedate DATETIME NOT NULL CONSTRAINT gemini_versionmilestone_milestonedate_def DEFAULT CURRENT_TIMESTAMP,   	
    created DATETIME NOT NULL CONSTRAINT gemini_versionmilestone_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO

--*********************************************************************************
-- Personal Issue Filters
--*********************************************************************************	
ALTER TABLE gemini_personalfilters ADD reportedbyuserid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_personalfilters_reportedbyuserid_def DEFAULT (0)
GO
ALTER TABLE gemini_personalfilters ADD initialstartdate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_initialstartdate_def DEFAULT ('')
GO
ALTER TABLE gemini_personalfilters ADD finalstartdate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_finalstartdate_def DEFAULT ('')
GO
ALTER TABLE gemini_personalfilters ADD initialduedate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_initialduedate_def DEFAULT ('')
GO
ALTER TABLE gemini_personalfilters ADD finalduedate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_finalduedate_def DEFAULT ('')
GO
ALTER TABLE gemini_personalfilters ADD savedfromreports BIT NOT NULL CONSTRAINT gemini_personalfilters_savedfromreports_def DEFAULT(0)
GO
ALTER TABLE gemini_personalfilters DROP Constraint gemini_personalfilters_reportedbyuser_def 
ALTER TABLE gemini_personalfilters DROP column reportedbyuser 
GO

--*********************************************************************************
-- Issue TimeType
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuetimetype') DROP TABLE gemini_issuetimetype
GO

CREATE TABLE gemini_issuetimetype
(
	timetypeID NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuetimetype_timetypeID_pk PRIMARY KEY,
	timetypename NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuetimetype_timetypename_def DEFAULT (''),
	timetypedesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuetimetype_timetypedesc_def DEFAULT (''),	
	created DATETIME NOT NULL CONSTRAINT gemini_issuetimetype_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO
--*********************************************************************************
-- Add new column to gemini_timetracking
--*********************************************************************************	

ALTER TABLE gemini_timetracking ADD timetypeid NUMERIC(10,0) NULL CONSTRAINT gemini_timetracking_timetypeid_fk FOREIGN KEY REFERENCES gemini_issuetimetype(timetypeID)
GO

--*********************************************************************************
-- Project BuiltIn Report 
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_reports') DROP TABLE gemini_reports
GO

CREATE TABLE gemini_reports
(
	reportid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_reports_reportid_pk PRIMARY KEY,
	reportname NVARCHAR(255) NOT NULL CONSTRAINT gemini_reports_reportname_def DEFAULT (''),
	reportdesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_reports_reportdesc_def DEFAULT (''),	
	reportsource NVARCHAR(255) NOT NULL CONSTRAINT gemini_reports_reportsource_def DEFAULT (''),   	
    created DATETIME NOT NULL CONSTRAINT gemini_reports_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO

SET IDENTITY_INSERT gemini_reports ON
GO
INSERT INTO gemini_reports (reportid, reportname, reportdesc, reportsource, created) VALUES (1, 'Issue Status & Resolution Report','Issue Status & Resolution Report', '~/Project/Reports/IssueStatusandResolutionReportUC.ascx',getdate())
GO
INSERT INTO gemini_reports (reportid, reportname, reportdesc, reportsource, created) VALUES (2, 'Issue Priority & Type Report','Issue Priority & Type Report', '~/Project/Reports/IssuePriorityandTypeUC.ascx',getdate())
GO
INSERT INTO gemini_reports (reportid, reportname, reportdesc, reportsource, created) VALUES (3, 'Issue By Component Report','Issue By Component Report', '~/Project/Reports/IssueByComponentUC.ascx',getdate())
GO
INSERT INTO gemini_reports (reportid, reportname, reportdesc, reportsource, created) VALUES (4, 'Project Time Report','Project Time Report', '~/Project/Reports/ProjectTimeReportUC.ascx',getdate())
GO
INSERT INTO gemini_reports (reportid, reportname, reportdesc, reportsource, created) VALUES (5, 'Issue Age Report','Issue Age Report', '~/Project/Reports/IssueAgeReportUC.ascx',getdate())
GO
INSERT INTO gemini_reports (reportid, reportname, reportdesc, reportsource, created) VALUES (6, 'Issue Time Duration Report','Issue Time Duration Report', '~/Project/Reports/IssueTimeDurationReportUC.ascx',getdate())
GO
SET IDENTITY_INSERT gemini_reports OFF
GO

--*********************************************************************************
-- Reports Visibility
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_reportsvisibility') DROP TABLE gemini_reportsvisibility
GO

CREATE TABLE gemini_reportsvisibility
(
	reportvisibilityid NUMERIC(10,0) NOT NULL IDENTITY(1,1) CONSTRAINT gemini_reportsvisibility_reportvisibilityid_pk PRIMARY KEY,
	reportid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_reportsvisibility_reportid_def DEFAULT(0),
	reporttype NVARCHAR(100) NOT NULL CONSTRAINT gemini_reportsvisibility_reporttype_def DEFAULT(''),
	projectid NUMERIC(10,0) NULL CONSTRAINT gemini_reportsvisibility_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	visibility NUMERIC(10,0) NOT NULL CONSTRAINT gemini_reportsvisibility_visibility_def DEFAULT(1),
	visibilitymembertype NUMERIC(10,0) NOT NULL CONSTRAINT gemini_reportsvisibility_visibilitymembertype_def DEFAULT(1),
	created DATETIME NOT NULL CONSTRAINT gemini_reportsvisibility_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO

INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT 1 as reportid, 3 as reportype, projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects
GO
INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT 2 as reportid, 3 as reportype, projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects
GO
INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT 3 as reportid, 3 as reportype, projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects
GO
INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT 4 as reportid, 3 as reportype, projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects
GO
INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT 5 as reportid, 3 as reportype, projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects
GO
INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT 6 as reportid, 3 as reportype, projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects
GO

--*********************************************************************************
-- Saved Reports
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_savedreports') DROP TABLE gemini_savedreports
GO

CREATE TABLE gemini_savedreports
(
	reportid NUMERIC(10,0) NOT NULL IDENTITY(1,1) CONSTRAINT gemini_savedreports_reportid_pk PRIMARY KEY,
	reportname NVARCHAR(200) NOT NULL CONSTRAINT gemini_savedreports_reportname_def DEFAULT(''),
	reportdesc NVARCHAR(200) NOT NULL CONSTRAINT gemini_savedreports_reportdesc_def DEFAULT(''),	
	reporttype NVARCHAR(100) NOT NULL CONSTRAINT gemini_savedreports_reporttype_def DEFAULT(''),
	reportparameters NVARCHAR(1000) NOT NULL CONSTRAINT gemini_savedreports_reportparameters_def DEFAULT(''),	
	projectid NUMERIC(10,0) NULL CONSTRAINT gemini_savedreports_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_savedreports_userid_def DEFAULT(-1) CONSTRAINT gemini_savedreports_userid_fk REFERENCES gemini_users(userid),
	filterid NUMERIC(10,0) NULL CONSTRAINT gemini_savedreports_filterid_fk FOREIGN KEY REFERENCES gemini_personalfilters(filterid),
	ispublic bit NOT NULL CONSTRAINT gemini_savedreports_ispublic_def DEFAULT(0),
	created DATETIME NOT NULL CONSTRAINT gemini_savedreports_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO


CREATE INDEX ind_gemini_issues_parentissueid ON gemini_issues(parentissueid)
GO

DELETE FROM gemini_projectresources
GO