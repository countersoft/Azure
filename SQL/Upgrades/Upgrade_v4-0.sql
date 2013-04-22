--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini Issue Tracker -- Version 4.0
--
-- DATA MIGRATION SCRIPT from Gemini 3.7 to Gemini 4.0
--
--*********************************************************************************
--*********************************************************************************
TRUNCATE TABLE gemini_install
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'4.0')
GO

/***********************************************************
* Custom Field Definitions
***********************************************************/
ALTER TABLE gemini_customfielddefinitions ADD showinline BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_showinline_def DEFAULT 0
ALTER TABLE gemini_customfielddefinitions ADD lookupdata NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_customfielddefinitions_lookupdata_def DEFAULT ('')
ALTER TABLE gemini_customfielddefinitions ADD maxvalue NUMERIC(15,5) NULL
ALTER TABLE gemini_customfielddefinitions ADD minvalue NUMERIC(15,5) NULL
ALTER TABLE gemini_customfielddefinitions ADD listlimiter NVARCHAR(500) NOT NULL CONSTRAINT gemini_customfielddefinitions_listlimiter_def DEFAULT ('')
ALTER TABLE gemini_customfielddefinitions ADD usedin INT NOT NULL CONSTRAINT gemini_customfielddefinitions_usedin_def DEFAULT (1)
ALTER TABLE gemini_customfielddefinitions ADD tag NVARCHAR(100) NOT NULL CONSTRAINT gemini_customfielddefinitions_tag_def DEFAULT ('')
GO

/***********************************************************
* Custom Field Data
***********************************************************/
ALTER TABLE gemini_customfielddata DROP CONSTRAINT gemini_customfielddata_fielddata_def
ALTER TABLE gemini_customfielddata ALTER COLUMN fielddata NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_customfielddata ADD CONSTRAINT gemini_customfielddata_fielddata_def DEFAULT('') FOR fielddata
ALTER TABLE gemini_customfielddata ADD filedata VARBINARY(MAX) NULL
ALTER TABLE gemini_customfielddata ADD numericdata NUMERIC(15,5) NULL
ALTER TABLE gemini_customfielddata ADD datedata DATETIME NULL
GO

/***********************************************************
* Closed and Resolved Dates Filtering
***********************************************************/
ALTER TABLE gemini_personalfilters ADD initialcloseddate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_initialcloseddate_def  DEFAULT ('')
ALTER TABLE gemini_personalfilters ADD finalcloseddate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_finalcloseddate_def  DEFAULT ('')
ALTER TABLE gemini_personalfilters ADD initialresolveddate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_initialresolveddate_def  DEFAULT ('')
ALTER TABLE gemini_personalfilters ADD finalresolveddate NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_finalresolveddate_def  DEFAULT ('')
ALTER TABLE gemini_personalfilters ADD testtype NVARCHAR(100) NOT NULL CONSTRAINT gemini_personalfilters_testtype_def  DEFAULT ('')
GO

/***********************************************************
* Settings
***********************************************************/
UPDATE gemini_applicationsettings SET settingvalue = settingvalue + '|Ukrainian|uk-UA' WHERE settingname = 'InstalledLanguages'
GO

INSERT INTO gemini_issuelinktypes (linkname,linkdesc) VALUES (N'Repeated',N'Itmes that have been repeated')
GO

/***********************************************************
* Synch custom fields' project id
***********************************************************/
UPDATE cfd SET cfd.projectid = i.projectid FROM gemini_customfielddata cfd JOIN gemini_issues i ON cfd.issueid = i.issueid WHERE cfd.projectid != i.projectid
GO

/**************************************************************
* Add isparent and hierarchy key to issues, add repeated column
**************************************************************/
ALTER TABLE gemini_issues ADD isparent BIT NOT NULL CONSTRAINT gemini_issues_isparent_def DEFAULT(0)
ALTER TABLE gemini_issues ADD hierarchykey VARCHAR(255) NOT NULL CONSTRAINT gemini_issues_hierarchykey_def DEFAULT('')
ALTER TABLE gemini_issues ADD repeated NVARCHAR(255) NOT NULL CONSTRAINT gemini_issues_repeated_def DEFAULT('')
GO
UPDATE gemini_issues SET isparent = 1 WHERE issueid in (SELECT DISTINCT parentissueid FROM gemini_issues)
UPDATE gemini_issues SET hierarchykey = '|' + CAST(parentissueid AS VARCHAR(10)) + '|' WHERE parentissueid IS NOT NULL
GO

