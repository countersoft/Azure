--*********************************************************************************
--*********************************************************************************
--
-- (c) CouterSoft Gemini Issue Tracker -- Version 3.6
--
-- DATA MIGRATION SCRIPT: Prepare Gemini 3.5 database schema for use with 3.6
--
--*********************************************************************************
--*********************************************************************************

TRUNCATE TABLE gemini_install
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'3.6')
GO

/***********************************************************
* Application Settings
***********************************************************/
UPDATE gemini_applicationsettings SET 
	settingvalue = 'Default|Default2008|Army|AVG|Blue|BlueMetal|BlueSteel|Leather|Red'
	where settingname = 'InstalledThemes'
GO

/***********************************************************
* Modifing old SQL types - Do not run for SQL 2000 or 7
***********************************************************/
ALTER TABLE gemini_issues ALTER COLUMN longdesc NVARCHAR(MAX)
ALTER TABLE gemini_issuecomments ALTER COLUMN comment NVARCHAR(MAX) NOT NULL
ALTER TABLE gemini_projectversionattributevalues DROP CONSTRAINT gemini_projectversionattributesvalues_attributvalue_def
ALTER TABLE gemini_projectversionattributevalues ALTER COLUMN attributevalue NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_projectversionattributevalues ADD CONSTRAINT gemini_projectversionattributesvalues_attributvalue_def DEFAULT(N'') FOR attributevalue
ALTER TABLE gemini_issueattachments ALTER COLUMN filecontent VARBINARY(MAX)
ALTER TABLE gemini_issuealerts ALTER COLUMN alertdata VARBINARY(MAX)
ALTER TABLE gemini_projectrepository ALTER COLUMN nodedata VARBINARY(MAX)
GO

/***********************************************************
* User last login
***********************************************************/
ALTER TABLE gemini_users ADD logindate DATETIME NOT NULL CONSTRAINT gemini_users_logindate_def DEFAULT CURRENT_TIMESTAMP
ALTER TABLE gemini_users ADD previouslogindate DATETIME NOT NULL CONSTRAINT gemini_users_previouslogindate_def DEFAULT CURRENT_TIMESTAMP
GO

/***********************************************************
* Issue Type Workflow
***********************************************************/
ALTER TABLE gemini_issuetypes ADD issueworkflowid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuetypes_issueworkflowid_def DEFAULT (0)
GO

/***********************************************************
* Issue Filter Save CustomField Values
***********************************************************/
ALTER TABLE gemini_personalfilters ADD customfieldvalues NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_personalfilters_customfieldvalues_def DEFAULT ('')
GO

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_projectids_def
ALTER TABLE gemini_personalfilters ALTER COLUMN projectids NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_projectids_def DEFAULT('') FOR projectids 

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_components_def 
ALTER TABLE gemini_personalfilters ALTER COLUMN components NVARCHAR(MAX) NOT NULL
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_components_def DEFAULT('') FOR components 

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_versions_def
ALTER TABLE gemini_personalfilters ALTER COLUMN versions NVARCHAR(MAX) NOT NULL
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_versions_def DEFAULT('') FOR versions 

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_affectedversions_def 
ALTER TABLE gemini_personalfilters ALTER COLUMN affectedversions NVARCHAR(MAX) NOT NULL
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_affectedversions_def DEFAULT('') FOR affectedversions 

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_resources_def 
ALTER TABLE gemini_personalfilters ALTER COLUMN resources NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_resources_def  DEFAULT('') FOR resources

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_issuetypes_def
ALTER TABLE gemini_personalfilters ALTER COLUMN issuetypes NVARCHAR(MAX) NOT NULL
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_issuetypes_def DEFAULT('') FOR issuetypes

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_priorities_def
ALTER TABLE gemini_personalfilters ALTER COLUMN issuepriorities NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_priorities_def DEFAULT('') FOR issuepriorities

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_severity_def
ALTER TABLE gemini_personalfilters ALTER COLUMN issueseverity NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_severity_def DEFAULT('') FOR issueseverity

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_statuses_def
ALTER TABLE gemini_personalfilters ALTER COLUMN issuestatuses NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_statuses_def DEFAULT('') FOR issuestatuses

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_resoultions_def
ALTER TABLE gemini_personalfilters ALTER COLUMN issueresolutions NVARCHAR(MAX) NOT NULL
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_resoultions_def DEFAULT('') FOR issueresolutions

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_risklevels_def
ALTER TABLE gemini_personalfilters ALTER COLUMN risklevels NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_risklevels_def DEFAULT('') FOR risklevels

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_keywords_def
ALTER TABLE gemini_personalfilters ALTER COLUMN keywords NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_keywords_def DEFAULT('') FOR keywords

ALTER TABLE gemini_personalfilters DROP CONSTRAINT gemini_personalfilters_issueids_def 
ALTER TABLE gemini_personalfilters ALTER COLUMN issueids NVARCHAR(MAX) NOT NULL 
ALTER TABLE gemini_personalfilters ADD CONSTRAINT gemini_personalfilters_issueids_def DEFAULT('') FOR issueids
GO

/***********************************************************
* Issue Originator
***********************************************************/
ALTER TABLE gemini_issues ADD 
	originatortype NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_originatortype_def DEFAULT(0),
	originatorreply NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_originatorreply_def DEFAULT(0),
	originatordata NVARCHAR(255) NULL,
	originatorprocessed DATETIME

ALTER TABLE gemini_mailboxprocessor ADD 
	originatorreply NUMERIC(10,0) NOT NULL CONSTRAINT gemini_mailboxprocessor_originatorreply_def DEFAULT(0),
	usesenderassubmitter BIT NOT NULL CONSTRAINT gemini_mailboxprocessor_usesenderassubmitter_def DEFAULT(0)

/***********************************************************
* Versions StartDate, ReleaseDate not mandatory
***********************************************************/
ALTER TABLE gemini_versions ALTER COLUMN startdate DATETIME NULL
ALTER TABLE gemini_versions ALTER COLUMN releasedate DATETIME NULL
GO

/***********************************************************
* Mailbox
***********************************************************/
ALTER TABLE gemini_mailboxprocessor DROP CONSTRAINT gemini_mailboxprocessor_popdebugfilepath_def
ALTER TABLE gemini_mailboxprocessor DROP COLUMN popdebugfilepath
GO

/***********************************************************
* System Messages / Error Log
***********************************************************/
DROP TABLE gemini_errorlog
GO

DROP PROCEDURE gemini_logerror
DROP PROCEDURE gemini_geterrors
DROP PROCEDURE gemini_deleteerrors
GO

CREATE TABLE gemini_systemlog
(
	srn NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_systemlog_srn_pk PRIMARY KEY NONCLUSTERED,
	messagetype VARCHAR(30) NOT NULL,
	messagesource VARCHAR(30) NOT NULL,
	logmessage VARCHAR(MAX) NOT NULL,
	username VARCHAR(100) NOT NULL CONSTRAINT gemini_systemlog_username_def DEFAULT (''),
	created DATETIME NOT NULL CONSTRAINT gemini_systemlog_created_def DEFAULT CURRENT_TIMESTAMP
)
GO

/***********************************************************
* Issue Type - Comment Visibility
***********************************************************/
ALTER TABLE gemini_issuetypes ADD commentstagefieldvisibilityschemeid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuetypes_commentstagefieldvisibilityschemeid_def DEFAULT (0)
GO

DECLARE @schemeid INT
DECLARE @itemid INT
INSERT INTO gemini_fieldvisibilityschemes (schemename, schemedesc) VALUES ('Comments', 'Create Comment Visiblity Scheme')
SELECT @schemeid = @@IDENTITY