/***********************************************************
* Add watch codes for reporter and assignee to gemini_watchproject
***********************************************************/
ALTER TABLE gemini_watchproject ADD	createdwatchcode NUMERIC(10,0) NOT NULL CONSTRAINT gemini_createdwatchproject_watchcode_def DEFAULT(0)
ALTER TABLE gemini_watchproject ADD	assignedwatchcode NUMERIC(10,0) NOT NULL CONSTRAINT gemini_assignedwatchproject_watchcode_def DEFAULT(0)
GO

/***********************************************************
* New project settings
***********************************************************/
ALTER TABLE gemini_projects ADD	settingdescription BIT NOT NULL CONSTRAINT gemini_projects_settingdescription_def DEFAULT(1)
ALTER TABLE gemini_projects DROP COLUMN schemeid
GO

/***********************************************************
* New Visibility Items (Votes, Comments etc...)
***********************************************************/
INSERT INTO gemini_fieldvisibilityschemeitems(fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
SELECT fieldvisibilityschemeid, 6, 0, 1 FROM gemini_fieldvisibilityschemes
GO

INSERT INTO gemini_fieldvisibilityschemeitemgroups(fieldvisibilityschemeitemid, memberid, membertype)
SELECT fieldvisibilityschemeitemid, 1, 2 FROM gemini_fieldvisibilityschemeitems WHERE fieldid IN (6)
GO

ALTER TABLE gemini_fieldvisibilityschemes ADD areatype INT NOT NULL CONSTRAINT gemini_fieldvisibilityschemes_areatype_def DEFAULT (1)
GO

/***********************************************************
* Sych Project ids
***********************************************************/
UPDATE a SET a.projectid = i.projectid FROM gemini_customfielddata a JOIN gemini_issues i ON i.issueid = a.issueid WHERE i.projectid != a.projectid
UPDATE a SET a.projectid = i.projectid FROM gemini_issueattachments a JOIN gemini_issues i ON i.issueid = a.issueid WHERE i.projectid != a.projectid
UPDATE a SET a.projectid = i.projectid FROM gemini_issuecomments a JOIN gemini_issues i ON i.issueid = a.issueid WHERE i.projectid != a.projectid
UPDATE a SET a.projectid = i.projectid FROM gemini_issuehistory a JOIN gemini_issues i ON i.issueid = a.issueid WHERE i.projectid != a.projectid
UPDATE a SET a.projectid = i.projectid FROM gemini_timetracking a JOIN gemini_issues i ON i.issueid = a.issueid WHERE i.projectid != a.projectid
UPDATE a SET a.projectid = i.projectid FROM gemini_watchissues a JOIN gemini_issues i ON i.issueid = a.issueid WHERE i.projectid != a.projectid
GO

/***********************************************************
* Testing
***********************************************************/
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_history') DROP TABLE gemini_testing_history
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_customdata') DROP TABLE gemini_testing_customdata
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_run_times') DROP TABLE gemini_testing_run_times
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_attachments') DROP TABLE gemini_testing_attachments
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_run_cases') DROP TABLE gemini_testing_run_cases
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_run_steps') DROP TABLE gemini_testing_run_steps
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_runs') DROP TABLE gemini_testing_runs
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_case_steps') DROP TABLE gemini_testing_case_steps
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_case_issues') DROP TABLE gemini_testing_case_issues
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_plan_cases') DROP TABLE gemini_testing_plan_cases
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_cases') DROP TABLE gemini_testing_cases
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_plans') DROP TABLE gemini_testing_plans
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_testing_types') DROP TABLE gemini_testing_types
GO

CREATE TABLE gemini_testing_types
(
	typeid INT IDENTITY(1,1) CONSTRAINT gemini_testing_types_typeid_pk PRIMARY KEY NONCLUSTERED,
	seq INT NOT NULL CONSTRAINT gemini_testing_types_seq_def DEFAULT(0),
	typedesc NVARCHAR(100) NOT NULL,
	imagepath NVARCHAR(100) NOT NULL,
	tstamp TIMESTAMP NOT NULL
)
CREATE UNIQUE INDEX ind_gemini_testing_types_typeid ON gemini_testing_types(typeid)
CREATE INDEX ind_gemini_testing_types_desc ON gemini_testing_types(typedesc)

SET IDENTITY_INSERT gemini_testing_types ON
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (1,1,N'Acceptance',N'images/test-acceptance.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (2,2,N'Black Box',N'images/test-blackbox.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (3,3,N'Boundary',N'images/test-boundary.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (4,4,N'Component',N'images/test-component.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (5,5,N'Functional',N'images/test-functional.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (6,6,N'Integration',N'images/test-integration.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (7,7,N'Installation',N'images/test-installation.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (8,8,N'Load',N'images/test-load.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (9,9,N'Performance',N'images/test-performance.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (10,10,N'Regression',N'images/test-regression.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (11,11,N'Requirements',N'images/test-requirements.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (12,12,N'Security',N'images/test-security.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (13,13,N'Smoke',N'images/test-smoke.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (14,14,N'Stress',N'images/test-stress.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (15,15,N'System',N'images/test-system.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (16,16,N'Unit',N'images/test-unit.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (17,17,N'Usability',N'images/test-usability.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (18,18,N'User',N'images/test-user.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (19,19,N'Validation',N'images/test-validation.png')
INSERT INTO gemini_testing_types(typeid,seq,typedesc,imagepath) VALUES (20,20,N'White Box',N'images/test-whitebox.png')
SET IDENTITY_INSERT gemini_testing_types OFF

CREATE TABLE gemini_testing_plans
(
	testplanid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_plans_testplanid_pk PRIMARY KEY,
	summary NVARCHAR(255) NOT NULL CONSTRAINT gemini_testing_plans_summary_def DEFAULT (''),
	plandescription NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_testing_plans_plandescription_def DEFAULT (''),
	parenttestplanid INT NULL CONSTRAINT gemini_testing_plans_parenttestplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_plans_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	isparent BIT NOT NULL,
	isfolder BIT NOT NULL,
	isclosed BIT NOT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_plans_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_plans_created_def DEFAULT CURRENT_TIMESTAMP,
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_plans_revised_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_plans_projectid ON gemini_testing_plans(projectid)
CREATE INDEX ind_gemini_testing_plans_parenttestplanid ON gemini_testing_plans(parenttestplanid)
CREATE INDEX ind_gemini_testing_plans_createdby ON gemini_testing_plans(createdby)

CREATE TABLE gemini_testing_cases
(
	testcaseid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_cases_testcaseid_pk PRIMARY KEY,
	summary NVARCHAR(255) NOT NULL CONSTRAINT gemini_testing_cases_summary_def DEFAULT (''),
	testcasedescription NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_testing_cases_description_def DEFAULT (''),
	typeid INT NOT NULL CONSTRAINT gemini_testing_cases_typeid_fk FOREIGN KEY REFERENCES gemini_testing_types(typeid),
	assignedto NUMERIC(10,0) NULL CONSTRAINT gemini_testing_cases_assignedto_fk FOREIGN KEY REFERENCES gemini_users(userid),
	preconditions NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_testing_cases_preconditions_def DEFAULT (''),
	expectedresult NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_testing_cases_expectedresult_def DEFAULT (''),
	originaltestcaseid INT NULL CONSTRAINT gemini_testcase_originaltestcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_cases_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	parenttestcaseid INT NULL CONSTRAINT gemini_testing_cases_parenttestcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	isautomated BIT NOT NULL,
	isparent BIT NOT NULL,
	isfolder BIT NOT NULL,
	isclosed BIT NOT NULL,
	haspassed BIT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_cases_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_cases_created_def DEFAULT CURRENT_TIMESTAMP,
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_cases_revised_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_cases_typeid ON gemini_testing_cases(typeid)
CREATE INDEX ind_gemini_testing_cases_assignedto ON gemini_testing_cases(assignedto)
CREATE INDEX ind_gemini_testing_cases_originaltestcaseid ON gemini_testing_cases(originaltestcaseid)
CREATE INDEX ind_gemini_testing_cases_projectid ON gemini_testing_cases(projectid)
CREATE INDEX ind_gemini_testing_cases_createdby ON gemini_testing_cases(createdby)

CREATE TABLE gemini_testing_plan_cases
(
	id INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_plan_cases_id_pk PRIMARY KEY,
	testplanid INT NOT NULL CONSTRAINT gemini_testing_plan_cases_testplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	testcaseid INT NOT NULL CONSTRAINT gemini_testing_plan_cases_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	testcaseorder INT NOT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_plan_cases_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_plan_cases_created_def DEFAULT CURRENT_TIMESTAMP,
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_plan_cases_revised_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_plan_cases_testplanid ON gemini_testing_plan_cases(testplanid)
CREATE INDEX ind_gemini_testing_plan_cases_testcaseid ON gemini_testing_plan_cases(testcaseid)


CREATE TABLE gemini_testing_case_issues
(
	id INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_case_issues_id_pk PRIMARY KEY,
	testcaseid INT NOT NULL CONSTRAINT gemini_testing_case_issues_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_case_issues_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_case_issues_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_case_issues_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_case_issues_testcaseid ON gemini_testing_case_issues(testcaseid)
CREATE INDEX ind_gemini_testing_case_issues_issueid ON gemini_testing_case_issues(issueid)
CREATE UNIQUE INDEX uind_gemini_testing_case_issues_testcaseid_issueid ON gemini_testing_case_issues(testcaseid, issueid)

CREATE TABLE gemini_testing_case_steps
(
	stepid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_case_steps_stepid_pk PRIMARY KEY,
	testcaseid INT NOT NULL CONSTRAINT gemini_testing_case_steps_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	steptestcaseid INT NULL CONSTRAINT gemini_testing_case_steps_steptestcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	steporder INT NOT NULL,
	stepdescription NVARCHAR(MAX) NOT NULL,
	expectedresult NVARCHAR(MAX) NOT NULL,
	data NVARCHAR(MAX) NOT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_case_steps_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_case_steps_created_def DEFAULT CURRENT_TIMESTAMP,
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_case_steps_revised_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_case_steps_testcaseid ON gemini_testing_case_steps(testcaseid)
CREATE INDEX ind_gemini_testing_case_steps_steptestcaseid ON gemini_testing_case_steps(steptestcaseid)
CREATE INDEX ind_gemini_testing_case_steps_createdby ON gemini_testing_case_steps(createdby)

CREATE TABLE gemini_testing_runs
(
	testrunid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_runs_testrunid_pk PRIMARY KEY,
	testplanid INT NULL CONSTRAINT gemini_testing_runs_testplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	testcaseid INT NULL CONSTRAINT gemini_testing_runs_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_runs_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	summary NVARCHAR(255) NOT NULL CONSTRAINT gemini_testing_runs_summary_def DEFAULT (''),
	rundescription NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_testing_runs_rundescription_def DEFAULT (''),
	duration INT NOT NULL CONSTRAINT gemini_testing_runs_duration_def DEFAULT (0),
	isautomated BIT NOT NULL,
	haspassed BIT NULL,
	isclosed BIT NOT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_runs_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_runs_created_def DEFAULT CURRENT_TIMESTAMP,
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_runs_revised_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_runs_testplanid ON gemini_testing_runs(testplanid)
CREATE INDEX ind_gemini_testing_runs_testcaseid ON gemini_testing_runs(testcaseid)
CREATE INDEX ind_gemini_testing_runs_projectid ON gemini_testing_runs(projectid)
CREATE INDEX ind_gemini_testing_runs_createdby ON gemini_testing_runs(createdby)

CREATE TABLE gemini_testing_run_cases
(
	testruncaseid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_run_cases_testruncaseid_pk PRIMARY KEY,
	testrunid INT NOT NULL CONSTRAINT gemini_testing_run_cases_testrunid_fk FOREIGN KEY REFERENCES gemini_testing_runs(testrunid),
	testplanid INT NULL CONSTRAINT gemini_testing_run_cases_testplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	testcaseid INT NOT NULL CONSTRAINT gemini_testing_run_cases_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_cases_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	haspassed BIT NULL,
	isclosed BIT NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_testing_run_cases_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_run_cases_testrunid ON gemini_testing_run_cases(testrunid)
CREATE INDEX ind_gemini_testing_run_cases_testplanid ON gemini_testing_run_cases(testplanid)
CREATE INDEX ind_gemini_testing_run_cases_testcaseid ON gemini_testing_run_cases(testcaseid)
CREATE INDEX ind_gemini_testing_run_cases_projectid ON gemini_testing_run_cases(projectid)

-- A copy of the steps table as the original might change and we want to keep it in the runs as it was ran.
CREATE TABLE gemini_testing_run_steps
(
	testrunstepid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_run_steps_testrunstepid_pk PRIMARY KEY,
	testrunid INT NOT NULL CONSTRAINT gemini_testing_run_steps_testrunid_fk FOREIGN KEY REFERENCES gemini_testing_runs(testrunid),
	testcaseid INT NOT NULL CONSTRAINT gemini_testing_run_steps_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	stepid INT NOT NULL CONSTRAINT gemini_testing_run_steps_stepid_fk FOREIGN KEY REFERENCES gemini_testing_case_steps(stepid),
	steporder INT NOT NULL,
	stepdescription NVARCHAR(MAX) NOT NULL,
	expectedresult NVARCHAR(MAX) NOT NULL,
	actualresult NVARCHAR(MAX) NOT NULL,
	data NVARCHAR(MAX) NOT NULL,
	haspassed BIT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_steps_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_run_steps_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_run_steps_testrunid ON gemini_testing_run_steps(testrunid)
CREATE INDEX ind_gemini_testing_run_steps_testcaseid ON gemini_testing_run_steps(testcaseid)
CREATE INDEX ind_gemini_testing_run_steps_stepid ON gemini_testing_run_steps(stepid)
CREATE INDEX ind_gemini_testing_run_steps_createdby ON gemini_testing_run_steps(createdby)
CREATE UNIQUE INDEX und_gemini_testing_run_steps_testrunid_stepid ON gemini_testing_run_steps(testrunid, stepid)

CREATE TABLE gemini_testing_attachments
(
	attachmentid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_attachments_attachmentid_pk PRIMARY KEY,
	testplanid INT NULL CONSTRAINT gemini_testing_attachments_testplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	testcaseid INT NULL CONSTRAINT gemini_testing_attachments_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	testrunid INT NULL CONSTRAINT gemini_testing_attachments_testrunid_fk FOREIGN KEY REFERENCES gemini_testing_runs(testrunid),
	stepid INT NULL CONSTRAINT gemini_testing_attachments_stepid_fk FOREIGN KEY REFERENCES gemini_testing_case_steps(stepid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_attachments_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	contenttype NVARCHAR(200) NOT NULL CONSTRAINT gemini_testing_attachments_contenttype_def DEFAULT '',
	contentlength INT NOT NULL CONSTRAINT gemini_testing_attachments_contentlength_def DEFAULT 0,
	thefilename NVARCHAR(200) NOT NULL CONSTRAINT gemini_testing_attachments_thefilename_def DEFAULT '',
	filecontent VARBINARY(MAX),
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_attachments_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_attachments_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)

CREATE INDEX ind_gemini_testing_attachments_testplanid ON gemini_testing_attachments(testplanid)
CREATE INDEX ind_gemini_testing_attachments_testcaseid ON gemini_testing_attachments(testcaseid)
CREATE INDEX ind_gemini_testing_attachments_testrunid ON gemini_testing_attachments(testrunid)
CREATE INDEX ind_gemini_testing_attachments_stepid ON gemini_testing_attachments(stepid)
CREATE INDEX ind_gemini_testing_attachments_createdby ON gemini_testing_attachments(createdby)

CREATE TABLE gemini_testing_run_times
(
	timelogid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_testing_run_times_timelogid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_times_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	testrunid INT NOT NULL CONSTRAINT gemini_testing_run_times_issueid_fk FOREIGN KEY REFERENCES gemini_testing_runs(testrunid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_times_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	hours NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_times_hours_def DEFAULT(0),
	minutes NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_times_minutes_def DEFAULT(0),
	comment NVARCHAR(2000) NOT NULL CONSTRAINT gemini_testing_run_times_comment_def DEFAULT(''),
	entrydate DATETIME NOT NULL,
	timetypeid NUMERIC(10,0) NULL CONSTRAINT gemini_testing_run_times_timetypeid_fk FOREIGN KEY REFERENCES gemini_issuetimetype(timetypeID),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_run_times_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)

CREATE INDEX ind_gemini_testing_run_times_testrunid ON gemini_testing_run_times(testrunid)
CREATE INDEX ind_gemini_testing_run_times_projectid ON gemini_testing_run_times(projectid)
CREATE INDEX ind_gemini_testing_run_times_userid ON gemini_testing_run_times(userid)
CREATE INDEX ind_gemini_testing_run_times_timetypeid ON gemini_testing_run_times(timetypeid)

CREATE TABLE gemini_testing_customdata
(
	testcustomfielddataid INT IDENTITY(1,1) CONSTRAINT gemini_testing_customdata_testcustomfielddataid_pk PRIMARY KEY,
	customfieldid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_customdata_customfieldid_fk FOREIGN KEY REFERENCES gemini_customfielddefinitions(customfieldid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_customdata_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_customdata_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	testplanid INT NULL CONSTRAINT gemini_testing_customdata_testplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	testcaseid INT NULL CONSTRAINT gemini_testing_customdata_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	testrunid INT NULL CONSTRAINT gemini_testing_customdata_testrunid_fk FOREIGN KEY REFERENCES gemini_testing_runs(testrunid),
	stepid INT NULL CONSTRAINT gemini_testing_customdata_stepid_fk FOREIGN KEY REFERENCES gemini_testing_case_steps(stepid),
	fielddata NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_testing_customdata_fielddata_def DEFAULT (''), 
	filedata VARBINARY(MAX) NULL,
	numericdata NUMERIC(15,5) NULL,
	datedata DATETIME NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_testing_customdata_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_testing_customdata_customfieldid ON gemini_testing_customdata(customfieldid)
CREATE INDEX ind_gemini_testing_customdata_projectid ON gemini_testing_customdata(projectid)
CREATE INDEX ind_gemini_testing_customdata_userid ON gemini_testing_customdata(userid)
CREATE INDEX ind_gemini_testing_customdata_testplanid ON gemini_testing_customdata(testplanid)
CREATE INDEX ind_gemini_testing_customdata_testcaseid ON gemini_testing_customdata(testcaseid)
CREATE INDEX ind_gemini_testing_customdata_testrunid ON gemini_testing_customdata(testrunid)
CREATE INDEX ind_gemini_testing_customdata_stepid ON gemini_testing_customdata(stepid)

CREATE TABLE gemini_testing_history
(
	historyid INT IDENTITY(1,1) CONSTRAINT gemini_testing_history_historyid_pk PRIMARY KEY NONCLUSTERED,
	testplanid INT NULL CONSTRAINT gemini_testing_history_testplanid_fk FOREIGN KEY REFERENCES gemini_testing_plans(testplanid),
	testcaseid INT NULL CONSTRAINT gemini_testing_history_testcaseid_fk FOREIGN KEY REFERENCES gemini_testing_cases(testcaseid),
	testrunid INT NULL CONSTRAINT gemini_testing_history_testrunid_fk FOREIGN KEY REFERENCES gemini_testing_runs(testrunid),
	stepid INT NULL CONSTRAINT gemini_testing_history_stepid_fk FOREIGN KEY REFERENCES gemini_testing_case_steps(stepid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_history_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	history NVARCHAR(255) NOT NULL,
	fullname NVARCHAR(255) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_testing_history_created_def DEFAULT CURRENT_TIMESTAMP
)
CREATE INDEX ind_gemini_testing_history_testplanid ON gemini_testing_history(testplanid)
CREATE INDEX ind_gemini_testing_history_testcaseid ON gemini_testing_history(testcaseid)
CREATE INDEX ind_gemini_testing_history_testrunid ON gemini_testing_history(testrunid)
CREATE INDEX ind_gemini_testing_history_stepid ON gemini_testing_history(stepid)
CREATE INDEX ind_gemini_testing_history_projectid ON gemini_testing_history(projectid)
GO

/***********************************************************
* Add missing indexes
***********************************************************/
CREATE INDEX ind_gemini_issues_issuepriorityid ON gemini_issues(issuepriorityid)
CREATE INDEX ind_gemini_issues_issuetypeid ON gemini_issues(issuetypeid)
CREATE INDEX ind_gemini_issues_issueseverityid ON gemini_issues(issueseverityid)
CREATE INDEX ind_gemini_issues_visibilitymembertype ON gemini_issues(visibilitymembertype)
CREATE INDEX ind_gemini_issues_reportedby ON gemini_issues(reportedby)
CREATE INDEX ind_gemini_issues_issuestatusid ON gemini_issues(issuestatusid)
CREATE INDEX ind_gemini_issues_issueresolutionid ON gemini_issues(issueresolutionid)
CREATE INDEX ind_gemini_issues_issuerisklevelid ON gemini_issues(issuerisklevelid)
CREATE INDEX ind_gemini_issues_created ON gemini_issues(created)
CREATE INDEX ind_gemini_issues_revised ON gemini_issues(revised)
CREATE INDEX ind_gemini_issues_startdate ON gemini_issues(startdate)
CREATE INDEX ind_gemini_issues_duedate ON gemini_issues(duedate)
CREATE INDEX ind_gemini_issues_closeddate ON gemini_issues(closeddate)
CREATE INDEX ind_gemini_issues_estimateminutes ON gemini_issues(estimateminutes)
CREATE INDEX ind_gemini_issues_estimatehours ON gemini_issues(estimatehours)
CREATE INDEX ind_gemini_issues_repeated ON gemini_issues(repeated)
CREATE INDEX ind_gemini_issueresources_userid ON gemini_issueresources(userid)
GO