INSERT INTO gemini_fieldvisibilityschemeitems (fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
VALUES(@schemeid, 9, 0, 1)
SELECT @itemid = @@IDENTITY
INSERT INTO gemini_fieldvisibilityschemeitemgroups (fieldvisibilityschemeitemid, memberid, membertype)
VALUES(@itemid, 3, 2)

INSERT INTO gemini_fieldvisibilityschemeitems (fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
VALUES(@schemeid, 15, 0, 1)
SELECT @itemid = @@IDENTITY
INSERT INTO gemini_fieldvisibilityschemeitemgroups (fieldvisibilityschemeitemid, memberid, membertype)
VALUES(@itemid, 3, 2)

INSERT INTO gemini_fieldvisibilityschemeitems (fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
VALUES(@schemeid, 17, 0, 1)
SELECT @itemid = @@IDENTITY
INSERT INTO gemini_fieldvisibilityschemeitemgroups (fieldvisibilityschemeitemid, memberid, membertype)
VALUES(@itemid, 3, 2)

INSERT INTO gemini_fieldvisibilityschemeitems (fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
VALUES(@schemeid, 57, 0, 1)
SELECT @itemid = @@IDENTITY
INSERT INTO gemini_fieldvisibilityschemeitemgroups (fieldvisibilityschemeitemid, memberid, membertype)
VALUES(@itemid, 3, 2)

UPDATE gemini_issuetypes SET commentstagefieldvisibilityschemeid = @schemeid
GO

/***********************************************************
* Reports - Chart type
***********************************************************/
ALTER TABLE gemini_savedreports ADD charttype NUMERIC(10,0) NOT NULL CONSTRAINT gemini_savedreports_charttype_def DEFAULT(0)
GO

/***********************************************************
* Nested Versions and Components
***********************************************************/
ALTER TABLE gemini_versions ADD parentversionid NUMERIC(10, 0) NULL CONSTRAINT gemini_versions_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid)
GO
UPDATE gemini_components SET parentcomponentid = NULL WHERE parentcomponentid = 0
GO
ALTER TABLE gemini_components ADD CONSTRAINT gemini_components_componentid_fk FOREIGN KEY (parentcomponentid) REFERENCES gemini_components(componentid) 
GO

/***********************************************************
* Documents
***********************************************************/
CREATE TABLE gemini_projectdocuments
(
	documentid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectdocuments_documentid_pk PRIMARY KEY,
	parentdocumentid NUMERIC(10,0) NULL CONSTRAINT gemini_projectdocuments_parentdocumentid_fk FOREIGN KEY REFERENCES gemini_projectdocuments(documentid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectdocuments_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	documentname NVARCHAR(100) NOT NULL,
	documentdesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_projectdocuments_documentdesc_def DEFAULT(N''),
	isfolder BIT NOT NULL CONSTRAINT gemini_projectdocuments_isfolder_def DEFAULT(0),
	contenttype NVARCHAR(100) NULL,
	contentlength NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectdocuments_contentlength_def DEFAULT 0,
	documentdata VARBINARY(MAX) NULL,
	created DATETIME NOT NULL CONSTRAINT ggemini_projectdocuments_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO

CREATE INDEX ind_gemini_projectdocuments_parnetnodeid ON gemini_projectdocuments(parentdocumentid)
CREATE INDEX ind_gemini_projectdocuments_projectid ON gemini_projectdocuments(projectid)
GO

SET IDENTITY_INSERT gemini_projectdocuments ON
INSERT INTO gemini_projectdocuments (documentid, parentdocumentid, projectid, documentname, documentdesc, isfolder, contenttype, documentdata, created, contentlength)
SELECT nodeid, parentnodeid, projectid, nodetext, tooltip, isfolder, contenttype, nodedata, GETDATE(), ISNULL(DATALENGTH(nodedata),0) FROM gemini_projectrepository
SET IDENTITY_INSERT gemini_projectdocuments OFF
DROP TABLE gemini_projectrepository
GO

/***********************************************************
* Issue Type Visibility
***********************************************************/
INSERT INTO gemini_fieldvisibilityschemeitems(fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
SELECT fieldvisibilityschemeid, 11, 0, 1  FROM gemini_fieldvisibilityschemes WHERE schemename != 'Comments'
GO

INSERT INTO gemini_fieldvisibilityschemeitemgroups(fieldvisibilityschemeitemid, memberid, membertype)
SELECT fieldvisibilityschemeitemid, 1, 2 FROM gemini_fieldvisibilityschemeitems WHERE fieldid = 11
GO

/***********************************************************
* Mailbox
***********************************************************/
ALTER TABLE gemini_mailboxprocessor ADD issueresourceid NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_issueresourceid_def DEFAULT('')
GO
