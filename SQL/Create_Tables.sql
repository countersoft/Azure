--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini v5.0
--
--*********************************************************************************
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='breeze_mailboxmessage') DROP TABLE breeze_mailboxmessage
IF EXISTS(SELECT name FROM sysobjects WHERE name='breeze_mailbox') DROP TABLE breeze_mailbox
IF EXISTS(SELECT name FROM sysobjects WHERE name='breeze_enquiry') DROP TABLE breeze_enquiry
IF EXISTS(SELECT name FROM sysobjects WHERE name='breeze_queue') DROP TABLE breeze_queue
IF EXISTS(SELECT name FROM sysObjects WHERE name='breeze_smtpserver') DROP TABLE breeze_smtpserver 
IF EXISTS(SELECT name FROM sysObjects WHERE name='breeze_matchexpression')DROP TABLE breeze_matchexpression 

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectissuesequence') DROP TABLE gemini_projectissuesequence
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_systemlog') DROP TABLE gemini_systemlog
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueattachments') DROP TABLE gemini_issueattachments
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_sharedviews') DROP TABLE gemini_sharedviews
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_plannerviews') DROP TABLE gemini_plannerviews
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_navigationcard') DROP TABLE gemini_navigationcard

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_userwidgetdata') DROP TABLE gemini_userwidgetdata
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuewidgetdata') DROP TABLE gemini_issuewidgetdata
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_userissuesviews') DROP TABLE gemini_userissuesviews
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_watchissues') DROP TABLE gemini_watchissues
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuelinks') DROP TABLE gemini_issuelinks
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuelinktypes') DROP TABLE gemini_issuelinktypes
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_install') DROP TABLE gemini_install
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_customfielddata') DROP TABLE gemini_customfielddata

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_customfielddefinitions') DROP TABLE gemini_customfielddefinitions

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_sourcecontrolissuefiles') DROP TABLE gemini_sourcecontrolissuefiles
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_timetracking') DROP TABLE gemini_timetracking
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectdocuments') DROP TABLE gemini_projectdocuments
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectattributes') DROP TABLE gemini_projectattributes
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectversionattributevalues') DROP TABLE gemini_projectversionattributevalues
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectversionattributes') DROP TABLE gemini_projectversionattributes
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_applicationsettings') DROP TABLE gemini_applicationsettings
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuevotes') DROP TABLE gemini_issuevotes
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueresources') DROP TABLE gemini_issueresources
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_affectedversions') DROP TABLE gemini_affectedversions
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueresources') DROP TABLE gemini_issueresources
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuecomponents') DROP TABLE gemini_issuecomponents

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuecomments') DROP TABLE gemini_issuecomments
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueaudit') DROP TABLE gemini_issueaudit

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

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issues') DROP TABLE gemini_issues

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueresolutions') DROP TABLE gemini_issueresolutions

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_versionmilestone') DROP TABLE gemini_versionmilestone
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_versions') DROP TABLE gemini_versions
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_components') DROP TABLE gemini_components

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_admappings') DROP TABLE gemini_admappings
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_adgroups') DROP TABLE gemini_adgroups
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectgroupmembership') DROP TABLE gemini_projectgroupmembership
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectgroups') DROP TABLE gemini_projectgroups

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectaudit') DROP TABLE gemini_projectaudit
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectdefaultvalues') DROP TABLE gemini_projectdefaultvalues
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_appointments') DROP TABLE gemini_appointments

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuetimetype') DROP TABLE gemini_issuetimetype

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projecttemplate') DROP TABLE gemini_projecttemplate

IF EXISTS(SELECT name FROM sysobjects where name='gemini_projects') DROP TABLE gemini_projects
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectlabels') DROP TABLE gemini_projectlabels

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_globalsecurityschemeroles') DROP TABLE gemini_globalsecurityschemeroles
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_globalsecurityschemes') DROP TABLE gemini_globalsecurityschemes
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_users') DROP TABLE gemini_users

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuetypes') DROP TABLE gemini_issuetypes
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuepriorities') DROP TABLE gemini_issuepriorities
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueseverity') DROP TABLE gemini_issueseverity

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuestatus') DROP TABLE gemini_issuestatus
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_alerttemplates') DROP TABLE gemini_alerttemplates


--*********************************************************************************
-- System Tables
--*********************************************************************************

/* Application Settings */
CREATE TABLE gemini_applicationsettings
(
	settingid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_applicationsettings_settingid_pk PRIMARY KEY ,
	settingname NVARCHAR(200) NOT NULL,
	settingvalue NVARCHAR(MAX) NOT NULL,
	tstamp TIMESTAMP NOT NULL 
)

INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('OrganisationName','')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('RegistrationCode','')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('GeminiAdmins','admin@abc.com')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('WelcomeTitle','Welcome')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('WelcomeMessage','Customise this message via the admin app setting page.')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('EnableHTMLPosts','YES')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('CharSetForExcel','ISO-8859-1')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SessionRefresher','600')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('Theme','Default')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('LayoutMode','')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('DefaultCultureName','en-GB')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('TimeInWorkingDay','7:30')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('AutoAlertForIssueCreator','NO')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('AutoAlertForIssueResource','NO')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('ShowUserRegistrationLink','YES')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('AllowAnonymousAccess','YES')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('ResetPasswordSubject','Gemini Password Reset Request')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('ResetPasswordMessage','Please click ON the link below to reset your Gemini password.')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('NewUserResetPassword','BLANK')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SSOPasswordType','PLAIN')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SSOKey','')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SchedulerDebugMode','NO')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPServer','127.0.0.1')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPServerPort','25')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPPOPBeforeSMTP','NO')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPAuthenticationMode','None')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPAuthenticationUsername','')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPAuthenticationPassword','')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('EmailAlertsPollInterval','5')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('EmailAlertsEnabled','YES')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPEncodingType','UTF8')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPFromEmailAddress','gemini@mycompany.com')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPFromDisplayName','Gemini Issue Tracker')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPUseSSL','NO')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('SMTPSSLMode','Auto')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('EmailAlertEngine','SchedulerService')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('HelpDeskModeGroup','0')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('HelpDeskWelcomeTitle','Help Desk')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('HelpDeskWelcomeMessage')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('CaptchaEnabled','NO')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('MultipleProjectsVisibilityScheme','0')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('EnabledEmailAlertTypes','2047')
GO
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES('BackupPath','c:\')
GO

/* Installation Details */
CREATE TABLE gemini_install
(
	attributeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_install_attributeid_pk PRIMARY KEY NONCLUSTERED,
	attribute_key NVARCHAR(100) NOT NULL,
	attribute_value NVARCHAR(1000) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_install_created_def DEFAULT GETUTCDATE()
)
CREATE INDEX ind_gemini_install_attribute_key ON gemini_install(attribute_key)

INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.0')

/* System Log */
CREATE TABLE gemini_systemlog
(
	srn NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_systemlog_srn_pk PRIMARY KEY NONCLUSTERED,
	messagetype VARCHAR(30) NOT NULL,
	messagesource VARCHAR(30) NOT NULL,
	logmessage NVARCHAR(MAX) NOT NULL,
	username VARCHAR(100) NOT NULL CONSTRAINT gemini_systemlog_username_def DEFAULT (''),
	created DATETIME NOT NULL CONSTRAINT gemini_systemlog_created_def DEFAULT GETUTCDATE()
)

--*********************************************************************************
-- Data Tables
--*********************************************************************************

/**********************************************************************************************************************
* Project Templates
**********************************************************************************************************************/
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projecttemplate') DROP TABLE gemini_projecttemplate
GO
CREATE TABLE gemini_projecttemplate
(
	templateid INT IDENTITY(1,1) CONSTRAINT gemini_projecttemplate_templateid_pk PRIMARY KEY NONCLUSTERED,
	templatekey VARCHAR(100) NOT NULL,
	title NVARCHAR(500) NOT NULL CONSTRAINT gemini_projecttemplate_title_def DEFAULT(''),
	descrip NVARCHAR(2000) NOT NULL CONSTRAINT gemini_projecttemplate_descrip_def DEFAULT(''),
	author NVARCHAR(500) NOT NULL CONSTRAINT gemini_projecttemplate_author_def DEFAULT(''),
	published DATETIME NOT NULL CONSTRAINT gemini_projecttemplate_published_def DEFAULT GETUTCDATE(),
	versionnumber VARCHAR(50) NOT NULL CONSTRAINT gemini_projecttemplate_versionnumber_def DEFAULT(''),
	template NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_projecttemplate_template_def DEFAULT (''),	
	created DATETIME NOT NULL CONSTRAINT gemini_projecttemplate_created_def DEFAULT GETUTCDATE()
)
GO
CREATE INDEX ind_gemini_projecttemplate_templateid ON gemini_projecttemplate(templateid)
CREATE INDEX ind_gemini_projecttemplate_templatekey ON gemini_projecttemplate(templatekey)
GO

SET IDENTITY_INSERT gemini_projecttemplate ON
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('10','AGILE','Agile Development Process','Standard Agile and Scrum project template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Agile Development Process","Description":"Standard Agile and Scrum project template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":2,"TemplateKey":"AGILE","Menu":[{"PageType":2,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":1},{"PageType":5,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":2},{"PageType":1,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":3},{"PageType":3,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":4},{"PageType":4,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":5},{"PageType":20,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":6},{"PageType":8,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":7}],"CustomField":[{"Label":"Customer","ScreenLabel":"Customer","ScreenDescription":"Our Client name","ScreenTooltip":"Select the customer from the list","MaxLen":0,"CanMultiSelect":true,"RegularExpression":"","Type":"C","ProjectIdFilter":true,"ShowInAttributes":true,"LookupStaticData":"Customer A\r\nCustomer B\r\nCustomer C\r\n\r\n\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Customer Backlog ID","ScreenLabel":"Customer Backlog ID","ScreenDescription":"","ScreenTooltip":"Customer Backlog ID","MaxLen":12,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"BACKLOG A\r\nBACKLOG B\r\nBACKLOG C\r\nBACKLOG D\r\nBACKLOG E","MaxValue":999.0,"MinValue":0.0,"ListLimiter":""}],"Priority":[{"Label":"Low","Image":"priority-low.png","Color":"#0000ff"},{"Label":"Medium","Image":"priority-medium.png","Color":"#ffffff"},{"Label":"High","Image":"priority-high.png","Color":"#eb0c1f"}],"Severity":[{"Label":"Trivial","Image":"severity-trivial.png","Color":""},{"Label":"Minor","Image":"severity-minor.png","Color":"#0000ff"},{"Label":"Major","Image":"severity-major.png","Color":"#8c054d"}],"Status":[{"Final":false,"Label":"Approved","Image":"status-approved.png","Color":"#36a820"},{"Final":false,"Label":"In Backlog","Image":"test-blackbox.png","Color":"#3d213d"},{"Final":false,"Label":"In Sprint","Image":"test-user.png","Color":"#337a0f"},{"Final":false,"Label":"Unassigned","Image":"status-unassigned.png","Color":"#0000ff"},{"Final":false,"Label":"Assigned","Image":"status-assigned.png","Color":"#47d119"},{"Final":false,"Label":"In Progress","Image":"status-inprogress.png","Color":"#a130a1"},{"Final":true,"Label":"Closed","Image":"status-closed.png","Color":"#ffffff"},{"Final":false,"Label":"Reopened","Image":"status-reopened.png","Color":"#0a1c91"}],"Resolution":[{"Final":true,"Label":"Parked - No Further Action"},{"Final":true,"Label":"Complete"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"Non-Billable"},{"Label":"Internal"},{"Label":"Scrum Master PM"},{"Label":"Testing"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"23","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"25","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Status","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"CalculatedTimeLogged","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Visibility","CreateScreen":false,"EditScreen":true,"ViewScreen":false},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedSourceControl","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"160","TransitionStatusFieldRef":["In Sprint"]},{"StatusFieldRef":"In Sprint","Top":"375","Left":"45","TransitionStatusFieldRef":["Unassigned","Assigned","In Progress","In Backlog"]},{"StatusFieldRef":"Unassigned","Top":"334","Left":"308","TransitionStatusFieldRef":["Assigned","In Progress"]},{"StatusFieldRef":"Assigned","Top":"564","Left":"423","TransitionStatusFieldRef":["In Progress","Unassigned"]},{"StatusFieldRef":"In Progress","Top":"10","Left":"760","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"Closed","Top":"523","Left":"726","TransitionStatusFieldRef":["Reopened"]},{"StatusFieldRef":"Reopened","Top":"206","Left":"10","TransitionStatusFieldRef":["In Backlog"]}]},"Label":"Requirement","Image":"type-enhancement.png","Color":"#e612e6","Tag":""},{"TheScreen":{"UseFromProcessRef":"Requirement","Item":[{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"6","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":21,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"4","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"0B2B3E39-F37B-489F-AFA8-0B6C3FA63CFB","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":25,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":6,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":20,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":19,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":32,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":31,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"878C76CF-E9AE-46B4-BE05-7CC2EA5FB574","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"598B4999-4C31-427D-9BBC-C84AD954E55A","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"C8F0693D-129C-4D19-9865-9CED964F06AB","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"11","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"74A39750-6C8F-4023-82D2-1F1F10FF4E70","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"28FE1D91-7730-4067-8A10-F452FCB9D090","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"18","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"617F1435-C0AA-48E6-B6A9-2C1F756E02A6","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"AC93C4F9-B512-4A3D-8B37-BC3D5F83429D","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"ACE2F8B3-C724-444F-9B72-B8B2137DDA16","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"EFEE5D50-7DF6-49C3-9D69-E7EFC1AFEF72","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Requirement","Item":[]},"Label":"Story","Image":"type-newfeature.png","Color":"#0a5e85","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"In Backlog","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"Assigned","Top":"10","Left":"160","TransitionStatusFieldRef":["In Progress"]},{"StatusFieldRef":"In Progress","Top":"10","Left":"310","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"Closed","Top":"10","Left":"460","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"80","Left":"10","TransitionStatusFieldRef":[]}]},"Label":"Task","Image":"type-task.png","Color":"#e68012","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"23","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"25","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedWatchers","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"0","Left":"0","TransitionStatusFieldRef":["In Backlog"]},{"StatusFieldRef":"In Backlog","Top":"0","Left":"0","TransitionStatusFieldRef":["In Sprint"]},{"StatusFieldRef":"In Sprint","Top":"0","Left":"0","TransitionStatusFieldRef":["Unassigned","Assigned","In Progress"]},{"StatusFieldRef":"Unassigned","Top":"10","Left":"460","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"Assigned","Top":"10","Left":"610","TransitionStatusFieldRef":["In Progress"]},{"StatusFieldRef":"In Progress","Top":"10","Left":"760","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"Closed","Top":"0","Left":"0","TransitionStatusFieldRef":["Reopened"]},{"StatusFieldRef":"Reopened","Top":"0","Left":"0","TransitionStatusFieldRef":["In Backlog"]}]},"Label":"Change Request","Image":"type-changerequest.png","Color":"#171517","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":21,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":6,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"23","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"25","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"PercentComplete","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":19,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateRevised","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Requirement","Item":[]},"Label":"Bug","Image":"type-bug.png","Color":"#ff0000","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('11','ENQUIRY','Customer support and enquiry management','Standard Customer Support and Enquiry management project template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Customer support and enquiry management","Description":"Standard Customer Support and Enquiry management project template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":2,"TemplateKey":"ENQUIRY","Menu":[{"PageType":1,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":1},{"PageType":2,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":2},{"PageType":9,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":3},{"PageType":20,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":4},{"PageType":19,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":5},{"PageType":8,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":6},{"PageType":7,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":7}],"CustomField":[{"Label":"Customer","ScreenLabel":"Customer","ScreenDescription":"","ScreenTooltip":"Select the customer from the list","MaxLen":0,"CanMultiSelect":true,"RegularExpression":"","Type":"L","ProjectIdFilter":true,"ShowInAttributes":true,"LookupStaticData":"Customer A\r\nCustomer B\r\nCustomer C\r\n\r\n\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Product Platform","ScreenLabel":"Product Platform (OS)","ScreenDescription":"","ScreenTooltip":"Product Platform (OS)","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"Windows 7\r\nWindows 8\r\nLinux\r\nUbuntu\r\nMac OS\r\niPad\r\n\r\n\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Needs Approval","ScreenLabel":"Needs Approval","ScreenDescription":"","ScreenTooltip":"Needs Approval","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"Y","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""}],"Priority":[{"Label":"Low","Image":"priority-low.png","Color":"#0000ff"},{"Label":"Medium","Image":"priority-medium.png","Color":"#ffffff"},{"Label":"High","Image":"priority-high.png","Color":"#eb0c1f"}],"Severity":[{"Label":"Trivial","Image":"severity-trivial.png","Color":"#1a6145"},{"Label":"Minor","Image":"severity-minor.png","Color":"#0000ff"},{"Label":"Major","Image":"severity-major.png","Color":"#8c054d"},{"Label":"Critical","Image":"severity-showstopper.png","Color":"#fa0021"}],"Status":[{"Final":false,"Label":"Escalation-Level1","Image":"test-requirements.png","Color":"#bf6a1f"},{"Final":false,"Label":"Escalation-Level2","Image":"test-stress.png","Color":"#f50a0a"},{"Final":false,"Label":"Raised","Image":"type-newfeature.png","Color":"#a0c218"},{"Final":false,"Label":"User Rejected","Image":"status-rejected.png","Color":"#754b0d"},{"Final":false,"Label":"Moved to Delivery","Image":"test-blackbox.png","Color":"#7a12a3"},{"Final":false,"Label":"Assigned","Image":"status-assigned.png","Color":"#47d119"},{"Final":true,"Label":"Closed","Image":"status-closed.png","Color":"#0f0907"},{"Final":false,"Label":"Case Reopened","Image":"status-reopened.png","Color":"#0a1c91"},{"Final":false,"Label":"User Accepted","Image":"test-acceptance.png","Color":"#541454"},{"Final":false,"Label":"Pending Approval","Image":"status-ready-for-approval.png","Color":"#787167"},{"Final":false,"Label":"Approved","Image":"status-approved.png","Color":"#099e38"}],"Resolution":[{"Final":true,"Label":"Back to Client"},{"Final":true,"Label":"Complete"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"Non-Billable"},{"Label":"Internal"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Escalation-Level1","Top":"122","Left":"284","TransitionStatusFieldRef":["Escalation-Level2"]},{"StatusFieldRef":"Escalation-Level2","Top":"33","Left":"163","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Moved to Delivery","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Raised","Top":"299","Left":"58","TransitionStatusFieldRef":["Assigned","Approved"]},{"StatusFieldRef":"User Rejected","Top":"82","Left":"494","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Assigned","Top":"308","Left":"287","TransitionStatusFieldRef":["Closed","Escalation-Level1"]},{"StatusFieldRef":"Closed","Top":"226","Left":"465","TransitionStatusFieldRef":["Case Reopened"]},{"StatusFieldRef":"Case Reopened","Top":"431","Left":"443","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"User Accepted","Top":"10","Left":"610","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Pending Approval","Top":"10","Left":"760","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Approved","Top":"454","Left":"184","TransitionStatusFieldRef":["Assigned"]}]},"Label":"Enquiry","Image":"type-investigation.png","Color":"#ffd000","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":21,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"PercentComplete","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":19,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateRevised","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Escalation-Level1","Top":"40","Left":"376","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Escalation-Level2","Top":"41","Left":"196","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Moved to Delivery","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Raised","Top":"185","Left":"62","TransitionStatusFieldRef":["Assigned","Pending Approval"]},{"StatusFieldRef":"User Rejected","Top":"63","Left":"631","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"Assigned","Top":"186","Left":"397","TransitionStatusFieldRef":["Closed","User Accepted"]},{"StatusFieldRef":"Closed","Top":"341","Left":"674","TransitionStatusFieldRef":["Case Reopened"]},{"StatusFieldRef":"Case Reopened","Top":"508","Left":"296","TransitionStatusFieldRef":["Pending Approval"]},{"StatusFieldRef":"User Accepted","Top":"188","Left":"687","TransitionStatusFieldRef":["Closed","User Rejected"]},{"StatusFieldRef":"Pending Approval","Top":"301","Left":"218","TransitionStatusFieldRef":["Approved"]},{"StatusFieldRef":"Approved","Top":"344","Left":"437","TransitionStatusFieldRef":["Assigned"]}]},"Label":"Open Issue","Image":"file-text.png","Color":"#3300ff","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"39","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"40","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Status","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"IssueKey","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedSourceControl","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Escalation-Level1","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Escalation-Level2","Top":"10","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Moved to Delivery","Top":"437","Left":"709","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"Raised","Top":"194","Left":"62","TransitionStatusFieldRef":["Pending Approval"]},{"StatusFieldRef":"User Rejected","Top":"152","Left":"441","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Assigned","Top":"281","Left":"620","TransitionStatusFieldRef":["Closed","Moved to Delivery"]},{"StatusFieldRef":"Closed","Top":"431","Left":"439","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Case Reopened","Top":"86","Left":"229","TransitionStatusFieldRef":[]},{"StatusFieldRef":"User Accepted","Top":"94","Left":"30","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Pending Approval","Top":"316","Left":"143","TransitionStatusFieldRef":["Approved"]},{"StatusFieldRef":"Approved","Top":"265","Left":"391","TransitionStatusFieldRef":["Assigned"]}]},"Label":"New Requirement","Image":"type-enhancement.png","Color":"#e612e6","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Escalation-Level1","Top":"24","Left":"37","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Escalation-Level2","Top":"10","Left":"245","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Moved to Delivery","Top":"198","Left":"478","TransitionStatusFieldRef":["User Accepted","User Rejected"]},{"StatusFieldRef":"Raised","Top":"402","Left":"88","TransitionStatusFieldRef":["Assigned","Approved","Pending Approval"]},{"StatusFieldRef":"User Rejected","Top":"142","Left":"275","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"Assigned","Top":"298","Left":"378","TransitionStatusFieldRef":["Closed","Moved to Delivery"]},{"StatusFieldRef":"Closed","Top":"287","Left":"589","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Case Reopened","Top":"80","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"User Accepted","Top":"139","Left":"652","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"Pending Approval","Top":"281","Left":"20","TransitionStatusFieldRef":["Approved"]},{"StatusFieldRef":"Approved","Top":"208","Left":"132","TransitionStatusFieldRef":["Assigned"]}]},"Label":"Task","Image":"type-task.png","Color":"#e68012","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('12','HELPDESK','Help Desk Ticketing','Standard IT help desk ticketing project template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Help Desk Ticketing","Description":"Standard IT help desk ticketing project template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":2,"TemplateKey":"HELPDESK","Menu":[{"PageType":1,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":1},{"PageType":20,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":2},{"PageType":19,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":3},{"PageType":9,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":4},{"PageType":8,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":5},{"PageType":7,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":6}],"CustomField":[{"Label":"Customer","ScreenLabel":"Customer","ScreenDescription":"Our Client name","ScreenTooltip":"Select the customer from the list","MaxLen":0,"CanMultiSelect":true,"RegularExpression":"","Type":"L","ProjectIdFilter":true,"ShowInAttributes":true,"LookupStaticData":"Customer A\r\nCustomer B\r\nCustomer C\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"User Application","ScreenLabel":"User Application","ScreenDescription":"","ScreenTooltip":"User Application","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"Peoplesoft Financials\r\nPeoplesoft HR\r\nDynamics CRM\r\nOURSYS\r\nInventory Management\r\nOther","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Product Platform","ScreenLabel":"Product Platform (OS)","ScreenDescription":"","ScreenTooltip":"Product Platform (OS)","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"Windows 7\r\nWindows 8\r\nLinux\r\nUbuntu\r\nMac OS\r\niPad\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""}],"Priority":[{"Label":"Low","Image":"priority-low.png","Color":"#0000ff"},{"Label":"Medium","Image":"priority-medium.png","Color":"#ffffff"},{"Label":"High","Image":"priority-high.png","Color":"#eb0c1f"}],"Severity":[{"Label":"Trivial","Image":"severity-trivial.png","Color":""},{"Label":"Minor","Image":"severity-minor.png","Color":"#0000ff"},{"Label":"Major","Image":"severity-major.png","Color":"#8c054d"}],"Status":[{"Final":false,"Label":"In Backlog","Image":"test-blackbox.png","Color":"#3d213d"},{"Final":false,"Label":"In Sprint","Image":"test-user.png","Color":"#337a0f"},{"Final":false,"Label":"Unassigned","Image":"status-unassigned.png","Color":"#0000ff"},{"Final":false,"Label":"Assigned","Image":"status-assigned.png","Color":"#47d119"},{"Final":false,"Label":"In Progress","Image":"status-inprogress.png","Color":"#a130a1"},{"Final":true,"Label":"Closed","Image":"status-closed.png","Color":"#ffffff"},{"Final":false,"Label":"Reopened","Image":"status-reopened.png","Color":"#0a1c91"},{"Final":false,"Label":"QA Approved","Image":"status-approved.png","Color":"#1b8f1b"},{"Final":false,"Label":"user Accepted","Image":"test-acceptance.png","Color":"#541454"},{"Final":false,"Label":"Approved","Image":"status-approved.png","Color":"#099e38"}],"Resolution":[{"Final":true,"Label":"Parked - No Further Action"},{"Final":true,"Label":"Complete"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"Non-Billable"},{"Label":"Internal"},{"Label":"Scrum Master PM"},{"Label":"Testing"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"QA Approved","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Assigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Unassigned","In Progress"]},{"StatusFieldRef":"Closed","Top":"10","Left":"310","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"460","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"217","Left":"383","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"760","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"80","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Assigned"]}]},"Label":"Investigation","Image":"type-investigation.png","Color":"#ffd000","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"30","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":21,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"PercentComplete","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":19,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateRevised","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Assigned","Top":"10","Left":"10","TransitionStatusFieldRef":["Unassigned","In Backlog","In Sprint"]},{"StatusFieldRef":"Closed","Top":"10","Left":"310","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"0","Left":"239","TransitionStatusFieldRef":["Assigned","In Sprint"]},{"StatusFieldRef":"In Progress","Top":"10","Left":"610","TransitionStatusFieldRef":["Closed","QA Approved"]},{"StatusFieldRef":"In Sprint","Top":"0","Left":"0","TransitionStatusFieldRef":["In Progress"]},{"StatusFieldRef":"QA Approved","Top":"111","Left":"655","TransitionStatusFieldRef":["user Accepted"]},{"StatusFieldRef":"Reopened","Top":"0","Left":"9","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Assigned","In Backlog"]},{"StatusFieldRef":"user Accepted","Top":"203","Left":"0","TransitionStatusFieldRef":["Closed"]}]},"Label":"Bug","Image":"type-bug.png","Color":"#ff0000","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Status","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"CalculatedTimeLogged","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Visibility","CreateScreen":false,"EditScreen":true,"ViewScreen":false},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedSourceControl","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"0","Left":"9","TransitionStatusFieldRef":["Assigned","In Progress"]},{"StatusFieldRef":"Assigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Unassigned","In Progress"]},{"StatusFieldRef":"Closed","Top":"0","Left":"0","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"460","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"0","Left":"0","TransitionStatusFieldRef":["QA Approved"]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"760","TransitionStatusFieldRef":[]},{"StatusFieldRef":"QA Approved","Top":"0","Left":"0","TransitionStatusFieldRef":["user Accepted","In Progress"]},{"StatusFieldRef":"Reopened","Top":"80","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"user Accepted","Top":"0","Left":"0","TransitionStatusFieldRef":["QA Approved","Closed"]}]},"Label":"New Requirement","Image":"type-enhancement.png","Color":"#e612e6","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedWatchers","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"New Requirement","Item":[]},"Label":"Change Request","Image":"type-changerequest.png","Color":"#171517","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"0","Left":"0","TransitionStatusFieldRef":["Assigned"]},{"StatusFieldRef":"Assigned","Top":"0","Left":"0","TransitionStatusFieldRef":["In Progress"]},{"StatusFieldRef":"Closed","Top":"0","Left":"0","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"460","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"0","Left":"0","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"760","TransitionStatusFieldRef":[]},{"StatusFieldRef":"QA Approved","Top":"80","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"80","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"0","Left":"0","TransitionStatusFieldRef":[]},{"StatusFieldRef":"user Accepted","Top":"80","Left":"460","TransitionStatusFieldRef":[]}]},"Label":"Task","Image":"type-task.png","Color":"#e68012","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('13','ISSUES','Bug and Issue Tracking','Standard Issue & Bug Tracking project template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Bug and Issue Tracking","Description":"Standard Issue & Bug Tracking project template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":2,"TemplateKey":"ISSUES","Menu":[{"PageType":1,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":1},{"PageType":2,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":2},{"PageType":9,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":3},{"PageType":19,"SeperateAfter":false,"ProjectGroups":[],"Sequence":4},{"PageType":20,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":5},{"PageType":3,"SeperateAfter":false,"ProjectGroups":[],"Sequence":6},{"PageType":5,"SeperateAfter":false,"ProjectGroups":[],"Sequence":7},{"PageType":4,"SeperateAfter":true,"ProjectGroups":[],"Sequence":8},{"PageType":7,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":9},{"PageType":8,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":10}],"CustomField":[{"Label":"Customer","ScreenLabel":"Customer","ScreenDescription":"Our Client name","ScreenTooltip":"Select the customer from the list","MaxLen":0,"CanMultiSelect":true,"RegularExpression":"","Type":"L","ProjectIdFilter":true,"ShowInAttributes":true,"LookupStaticData":"Customer A\r\nCustomer B\r\nCustomer C\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"User Application","ScreenLabel":"User Application","ScreenDescription":"","ScreenTooltip":"User Application","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"Peoplesoft Financials\r\nPeoplesoft HR\r\nDynamics CRM\r\nOURSYS\r\nInventory Management\r\nOther","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Product Platform","ScreenLabel":"Product Platform (OS)","ScreenDescription":"","ScreenTooltip":"Product Platform (OS)","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"Windows 7\r\nWindows 8\r\nLinux\r\nUbuntu\r\nMac OS\r\niPad\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""}],"Priority":[{"Label":"Low","Image":"priority-low.png","Color":"#0000ff"},{"Label":"Medium","Image":"priority-medium.png","Color":"#ffffff"},{"Label":"High","Image":"priority-high.png","Color":"#eb0c1f"}],"Severity":[{"Label":"Trivial","Image":"severity-trivial.png","Color":""},{"Label":"Minor","Image":"severity-minor.png","Color":"#0000ff"},{"Label":"Major","Image":"severity-major.png","Color":"#8c054d"}],"Status":[{"Final":false,"Label":"In Backlog","Image":"test-blackbox.png","Color":"#3d213d"},{"Final":false,"Label":"In Sprint","Image":"test-user.png","Color":"#337a0f"},{"Final":false,"Label":"Unassigned","Image":"status-unassigned.png","Color":"#0000ff"},{"Final":false,"Label":"Assigned","Image":"status-assigned.png","Color":"#47d119"},{"Final":false,"Label":"In Progress","Image":"status-inprogress.png","Color":"#a130a1"},{"Final":true,"Label":"Closed","Image":"status-closed.png","Color":"#ffffff"},{"Final":false,"Label":"Reopened","Image":"status-reopened.png","Color":"#0a1c91"},{"Final":false,"Label":"Approved","Image":"status-approved.png","Color":""}],"Resolution":[{"Final":true,"Label":"Parked - No Further Action"},{"Final":true,"Label":"Complete"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"Non-Billable"},{"Label":"Internal"},{"Label":"Scrum Master PM"},{"Label":"Testing"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"26","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"28","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Assigned","Top":"0","Left":"9","TransitionStatusFieldRef":["In Progress","Closed"]},{"StatusFieldRef":"Closed","Top":"407","Left":"0","TransitionStatusFieldRef":["Reopened"]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"310","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"0","Left":"577","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"610","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"41","Left":"151","TransitionStatusFieldRef":["Assigned","Unassigned"]},{"StatusFieldRef":"Unassigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Assigned"]}]},"Label":"Investigation","Image":"type-investigation.png","Color":"#ffd000","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"30","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":21,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":false},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"PercentComplete","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":19,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateRevised","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Investigation","Item":[]},"Label":"Bug","Image":"type-bug.png","Color":"#ff0000","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Status","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"CalculatedTimeLogged","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Visibility","CreateScreen":false,"EditScreen":true,"ViewScreen":false},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedSourceControl","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"10","Left":"10","TransitionStatusFieldRef":["Assigned","Unassigned"]},{"StatusFieldRef":"Assigned","Top":"10","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Closed","Top":"10","Left":"310","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"460","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"0","Left":"0","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"760","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"80","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"80","Left":"160","TransitionStatusFieldRef":["In Progress","Assigned"]}]},"Label":"New Requirement","Image":"type-enhancement.png","Color":"#e612e6","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":22,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedWatchers","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"New Requirement","Item":[]},"Label":"Change Request","Image":"type-changerequest.png","Color":"#171517","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"10","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Assigned","Top":"0","Left":"0","TransitionStatusFieldRef":["Closed","Unassigned","In Progress"]},{"StatusFieldRef":"Closed","Top":"10","Left":"310","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Backlog","Top":"10","Left":"460","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"0","Left":"0","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"In Sprint","Top":"10","Left":"760","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"9","Left":"0","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Unassigned","Top":"80","Left":"160","TransitionStatusFieldRef":["Assigned"]}]},"Label":"Task","Image":"type-task.png","Color":"#e68012","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('14','MARKETING','Marketing team management','Standard Marketing project template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Marketing team management","Description":"Standard Marketing project template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":1,"TemplateKey":"MARKETING","Menu":[{"PageType":2,"SeperateAfter":false,"ProjectGroups":[2],"Sequence":1},{"PageType":3,"SeperateAfter":true,"ProjectGroups":[2],"Sequence":2},{"PageType":1,"SeperateAfter":true,"ProjectGroups":[2],"Sequence":3},{"PageType":20,"SeperateAfter":false,"ProjectGroups":[2],"Sequence":4},{"PageType":8,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":5}],"CustomField":[{"Label":"Owner","ScreenLabel":"Owner","ScreenDescription":"Who ownes it?","ScreenTooltip":"Select the owner from the list","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":false,"LookupStaticData":"N/A\r\nMe\r\nYou\r\nSome Else\r\n\r\n\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Agencies","ScreenLabel":"Agencies","ScreenDescription":"","ScreenTooltip":"Agencies Involved","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"N/A\r\nMRM Worldwide\r\nMcann\r\nOgilvy and Mather\r\nSaatchi and Saatchi\r\nJelabi\r\nJellbean Creative\r\nOther","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Budget Approved","ScreenLabel":"Budget Approved","ScreenDescription":"","ScreenTooltip":"Budget Approver","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"Y","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""}],"Priority":[{"Label":"High","Image":"priority-high.png","Color":"#a30d21"},{"Label":"Low","Image":"priority-low.png","Color":"#0000ff"},{"Label":"Medium","Image":"priority-medium.png","Color":"#161670"}],"Severity":[{"Label":"Minor","Image":"severity-minor.png","Color":"#0000ff"},{"Label":"Major","Image":"severity-major.png","Color":"#a80a31"}],"Status":[{"Final":true,"Label":"Planned","Image":"status-assigned.png","Color":"#16b821"},{"Final":false,"Label":"In Progress","Image":"status-inprogress.png","Color":"#941894"},{"Final":false,"Label":"Completed","Image":"status-closed.png","Color":"#c7bf2a"},{"Final":false,"Label":"Parked","Image":"status-postponed.png","Color":"#5e105e"}],"Resolution":[{"Final":false,"Label":"Unresolved"},{"Final":true,"Label":"Complete"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"non-billable"},{"Label":"Internal"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"44","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"14","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"43","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Completed","Top":"219","Left":"538","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"241","Left":"275","TransitionStatusFieldRef":["Completed","Parked","Planned"]},{"StatusFieldRef":"Parked","Top":"10","Left":"310","TransitionStatusFieldRef":["Planned"]},{"StatusFieldRef":"Planned","Top":"229","Left":"80","TransitionStatusFieldRef":["In Progress"]}]},"Label":"Campaign","Image":"type-enhancement.png","Color":"#b31bb3","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Campaign","Item":[]},"Label":"Task","Image":"type-task.png","Color":"#522c52","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('15','REQUIREMENTS','Requirements capture and management','Standard business requirements capture and management project template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Requirements capture and management","Description":"Standard business requirements capture and management project template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":2,"TemplateKey":"REQUIREMENTS","Menu":[{"PageType":1,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":1},{"PageType":2,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":2},{"PageType":3,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":3},{"PageType":4,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":4},{"PageType":19,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":5}],"CustomField":[{"Label":"Customer","ScreenLabel":"Customer","ScreenDescription":"Our Client name","ScreenTooltip":"Select the customer from the list","MaxLen":0,"CanMultiSelect":true,"RegularExpression":"","Type":"C","ProjectIdFilter":true,"ShowInAttributes":true,"LookupStaticData":"Customer A\r\nCustomer B\r\nCustomer C\r\n\r\n\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Customer Backlog ID","ScreenLabel":"Customer Backlog ID","ScreenDescription":"","ScreenTooltip":"Customer Backlog ID","MaxLen":12,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"BACKLOG A\r\nBACKLOG B\r\nBACKLOG C\r\nBACKLOG D\r\nBACKLOG E","MaxValue":999.0,"MinValue":0.0,"ListLimiter":""}],"Priority":[{"Label":"Low","Image":"priority-low.png","Color":"#0000ff"},{"Label":"Medium","Image":"priority-medium.png","Color":"#ffffff"},{"Label":"High","Image":"priority-high.png","Color":"#eb0c1f"}],"Severity":[{"Label":"Trivial","Image":"severity-trivial.png","Color":""},{"Label":"Minor","Image":"severity-minor.png","Color":"#0000ff"},{"Label":"Major","Image":"severity-major.png","Color":"#8c054d"}],"Status":[{"Final":false,"Label":"Approved","Image":"status-approved.png","Color":"#36a820"},{"Final":false,"Label":"In Backlog","Image":"test-blackbox.png","Color":"#3d213d"},{"Final":false,"Label":"In Sprint","Image":"test-user.png","Color":"#337a0f"},{"Final":false,"Label":"Requirement","Image":"status-unassigned.png","Color":"#0000ff"},{"Final":false,"Label":"Walkthrough","Image":"status-assigned.png","Color":"#47d119"},{"Final":true,"Label":"Closed","Image":"status-closed.png","Color":"#ffffff"},{"Final":false,"Label":"Reopened","Image":"status-reopened.png","Color":"#0a1c91"},{"Final":false,"Label":"In Progress","Image":"status-inprogress.png","Color":"#8c3d8c"}],"Resolution":[{"Final":true,"Label":"Parked - No Further Action"},{"Final":true,"Label":"Complete"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"Non-Billable"},{"Label":"Internal"},{"Label":"Scrum Master PM"},{"Label":"Testing"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"45","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"46","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"CalculatedTimeLogged","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Visibility","CreateScreen":false,"EditScreen":true,"ViewScreen":false},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"28FE1D91-7730-4067-8A10-F452FCB9D090","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"212","Left":"535","TransitionStatusFieldRef":["In Backlog","Requirement"]},{"StatusFieldRef":"Closed","Top":"191","Left":"62","TransitionStatusFieldRef":["Reopened"]},{"StatusFieldRef":"In Backlog","Top":"410","Left":"351","TransitionStatusFieldRef":["In Sprint"]},{"StatusFieldRef":"In Sprint","Top":"375","Left":"45","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"Reopened","Top":"229","Left":"298","TransitionStatusFieldRef":["Requirement"]},{"StatusFieldRef":"Requirement","Top":"25","Left":"98","TransitionStatusFieldRef":["Closed","Walkthrough"]},{"StatusFieldRef":"Walkthrough","Top":"35","Left":"349","TransitionStatusFieldRef":["Approved"]}]},"Label":"Requirement","Image":"type-enhancement.png","Color":"#e612e6","Tag":""},{"TheScreen":{"UseFromProcessRef":"Requirement","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":1,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":35,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"45","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":true,"IsExternalWidgetField":false,"ExternalFieldRef":"46","CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"CalculatedTimeLogged","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":5,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"Visibility","CreateScreen":false,"EditScreen":true,"ViewScreen":false},{"InternalField":18,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"DateCreated","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHierarchy","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedLinks","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"28FE1D91-7730-4067-8A10-F452FCB9D090","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Requirement","Item":[]},"Label":"Story","Image":"type-newfeature.png","Color":"#0a5e85","Tag":""},{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":false,"ViewScreen":false},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":16,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":true,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Approved","Top":"189","Left":"202","TransitionStatusFieldRef":["In Progress"]},{"StatusFieldRef":"Closed","Top":"211","Left":"553","TransitionStatusFieldRef":["Reopened"]},{"StatusFieldRef":"In Backlog","Top":"264","Left":"10","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"385","Left":"152","TransitionStatusFieldRef":["Closed"]},{"StatusFieldRef":"In Sprint","Top":"22","Left":"176","TransitionStatusFieldRef":[]},{"StatusFieldRef":"Reopened","Top":"92","Left":"628","TransitionStatusFieldRef":["Requirement"]},{"StatusFieldRef":"Requirement","Top":"84","Left":"328","TransitionStatusFieldRef":["Approved"]},{"StatusFieldRef":"Walkthrough","Top":"438","Left":"560","TransitionStatusFieldRef":[]}]},"Label":"Task","Image":"type-task.png","Color":"#e68012","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
INSERT gemini_projecttemplate(templateid,templatekey,title,descrip,author,published,versionnumber,template) VALUES('16','SENTRY','Testing and QA management','Sentry for Gemini Testing (Quality Assurance) template','Countersoft',convert(datetime,'2012-07-03 11:54:07.000',121),'1.0.0','{"Name":"Testing and QA management","Description":"Sentry for Gemini Testing (Quality Assurance) template","Publisher":"Countersoft","Published":"2012-07-03T11:54:07.9423439+01:00","Version":"1.0.0","HomePage":1,"TemplateKey":"SENTRY","Menu":[{"PageType":1,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":1},{"PageType":2,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":2},{"PageType":9,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":3},{"PageType":19,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":4},{"PageType":20,"SeperateAfter":true,"ProjectGroups":[1],"Sequence":5},{"PageType":8,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":6},{"PageType":7,"SeperateAfter":false,"ProjectGroups":[1],"Sequence":7}],"CustomField":[{"Label":"Client/Project","ScreenLabel":"Client/Project","ScreenDescription":"","ScreenTooltip":"Client/Project","MaxLen":0,"CanMultiSelect":false,"RegularExpression":"","Type":"C","ProjectIdFilter":false,"ShowInAttributes":false,"LookupStaticData":"N/A\r\nClient A - Project A\r\nClient A - Project B\r\nClient A - Project C\r\nClient B - Project 1\r\nClient B - Project 2\r\nClient C\r\nClient D\r\n\r\n                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":""},{"Label":"Affected User(s)","ScreenLabel":"Affected User(s)","ScreenDescription":"","ScreenTooltip":"Affected User(s)","MaxLen":0,"CanMultiSelect":true,"RegularExpression":"","Type":"U","ProjectIdFilter":false,"ShowInAttributes":true,"LookupStaticData":"                        \r\n                    ","MaxValue":0.0,"MinValue":0.0,"ListLimiter":"4|"}],"Priority":[{"Label":"High","Image":"priority-high.png","Color":"#e81717"},{"Label":"Low","Image":"priority-low.png","Color":"#b8b8e6"},{"Label":"Medium","Image":"priority-medium.png","Color":"#c7732a"}],"Severity":[{"Label":"Minor","Image":"severity-minor.png","Color":"#9595d6"},{"Label":"Major","Image":"severity-major.png","Color":"#bd20bd"},{"Label":"Critical","Image":"severity-showstopper.png","Color":"#e80523"}],"Status":[{"Final":true,"Label":"Reported","Image":"test-smoke.png","Color":"#177d4b"},{"Final":false,"Label":"Planned","Image":"test-installation.png","Color":"#2a0aa8"},{"Final":false,"Label":"In Progress","Image":"test-functional.png","Color":"#1f9970"},{"Final":false,"Label":"Accepted","Image":"test-acceptance.png","Color":"#8a0f8a"},{"Final":false,"Label":"Rejected","Image":"status-rejected.png","Color":"#e60330"},{"Final":false,"Label":"Production Ready","Image":"type-enhancement.png","Color":"#2e292e"},{"Final":false,"Label":"Deployed","Image":"test-unit.png","Color":"#64cf3a"}],"Resolution":[{"Final":false,"Label":"Unresolved"},{"Final":true,"Label":"Resolved"}],"Link":[{"Label":"Duplicated"},{"Label":"Related"}],"Time":[{"Label":"Billable"},{"Label":"Non-billable"},{"Label":"Internal"}],"Process":[{"TheScreen":{"UseFromProcessRef":"","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":6,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":20,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"617F1435-C0AA-48E6-B6A9-2C1F756E02A6","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"D8DECEB7-BA6D-4A3F-A4A7-C79A5A5585BA","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"AC93C4F9-B512-4A3D-8B37-BC3D5F83429D","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"598B4999-4C31-427D-9BBC-C84AD954E55A","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"15627A0F-5AD2-4D35-BF24-60D678F59354","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"EFEE5D50-7DF6-49C3-9D69-E7EFC1AFEF72","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"ACE2F8B3-C724-444F-9B72-B8B2137DDA16","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":38,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedAttachments","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"","Item":[{"StatusFieldRef":"Accepted","Top":"143","Left":"332","TransitionStatusFieldRef":["Production Ready"]},{"StatusFieldRef":"Deployed","Top":"10","Left":"160","TransitionStatusFieldRef":[]},{"StatusFieldRef":"In Progress","Top":"227","Left":"394","TransitionStatusFieldRef":["Planned","Accepted","Rejected"]},{"StatusFieldRef":"Planned","Top":"360","Left":"399","TransitionStatusFieldRef":["In Progress"]},{"StatusFieldRef":"Production Ready","Top":"20","Left":"445","TransitionStatusFieldRef":["Deployed","Rejected"]},{"StatusFieldRef":"Rejected","Top":"10","Left":"760","TransitionStatusFieldRef":["Planned"]},{"StatusFieldRef":"Reported","Top":"317","Left":"173","TransitionStatusFieldRef":["Planned"]}]},"Label":"Test Component","Image":"test-component.png","Color":"#39469e","Tag":""},{"TheScreen":{"UseFromProcessRef":"Test Component","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":6,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":20,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"22a60376-af46-4a58-8f59-da6a3c010cfd","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"617F1435-C0AA-48E6-B6A9-2C1F756E02A6","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"D8DECEB7-BA6D-4A3F-A4A7-C79A5A5585BA","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"AC93C4F9-B512-4A3D-8B37-BC3D5F83429D","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"598B4999-4C31-427D-9BBC-C84AD954E55A","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"15627A0F-5AD2-4D35-BF24-60D678F59354","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"EFEE5D50-7DF6-49C3-9D69-E7EFC1AFEF72","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"ACE2F8B3-C724-444F-9B72-B8B2137DDA16","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Test Component","Item":[]},"Label":"Regression Test","Image":"test-regression.png","Color":"#8a298a","Tag":""},{"TheScreen":{"UseFromProcessRef":"Test Component","Item":[{"InternalField":8,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":3,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":9,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":4,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":10,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":2,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":14,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":23,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":13,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":40,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":12,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":6,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":30,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":17,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":15,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":42,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":39,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":11,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":20,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":7,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":24,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":34,"IsExternalCustomField":false,"IsExternalWidgetField":false,"CreateScreen":true,"EditScreen":true,"ViewScreen":true},{"InternalField":36,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedComments","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":37,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedHistory","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"22a60376-af46-4a58-8f59-da6a3c010cfd","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"617F1435-C0AA-48E6-B6A9-2C1F756E02A6","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"D8DECEB7-BA6D-4A3F-A4A7-C79A5A5585BA","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"AC93C4F9-B512-4A3D-8B37-BC3D5F83429D","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"598B4999-4C31-427D-9BBC-C84AD954E55A","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"15627A0F-5AD2-4D35-BF24-60D678F59354","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"EFEE5D50-7DF6-49C3-9D69-E7EFC1AFEF72","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":0,"IsExternalCustomField":false,"IsExternalWidgetField":true,"ExternalFieldRef":"ACE2F8B3-C724-444F-9B72-B8B2137DDA16","CreateScreen":false,"EditScreen":false,"ViewScreen":true},{"InternalField":33,"IsExternalCustomField":false,"IsExternalWidgetField":false,"ExternalFieldRef":"AssociatedTime","CreateScreen":false,"EditScreen":false,"ViewScreen":true}]},"TheWorkflow":{"UseFromProcessRef":"Test Component","Item":[]},"Label":"Test Bug","Image":"type-bug.png","Color":"#ff0000","Tag":""}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-07-03T10:54:06.1482413Z","Revised":"2012-07-03T10:54:06.1482413Z","Errors":[],"HasErrors":false,"Id":0}')
SET IDENTITY_INSERT gemini_projecttemplate OFF
GO

/* Global Security Scheme */
CREATE TABLE gemini_globalsecurityschemes
(
	schemeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_globalsecurityschemes_schemeid_pk PRIMARY KEY,
	schemename nvarchar(500) NOT NULL CONSTRAINT gemini_globalsecurityschemes_schemename_def DEFAULT (''),
	schemedesc nvarchar(1000) NOT NULL CONSTRAINT gemini_globalsecurityschemes_schemedesc_def DEFAULT (''),
	created DATETIME NOT NULL CONSTRAINT gemini_globalsecurityschemes_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Global Security Scheme Roles */
CREATE TABLE gemini_globalsecurityschemeroles
(
	schemeroleid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_globalsecurityschemeroles_schemeroleid_pk PRIMARY KEY,
	schemeid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_globalsecurityschemeroles_schemeid_fk REFERENCES gemini_globalsecurityschemes(schemeid),
	schemerole NUMERIC(10,0) NOT NULL,
	memberid NUMERIC(10,0) NOT NULL, 
	membertype NUMERIC(10,0) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_globalsecurityschemeroles_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_globalsecurityschemeroles_schemeid ON gemini_globalsecurityschemeroles(schemeid)
CREATE INDEX ind_gemini_globalsecurityschemeroles_schemerole ON gemini_globalsecurityschemeroles(schemeid,schemerole)
CREATE INDEX ind_gemini_globalsecurityschemeroles_membertype ON gemini_globalsecurityschemeroles(membertype)

/* Users */
CREATE TABLE gemini_users
(
	userid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_userid_userid_pk PRIMARY KEY,
	username NVARCHAR(255) NOT NULL CONSTRAINT gemini_users_username_def DEFAULT(''),
	openid NVARCHAR(500) NOT NULL CONSTRAINT gemini_users_openid_def DEFAULT(''),
	firstname NVARCHAR(255) NOT NULL CONSTRAINT gemini_users_firstname_def DEFAULT(''),
	surname NVARCHAR(255) NOT NULL CONSTRAINT gemini_users_surname_def DEFAULT(''),
	pwd BINARY(16),
	emailaddress NVARCHAR(255) NOT NULL CONSTRAINT gemini_users_emailaddress_def DEFAULT(''),
	roles NVARCHAR(255) NOT NULL CONSTRAINT gemini_users_roles_def DEFAULT(''),
	resetpwd VARBINARY(16) NULL,
	comment NVARCHAR(500) NOT NULL CONSTRAINT gemini_users_comment_def DEFAULT(''),
	apikey VARCHAR(50) NOT NULL CONSTRAINT gemini_users_apikey_def DEFAULT(''),
	timezoneid VARCHAR(100) NOT NULL CONSTRAINT gemini_users_timezoneid_def DEFAULT(''),
	culture VARCHAR(50) NOT NULL CONSTRAINT gemini_users_culture_def DEFAULT(''),
	languageid VARCHAR(50) NOT NULL CONSTRAINT gemini_users_languageid_def DEFAULT('en-US'),
	theme VARCHAR(50) NOT NULL CONSTRAINT gemini_users_theme_def DEFAULT(''),
	emailme bit NOT NULL CONSTRAINT gemini_users_emailme_def DEFAULT(1),
	emailmemychanges bit NOT NULL CONSTRAINT gemini_users_emailmemychanges_def DEFAULT(1),	
	settings NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_users_settings_def DEFAULT(''),
	active bit NOT NULL CONSTRAINT gemini_users_active_def DEFAULT(1),
	created DATETIME NOT NULL CONSTRAINT gemini_users_created_def DEFAULT GETUTCDATE(),
	lastupdated DATETIME NOT NULL CONSTRAINT gemini_users_lastupdated_def DEFAULT GETUTCDATE(),
	logindate DATETIME NOT NULL CONSTRAINT gemini_users_logindate_def DEFAULT GETUTCDATE(),
	previouslogindate DATETIME NOT NULL CONSTRAINT gemini_users_previouslogindate_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE UNIQUE INDEX uind_gemini_users_username ON gemini_users(username)

INSERT INTO gemini_users (username,firstname,surname,pwd,emailaddress,roles)
	VALUES (N'admin',N'Jon',N'Smith',0x21232F297A57A5A743894A0E4A801FC3,N'jon@smith.com',N'G!')

DELETE FROM gemini_users WHERE userid=-1

SET IDENTITY_INSERT gemini_users ON
INSERT INTO gemini_users (userid,username,firstname,surname,pwd,emailaddress)
	VALUES (-1,N'anon',N'* Anonymous',N'User *',0x2AE66F90B7788AB8950E8F81B829C947,N'anon@anon.com')
SET IDENTITY_INSERT gemini_users OFF


CREATE TABLE gemini_userinteractiongroups
(
	userinteractiongroupid INT IDENTITY(1,1) CONSTRAINT gemini_userinteractiongroups_userinteractiongroupid_pk PRIMARY KEY,
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_userinteractiongroups_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	memberid NUMERIC(10,0) NOT NULL, 
	membertype NUMERIC(10,0) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_userinteractiongroups_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_userinteractiongroups_userid ON gemini_userinteractiongroups(userid)

/* Issue Types */
CREATE TABLE gemini_issuetypes
(
	typeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuetypes_typeid_pk PRIMARY KEY,
	seq NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuetypes_seq_def DEFAULT(0),
	typedesc NVARCHAR(100) NOT NULL,
	imagepath NVARCHAR(100) NOT NULL,
	color varchar(20) NOT NULL CONSTRAINT gemini_issuetypes_color_def DEFAULT('#A9A9A9'),
	tag VARCHAR(50) NOT NULL CONSTRAINT gemini_issuetypes_tag_def DEFAULT(''),
	templateid INT NOT NULL CONSTRAINT gemini_issuetypes_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	screen NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_issuetypes_screen_def DEFAULT(''),
	workflow NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_issuetypes_workflow_def DEFAULT(''),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issuetypes_desc ON gemini_issuetypes(typedesc)

/* Issue Priority */
CREATE TABLE gemini_issuepriorities
(
	priorityid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuepriorities_priorityid_pk PRIMARY KEY NONCLUSTERED,
	seq NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuepriorities_seq_def DEFAULT(0),
	prioritydesc NVARCHAR(100) NOT NULL,
	imagepath NVARCHAR(100) NOT NULL,
	color varchar(20) NOT NULL CONSTRAINT gemini_issuepriorities_color_def DEFAULT('#A9A9A9'),
	templateid INT NOT NULL CONSTRAINT gemini_issuepriorities_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	tstamp TIMESTAMP NOT NULL
)
CREATE UNIQUE INDEX ind_gemini_issuepriorities_id ON gemini_issuepriorities(priorityid)
CREATE INDEX ind_gemini_issuepriorities_desc ON gemini_issuepriorities(prioritydesc)

/* Issue Severity */
CREATE TABLE gemini_issueseverity
(
	severityid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issueseverity_severityid_pk PRIMARY KEY NONCLUSTERED,
	seq NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueseverity_seq_def DEFAULT(0),
	severitydesc NVARCHAR(100) NOT NULL,
	imagepath NVARCHAR(100) NOT NULL,
	color varchar(20) NOT NULL CONSTRAINT gemini_issueseverity_color_def DEFAULT('#A9A9A9'),
	templateid INT NOT NULL  CONSTRAINT gemini_issueseverity_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	tstamp TIMESTAMP NOT NULL
)
CREATE UNIQUE INDEX ind_gemini_issueseverity_id ON gemini_issueseverity(severityid)
CREATE INDEX ind_gemini_issueseverity_desc ON gemini_issueseverity(severitydesc)

/* Issue Status */
CREATE TABLE gemini_issuestatus
(
	statusid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuestatus_statusid_pk PRIMARY KEY,
	isfinal bit NOT NULL CONSTRAINT gemini_issuestatus_isfinal_def DEFAULT(0),
	statusdesc NVARCHAR(200) NOT NULL,
	statustype int NOT NULL CONSTRAINT gemini_issuestatus_statustype_def DEFAULT(0),
	imagepath NVARCHAR(200) NOT NULL,
	comment NVARCHAR(500) NOT NULL,
	color varchar(20) NOT NULL CONSTRAINT gemini_issuestatus_color_def DEFAULT('#A9A9A9'),
	seq INT NOT NULL CONSTRAINT gemini_issuestatus_seq_def DEFAULT(0),
	templateid INT NOT NULL CONSTRAINT gemini_issuestatus_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	tstamp TIMESTAMP NOT NULL
)
GO
CREATE UNIQUE INDEX ind_gemini_issuestatus_id ON gemini_issuestatus(statusid)
CREATE INDEX ind_gemini_issuestatus_desc ON gemini_issuestatus(statusdesc)

/* Project Labels */
CREATE TABLE gemini_projectlabels
(
	labelid NUMERIC(10,0) NOT NULL IDENTITY(1,1) CONSTRAINT gemini_projectlabels_appointment_pk PRIMARY KEY,
	labelname NVARCHAR(100) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_projectlabels_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Projects */
CREATE TABLE gemini_projects
(
	projectid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projects_projectid_pk PRIMARY KEY,
	projectcode NVARCHAR(10) NOT NULL CONSTRAINT gemini_projects_projectcode_def DEFAULT (''),
	projectname NVARCHAR(100) NOT NULL CONSTRAINT gemini_projects_projectname_def DEFAULT (''),
	projectleader NVARCHAR(100) NOT NULL CONSTRAINT gemini_projects_projectleader_def DEFAULT (''),
	projectdesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_projects_projectdesc_def DEFAULT (''),
	projectreadonly BIT NOT NULL CONSTRAINT gemini_projects_projectreadonly_def DEFAULT(0),
	projectarchived BIT NOT NULL CONSTRAINT gemini_projects_projectarchived_def DEFAULT(0),
	projectlabelid NUMERIC(10, 0) NULL CONSTRAINT gemini_projects_labelid_fk FOREIGN KEY REFERENCES gemini_projectlabels(labelid),
	schemeid NUMERIC(10,0) null,
	resourcemode NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projects_resourcemode_def DEFAULT(0),
	componentmode NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projects_componentmode_def DEFAULT(0),
	globalschemeid NUMERIC(10,0) NULL CONSTRAINT gemini_projects_globalschemeid_fk FOREIGN KEY REFERENCES gemini_globalsecurityschemes(schemeid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projects_userid_def DEFAULT(-1) CONSTRAINT gemini_projects_userid_fk REFERENCES gemini_users(userid),
	color varchar(20) NOT NULL CONSTRAINT gemini_projects_color_def DEFAULT('#A9A9A9'),
	templateid INT NOT NULL CONSTRAINT gemini_projects_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),	
	options NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_projects_options_def DEFAULT(''),
	created DATETIME NOT NULL CONSTRAINT gemini_projects_creared_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Appointments */
CREATE TABLE gemini_appointments
(
	appointmentid NUMERIC(10,0) NOT NULL IDENTITY(1,1) CONSTRAINT gemini_appointments_appointment_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_appointments_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	subject NVARCHAR(2000) NOT NULL,
	startdate DATETIME NULL,
	enddate DATETIME NULL,
	recurrencerule NVARCHAR(500) NULL,
	recurrencestate INT NULL,
	userid NUMERIC(10,0) NULL CONSTRAINT gemini_appointments_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_appointments_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_appointments_projectid ON gemini_appointments(projectid)

/* Versions */
CREATE TABLE gemini_versions
(
	versionid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_versions_versionid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_versions_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	versionnumber NVARCHAR(100) NOT NULL CONSTRAINT gemini_versions_versionnumber_def DEFAULT (''),
	versionname NVARCHAR(100) NOT NULL CONSTRAINT gemini_versions_versionname_def DEFAULT (''),
	versiondesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_versions_versiondesc_def DEFAULT (''),
	versionreleased BIT NOT NULL CONSTRAINT gemini_versions_versionreleased_def DEFAULT (0),
	versionorder INTEGER NOT NULL CONSTRAINT gemini_versions_versionorder_def DEFAULT (0),
	versionarchived BIT NOT NULL CONSTRAINT gemini_versions_versionarchived_def DEFAULT (0),
	parentversionid NUMERIC(10, 0) NULL CONSTRAINT gemini_versions_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid),
	startdate DATETIME NULL CONSTRAINT gemini_versions_startdate_def DEFAULT GETUTCDATE(),
	releasedate DATETIME NULL CONSTRAINT gemini_versions_releasedate_def DEFAULT DATEADD (month,2,GETUTCDATE() ),
	created DATETIME NOT NULL CONSTRAINT gemini_versions_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL,	
)
CREATE INDEX ind_gemini_versions_projectid ON gemini_versions(projectid)
CREATE INDEX ind_gemini_versions_versionprojectid ON gemini_versions(versionid,projectid)
CREATE INDEX ind_gemini_versions_versionnumber ON gemini_versions(versionnumber)

/* Components */
CREATE TABLE gemini_components
(
	componentid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_components_componentid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_components_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	componentname NVARCHAR(100) NOT NULL CONSTRAINT gemini_components_componentname_def DEFAULT (''),
	componentdesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_components_componentdesc_def DEFAULT (''),
	componentreadonly BIT NOT NULL CONSTRAINT gemini_components_componentreadonly_def DEFAULT(0),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_components_userid_def DEFAULT(-1) CONSTRAINT gemini_components_userid_fk REFERENCES gemini_users(userid),
	parentcomponentid NUMERIC(10, 0) NULL CONSTRAINT gemini_components_componentid_fk FOREIGN KEY REFERENCES gemini_components(componentid),
	componentorder INT NOT NULL CONSTRAINT gemini_components_componentorder_def  DEFAULT(0),
	created DATETIME NOT NULL CONSTRAINT gemini_components_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_components_projectid ON gemini_components(projectid)

/* Issue Resolution */
CREATE TABLE gemini_issueresolutions
(
	resolutionid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issueresolutions_resolutionid_pk PRIMARY KEY,
	seq NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueresolutions_seq_def DEFAULT(0),
	isfinal BIT NOT NULL CONSTRAINT gemini_issueresolutions_isfinal_def DEFAULT(0),
	resdesc NVARCHAR(100) NOT NULL,
	templateid INT NOT NULL CONSTRAINT gemini_issueresolutions_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issueresolutions_seq ON gemini_issueresolutions(seq)


/* Issues */
CREATE TABLE gemini_issues
(
	issueid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issues_issueid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
		
	reportedby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_reportedby_fk FOREIGN KEY REFERENCES gemini_users(userid),

	mailboxid NUMERIC(10, 0) NULL,
	originatortype NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_originatortype_def DEFAULT(0),
	originatorreply NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_originatorreply_def DEFAULT(0),
	originatordata NVARCHAR(255) NULL,
	originatorprocessed DATETIME,

	isparent BIT NOT NULL CONSTRAINT gemini_issues_isparent_def DEFAULT(0),
	parentissueid NUMERIC(10,0) NULL CONSTRAINT gemini_issues_parentissueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	hierarchykey VARCHAR(255) NOT NULL CONSTRAINT gemini_issues_hierarchykey_def DEFAULT(''),
	repeated NVARCHAR(255) NOT NULL CONSTRAINT gemini_issues_repeated_def DEFAULT(''),

	fixedinversionid NUMERIC(10,0) NULL CONSTRAINT gemini_issues_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid),
	issuetypeid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_issuetypeid_fk FOREIGN KEY REFERENCES gemini_issuetypes(typeid),
	issuepriorityid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_issuepriorityid_fk FOREIGN KEY REFERENCES gemini_issuepriorities(priorityid),
	issueseverityid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_issueseverityid_fk FOREIGN KEY REFERENCES gemini_issueseverity(severityid),
	issuestatusid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_issuestatusid_fk FOREIGN KEY REFERENCES gemini_issuestatus(statusid),
	issueresolutionid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_issueresolutionid_fk FOREIGN KEY REFERENCES gemini_issueresolutions(resolutionid),
	
	affectedversions VARCHAR(1000) NOT NULL CONSTRAINT gemini_issues_affectedversions_def DEFAULT (''),
	resources VARCHAR(1000) NOT NULL CONSTRAINT gemini_issues_resources_def DEFAULT (''),
	components VARCHAR(1000) NOT NULL CONSTRAINT gemini_issues_components_def DEFAULT (''),
	watchers VARCHAR(1000) NOT NULL CONSTRAINT gemini_issues_watchers_def DEFAULT (''),
	votes INT NOT NULL CONSTRAINT gemini_issues_votes_def DEFAULT (0),
	points INT NOT NULL CONSTRAINT gemini_issues_points_def DEFAULT (0),
	
	percentcomplete INT NOT NULL CONSTRAINT gemini_issues_percentcomplete_def DEFAULT (0),
	loggedhours INT NOT NULL CONSTRAINT gemini_issues_loggedhours_def  DEFAULT (0),
	loggedminutes INT NOT NULL CONSTRAINT gemini_issues_loggedminutes_def DEFAULT (0),
	
	estimatehours NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_estimatedhours_def DEFAULT(0),
	estimateminutes NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_estimatedminutes_def DEFAULT(0),
	
	visibility NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issues_visibility_def DEFAULT(1),
	
	summary NVARCHAR(255) NOT NULL CONSTRAINT gemini_issues_summary_def DEFAULT (''),
	longdesc NVARCHAR(MAX),

	userdata1 NVARCHAR(255) NOT NULL CONSTRAINT gemini_issues_userdata1_def DEFAULT (''),
	userdata2 NVARCHAR(255) NOT NULL CONSTRAINT gemini_issues_userdata2_def DEFAULT (''),
	userdata3 NVARCHAR(255) NOT NULL CONSTRAINT gemini_issues_userdata3_def DEFAULT (''),
	startdate DATETIME NULL,
	duedate DATETIME NULL,
	resolveddate DATETIME, 
	closeddate DATETIME,
		
	revised DATETIME NOT NULL CONSTRAINT gemini_issues_revised_def DEFAULT GETUTCDATE(),
	created DATETIME NOT NULL CONSTRAINT gemini_issues_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issues_projectid ON gemini_issues(projectid)
CREATE INDEX ind_gemini_issues_fixedinversionid ON gemini_issues(fixedinversionid)
CREATE INDEX ind_gemini_issues_visibility ON gemini_issues(visibility)
CREATE INDEX ind_gemini_issues_parentissueid ON gemini_issues(parentissueid)
CREATE INDEX ind_gemini_issues_issuepriorityid ON gemini_issues(issuepriorityid)
CREATE INDEX ind_gemini_issues_issuetypeid ON gemini_issues(issuetypeid)
CREATE INDEX ind_gemini_issues_issueseverityid ON gemini_issues(issueseverityid)
CREATE INDEX ind_gemini_issues_reportedby ON gemini_issues(reportedby)
CREATE INDEX ind_gemini_issues_issuestatusid ON gemini_issues(issuestatusid)
CREATE INDEX ind_gemini_issues_issueresolutionid ON gemini_issues(issueresolutionid)
CREATE INDEX ind_gemini_issues_created ON gemini_issues(created)
CREATE INDEX ind_gemini_issues_revised ON gemini_issues(revised)
CREATE INDEX ind_gemini_issues_startdate ON gemini_issues(startdate)
CREATE INDEX ind_gemini_issues_duedate ON gemini_issues(duedate)
CREATE INDEX ind_gemini_issues_closeddate ON gemini_issues(closeddate)
CREATE INDEX ind_gemini_issues_estimateminutes ON gemini_issues(estimateminutes)
CREATE INDEX ind_gemini_issues_estimatehours ON gemini_issues(estimatehours)
CREATE INDEX ind_gemini_issues_repeated ON gemini_issues(repeated)

/* Issue Comments */
CREATE TABLE gemini_issuecomments
(
	commentid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuecomments_commentid_pk PRIMARY KEY,
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuecomments_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuecomments_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuecomments_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	comment NVARCHAR(MAX) NOT NULL,
	username NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuecomments_username_def DEFAULT(''),
	isclosing BIT NOT NULL CONSTRAINT gemini_issuecomments_isclosing_def DEFAULT(0),
	visibility NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuecomments_visibility_def DEFAULT(1),
	created DATETIME NOT NULL CONSTRAINT gemini_issuecomments_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issuecomments_issueid ON gemini_issuecomments(issueid)
CREATE INDEX ind_gemini_issuecomments_visibility ON gemini_issuecomments(visibility)

/* Issue Audit Log */
CREATE TABLE gemini_issueaudit
(
	historyid INT IDENTITY(1,1) CONSTRAINT gemini_issueaudit_historyid_pk PRIMARY KEY NONCLUSTERED,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueaudit_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueaudit_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	userid NUMERIC(10,0) NULL CONSTRAINT gemini_issueaudit_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	username NVARCHAR(255) NOT NULL,
	attributechanged INT NOT NULL,
	fieldchanged NVARCHAR(255) NOT NULL,
	iscustom BIT NOT NULL,
	valuebefore NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_issueaudit_valuebefore_def DEFAULT(''),
	valueafter NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_issueaudit_valueafter_def DEFAULT(''),
	idbefore NVARCHAR(255) NOT NULL CONSTRAINT gemini_issueaudit_idbeforedef DEFAULT(''),
	idafter NVARCHAR(255) NOT NULL CONSTRAINT gemini_issueaudit_idafter_def DEFAULT(''),
	created DATETIME NOT NULL CONSTRAINT gemini_issueaudit_created_def DEFAULT GETUTCDATE()
)
CREATE INDEX ind_gemini_issueaudit_issueid ON gemini_issueaudit(issueid)
CREATE INDEX ind_gemini_issueaudit_projectid ON gemini_issueaudit(projectid)

/* Issue Attachments  */
CREATE TABLE gemini_issueattachments
(
	fileid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issueattachments_fileid_pk PRIMARY KEY NONCLUSTERED,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueattachments_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueattachments_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	commentid NUMERIC(10,0) NULL CONSTRAINT gemini_issueattachments_commentid_fk FOREIGN KEY REFERENCES gemini_issuecomments(commentid),
	contenttype NVARCHAR(200) NOT NULL CONSTRAINT gemini_issueattachments_contenttype_def DEFAULT '',
	contentlength NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueattachments_contentlength_def DEFAULT 0,
	thefilename NVARCHAR(200) NOT NULL CONSTRAINT gemini_issueattachments_thefilename_def DEFAULT '',
	filecontent VARBINARY(MAX),
	created DATETIME NOT NULL CONSTRAINT gemini_issueattachments_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issueattachments_issueid ON gemini_issueattachments(issueid)

/* Issue Widget Data*/
CREATE TABLE gemini_issuewidgetdata
(
	id INT IDENTITY(1,1) CONSTRAINT gemini_issuewidgetdata_id_pk PRIMARY KEY NONCLUSTERED,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuewidgetdata_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	appid VARCHAR(100) NOT NULL,
	controlid VARCHAR(100) NOT NULL,
	value NVARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_issuewidgetdata_created_def DEFAULT GETUTCDATE()
)
CREATE UNIQUE INDEX ind_gemini_issuewidgetdata_ids ON gemini_issuewidgetdata(issueid, appid, controlid)
CREATE INDEX ind_gemini_issuewidgetdata_issueid ON gemini_issuewidgetdata(issueid)

/* User Widget Data*/
CREATE TABLE gemini_userwidgetdata
(
	id INT IDENTITY(1,1) CONSTRAINT gemini_userwidgetdata_watchid_pk PRIMARY KEY NONCLUSTERED,
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_userwidgetdata_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	appid VARCHAR(38) NOT NULL,
	controlid VARCHAR(38) NOT NULL,
	value NVARCHAR(MAX) not null,
	created DATETIME NOT NULL CONSTRAINT gemini_userwidgetdata_created_def DEFAULT GETUTCDATE()
)
CREATE UNIQUE INDEX uind_gemini_userwidgetdata_id ON gemini_userwidgetdata(userid, appid, controlid)
CREATE INDEX ind_gemini_userwidgetdata_userid ON gemini_userwidgetdata(userid)


/* Watch Issue */
CREATE TABLE gemini_watchissues
(
	watchid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_watchissues_watchid_pk PRIMARY KEY NONCLUSTERED,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_watchissues_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_watchissues_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_watchissues_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_watchissues_created_def DEFAULT GETUTCDATE()
)
CREATE UNIQUE INDEX uind_gemini_watchissues_id ON gemini_watchissues(issueid,userid)
CREATE INDEX ind_gemini_watchissues_userid ON gemini_watchissues(userid)
CREATE INDEX ind_gemini_watchissues_issueid ON gemini_watchissues(issueid)

/* Issue Link Types */
CREATE TABLE gemini_issuelinktypes
(
	linktypeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuelinktypes_linktypeid_pk PRIMARY KEY,
	linkname NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuelinktypes_linkname_def DEFAULT (''),
	linkdesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuelinktypes_linkdesc_def DEFAULT (''),
	templateid INT NOT NULL CONSTRAINT gemini_issuelinktypes_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	created DATETIME NOT NULL CONSTRAINT gemini_issuelinktypes_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Issue Links */
CREATE TABLE gemini_issuelinks
(
	issuelinkid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuelinks_issuelinkid_pk PRIMARY KEY,
	linktypeid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuelinks_linktypeid_fk FOREIGN KEY REFERENCES gemini_issuelinktypes(linktypeid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuelinks_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	otherissueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuelinks_otherissueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	linkdirection NVARCHAR(10) NOT NULL CONSTRAINT gemini_issuelinks_linkdirection_def DEFAULT (N'O'),
	created DATETIME NOT NULL CONSTRAINT gemini_issuelinks_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issuelinks_linktypeid ON gemini_issuelinks(linktypeid)
CREATE INDEX ind_gemini_issuelinks_issueid ON gemini_issuelinks(issueid)
CREATE INDEX ind_gemini_issuelinks_otherissueid ON gemini_issuelinks(otherissueid)
CREATE INDEX ind_gemini_issuelinks_issueids ON gemini_issuelinks(issueid,otherissueid)

/* Custom Field Definitions */
CREATE TABLE gemini_customfielddefinitions
(
	customfieldid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_customfielddefinitions_customfieldid_pk PRIMARY KEY,
	customfieldname NVARCHAR(100) NOT NULL,
	screenorder NUMERIC(10,0) NOT NULL CONSTRAINT gemini_customfielddefinitions_screenorder_def DEFAULT 0,
	screenlabel NVARCHAR(100) NOT NULL CONSTRAINT gemini_customfielddefinitions_screenlabel_def DEFAULT (''),
	screendescription NVARCHAR(1910) NOT NULL CONSTRAINT gemini_customfielddefinitions_screendescription_def DEFAULT (''), -- SHORT
	screentooltip NVARCHAR(100) NOT NULL CONSTRAINT gemini_customfielddefinitions_screentooltip_def DEFAULT (''),
	maxlen NUMERIC(10,0) NOT NULL CONSTRAINT gemini_customfielddefinitions_maxlen_def DEFAULT 0,
	canmultiselect BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_canmultiselect_def DEFAULT 1,
	canfilter BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_canfilter_def DEFAULT 0,
	regularexp NVARCHAR(500) NOT NULL CONSTRAINT gemini_customfielddefinitions_regularexp_def DEFAULT (''),
	customfieldtype NVARCHAR(1) NOT NULL CONSTRAINT gemini_customfielddefinitions_customfieldtype_def DEFAULT (N'T'),
	usestaticdata BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_usestaticdata_def DEFAULT (0),
	lookupname NVARCHAR(255) NOT NULL CONSTRAINT gemini_customfielddefinitions_lookupname_def DEFAULT (''),
	lookupvaluefield NVARCHAR(255) NOT NULL CONSTRAINT gemini_customfielddefinitions_lookupvaluefield_def DEFAULT (''),
	lookuptextfield NVARCHAR(255) NOT NULL CONSTRAINT gemini_customfielddefinitions_lookuptexfield_def DEFAULT (''),
	lookupsortfield NVARCHAR(200) NOT NULL CONSTRAINT gemini_customfielddefinitions_lookupsortfield_def DEFAULT (''),
	projectidfilter BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_projectidfilter_def DEFAULT 0,
	showinline BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_showinline_def DEFAULT 0,
	maxvalue NUMERIC(15,5) NULL,
	minvalue NUMERIC(15,5) NULL,
	listlimiter NVARCHAR(500) NOT NULL CONSTRAINT gemini_customfielddefinitions_listlimiter_def DEFAULT (''),
	usedin INT NOT NULL CONSTRAINT gemini_customfielddefinitions_usedin_def DEFAULT (1),
	lookupdata NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_customfielddefinitions_lookupdata_def DEFAULT (''),
	templateid INT NOT NULL CONSTRAINT gemini_customfielddefinitions_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	created DATETIME NOT NULL CONSTRAINT gemini_customfielddefinitions_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Custom Field Data */
CREATE TABLE gemini_customfielddata
(
	customfielddataid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_customfielddata_customfielddataid_pk PRIMARY KEY,
	customfieldid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_customfielddata_customfieldid_fk FOREIGN KEY REFERENCES gemini_customfielddefinitions(customfieldid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_customfielddata_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_customfielddata_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_customfielddata_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	fielddata NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_customfielddata_fielddata_def DEFAULT (''), 
	filedata VARBINARY(MAX) NULL,
	numericdata NUMERIC(15,5) NULL,
	datedata DATETIME NULL,
	revised DATETIME NOT NULL CONSTRAINT gemini_customfielddata_revised_def DEFAULT GETUTCDATE(),
	created DATETIME NOT NULL CONSTRAINT gemini_customfielddata_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_customfielddata_customfieldid ON gemini_customfielddata(customfieldid)
CREATE INDEX ind_gemini_customfielddata_projectid ON gemini_customfielddata(projectid)
CREATE INDEX ind_gemini_customfielddata_userid ON gemini_customfielddata(userid)
CREATE INDEX ind_gemini_customfielddata_issueid ON gemini_customfielddata(issueid)
CREATE INDEX ind_gemini_customfielddata_issueidcfid ON gemini_customfielddata(issueid,customfieldid)

/* Issue Source Countrol Files  */
CREATE TABLE gemini_sourcecontrolissuefiles
(
	fileid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_sourcecontrolissuefiles_fileid_pk PRIMARY KEY,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_sourcecontrolissuefiles_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	[filename] NVARCHAR(255) NOT NULL,
	filepath NVARCHAR(255) NOT NULL,
	sourcecontrolrepository NVARCHAR(255) NOT NULL CONSTRAINT gemini_sourcecontrolissuefiles_sourcecontrolrepository_def DEFAULT(''),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_sourcecontrolissuefiles_issueid ON gemini_sourcecontrolissuefiles(issueid)

/* Issue TimeType */
CREATE TABLE gemini_issuetimetype
(
	timetypeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuetimetype_timetypeid_pk PRIMARY KEY,
	timetypename NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuetimetype_timetypename_def DEFAULT (''),
	timetypedesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_issuetimetype_timetypedesc_def DEFAULT (''),
	templateid INT NOT NULL CONSTRAINT gemini_issuetimetype_templateid_fk FOREIGN KEY REFERENCES gemini_projecttemplate(templateid),
	created DATETIME NOT NULL CONSTRAINT gemini_issuetimetype_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Issue Time Tracking */
CREATE TABLE gemini_timetracking
(
	entryid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_timetracking_entryid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_timetracking_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_timetracking_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_timetracking_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	hours NUMERIC(10,0) NOT NULL CONSTRAINT gemini_timetracking_hours_def DEFAULT(0),
	minutes NUMERIC(10,0) NOT NULL CONSTRAINT gemini_timetracking_minutes_def DEFAULT(0),
	comment NVARCHAR(2000) NOT NULL CONSTRAINT gemini_timetracking_comment_def DEFAULT(''),
	timeentrydate DATETIME NOT NULL,
	timetypeid NUMERIC(10,0) NULL CONSTRAINT gemini_timetracking_timetypeid_fk FOREIGN KEY REFERENCES gemini_issuetimetype(timetypeid),
	created DATETIME NOT NULL CONSTRAINT gemini_timetracking_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_timetracking_projectid ON gemini_timetracking(projectid)
CREATE INDEX ind_gemini_timetracking_issueid ON gemini_timetracking(issueid)

/* Project Documents */
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
	created DATETIME NOT NULL CONSTRAINT ggemini_projectdocuments_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

CREATE INDEX ind_gemini_projectdocuments_parnetnodeid ON gemini_projectdocuments(parentdocumentid)
CREATE INDEX ind_gemini_projectdocuments_projectid ON gemini_projectdocuments(projectid)

/* Project Attributes */
CREATE TABLE gemini_projectattributes
(
	attributeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectattributes_attributeid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectattributes_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	attributename NVARCHAR(100) NOT NULL,
	attributevalue NVARCHAR(2000) NOT NULL CONSTRAINT gemini_projectattributes_attributevalue_def DEFAULT(N''),
	attributeorder int NOT NULL CONSTRAINT gemini_projectattributes_attributeorder_def DEFAULT(0),
	tstamp TIMESTAMP NOT NULL
)

CREATE INDEX ind_gemini_projectattributes_projectid ON gemini_projectattributes(projectid)

/* Project Version Attribute Definitions */
CREATE TABLE gemini_projectversionattributes
(
	attributeid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectversionattributes_attributeid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectversionattributes_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	attributename NVARCHAR(100) NOT NULL,
	attributeorder INT NOT NULL CONSTRAINT gemini_projectversionattributes_attributeorder_def DEFAULT(0),
	defaultvalue NVARCHAR(2000) NOT NULL,
	tstamp TIMESTAMP NOT NULL
)

CREATE INDEX ind_gemini_projectversionattributes_projecctid ON gemini_projectversionattributes(projectid)

/* Project Version Attribute Data */
CREATE TABLE gemini_projectversionattributevalues
(
	attributevalueid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectversionattributevalues_attributevalueid_pk PRIMARY KEY NONCLUSTERED,
	attributeid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectversionattributevalues_attributeid_fk FOREIGN KEY REFERENCES gemini_projectversionattributes(attributeid),
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectversionattributesvalues_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	versionid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectversionattributesvalues_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid),
	attributevalue NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_projectversionattributesvalues_attributvalue_def DEFAULT(N''),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_projectversionattributevalues_projectid ON gemini_projectversionattributevalues(projectid)
CREATE INDEX ind_gemini_projectversionattributevalues_versionid ON gemini_projectversionattributevalues(versionid)
CREATE INDEX ind_gemini_projectversionattributevalues_attributeid ON gemini_projectversionattributevalues(attributeid)

/* Per User Issue View Definition */
CREATE TABLE gemini_userissuesviews
(
	itemid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_userissuesviews_itemid_pk PRIMARY KEY NONCLUSTERED,
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_userissuesviews_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	projectid NUMERIC(10,0) NULL CONSTRAINT gemini_userissuesviews_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	issueattribute INT NULL,
	appid VARCHAR(38) NULL,
	controlid VARCHAR(38) NULL,
	customfieldid NUMERIC(10,0) NULL CONSTRAINT gemini_userissuesviews_customfieldid_fk FOREIGN KEY REFERENCES gemini_customfielddefinitions(customfieldid),
	displayorder NUMERIC(10,0) NOT NULL,
	viewtype NUMERIC(10,0) NOT NULL CONSTRAINT gemini_userissuesviews_viewtype_def DEFAULT (0),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_userissuesview_userid ON gemini_userissuesviews(userid)
CREATE INDEX ind_gemini_userissuesview_userid_project ON gemini_userissuesviews(userid,projectid)

/* Issue Votes */
CREATE TABLE gemini_issuevotes
(
	voteid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuevotes_voteid_pk PRIMARY KEY NONCLUSTERED,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuevotes_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuevotes_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_issuevotes_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE UNIQUE INDEX ind_gemini_issuevotes_issueuser ON gemini_issuevotes(issueid,userid)

/* Issue Affected Version */
CREATE TABLE gemini_affectedversions
(
	affectedversionid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_affectedversions_affectedversionid_pk PRIMARY KEY,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_affectedversions_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	versionid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_affectedversions_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid),
	created DATETIME NOT NULL CONSTRAINT gemini_affectedversions_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_affectedversions_issueid ON gemini_affectedversions(issueid)
CREATE UNIQUE INDEX ind_gemini_affectedversions_issueverid ON gemini_affectedversions(issueid,versionid)

/* Issue Resources */
CREATE TABLE gemini_issueresources
(
	issueresourceid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issueresources_issueresourceid_pk PRIMARY KEY,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueresources_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issueresources_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_issueresources_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issueresources_id ON gemini_issueresources(issueresourceid)
CREATE INDEX ind_gemini_issueresources_issueid ON gemini_issueresources(issueid)
CREATE UNIQUE INDEX ind_gemini_issueresources_issueuserid ON gemini_issueresources(issueid,userid)

/* Issue Components */
CREATE TABLE gemini_issuecomponents
(
	issuecomponentid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_issuecomponents_issuecomponentid_pk PRIMARY KEY,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuecomponents_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	componentid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_issuecomponents_componentid_fk FOREIGN KEY REFERENCES gemini_components(componentid),
	created DATETIME NOT NULL CONSTRAINT gemini_issuecomponents_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_issuecomponents_issueid ON gemini_issuecomponents(componentid)
CREATE UNIQUE INDEX ind_gemini_issuecomponents_issueuserid ON gemini_issuecomponents(issueid,componentid)

/* Project Groups */
CREATE TABLE gemini_projectgroups
(
	projectgroupid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectgroups_projectgroupid_pk PRIMARY KEY,
	projectgroupname nvarchar(500) NOT NULL CONSTRAINT gemini_projectgroups_projectgroupname_def DEFAULT (''),
	projectgroupdesc nvarchar(1000) NOT NULL CONSTRAINT gemini_projectgroups_projectgroupdesc_def DEFAULT (''),
	interactiongroups VARCHAR(MAX) NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_projectgroups_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

SET IDENTITY_INSERT gemini_projectgroups ON
INSERT INTO gemini_projectgroups (projectgroupid,projectgroupname,projectgroupdesc)
	VALUES (1, N'Everyone', N'All users within Gemini')
INSERT INTO gemini_projectgroups (projectgroupid,projectgroupname,projectgroupdesc)
	VALUES (2, N'Gemini Administrators', N'Gemini administrators')
INSERT INTO gemini_projectgroups (projectgroupid,projectgroupname,projectgroupdesc)
	VALUES (3, N'Everyone (Authenticated)', N'Authenticated users')
SET IDENTITY_INSERT gemini_projectgroups OFF

/* Project Group Membership */
CREATE TABLE gemini_projectgroupmembership
(
	projectgroupmembershipid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectgroupmembership_projectgroupmembershipid_pk PRIMARY KEY,
	projectid  NUMERIC(10,0) NULL CONSTRAINT gemini_projectgroupmembership_projectid_fk REFERENCES gemini_projects(projectid),
	projectgroupid  NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectgroupmembership_projectgroupid REFERENCES gemini_projectgroups(projectgroupid),
	userid  NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectgroupmembership_userid_fk REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_projectgroupmembership_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_projectgroupmembership_projectid ON gemini_projectgroupmembership(projectid)
CREATE INDEX ind_gemini_projectgroupmembership_projectgroupid ON gemini_projectgroupmembership(projectgroupid)
CREATE INDEX ind_gemini_projectgroupmembership_userid ON gemini_projectgroupmembership(userid)

INSERT INTO gemini_projectgroupmembership (projectgroupid,userid) SELECT 1 AS projectgroupid, userid FROM gemini_users
INSERT INTO gemini_projectgroupmembership (projectgroupid,userid) SELECT 2 AS projectgroupid, userid FROM gemini_users WHERE username IN ('admin', 'manager')
INSERT INTO gemini_projectgroupmembership (projectgroupid,userid) SELECT 3 AS projectgroupid, userid FROM gemini_users where userid != -1


CREATE TABLE gemini_projectaudit
(
	historyid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectaudit_historyid_pk PRIMARY KEY NONCLUSTERED,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectaudit_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	userid NUMERIC(10,0) NULL CONSTRAINT gemini_projectaudit_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	username NVARCHAR(255) NOT NULL,
	projectarea NVARCHAR(255) NOT NULL,
	useraction NVARCHAR(255) NOT NULL CONSTRAINT gemini_projectaudit_useraction_def DEFAULT(''),
	touched NVARCHAR(255) NOT NULL CONSTRAINT gemini_projectaudit_touched_def DEFAULT(''),
	created DATETIME NOT NULL CONSTRAINT gemini_projectaudit_created_def DEFAULT GETUTCDATE()
)
CREATE INDEX ind_gemini_projectaudit_userid ON gemini_projectaudit(userid)
CREATE INDEX ind_gemini_projectaudit_projectid ON gemini_projectaudit(projectid)

CREATE TABLE gemini_projectdefaultvalues
(
	defaultvalueitemid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_projectdefaultvalues_defaultvalueitemid_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_projectdefaultvalues_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	typeid NUMERIC(10,0) NULL CONSTRAINT gemini_projectdefaultvalues_typeid_fk FOREIGN KEY REFERENCES gemini_issuetypes(typeid),
	defaultvalues NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_projectdefaultvalues_defaultvalues_def DEFAULT(''),
	created DATETIME NOT NULL CONSTRAINT gemini_projectdefaultvalues_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE UNIQUE INDEX ind_gemini_projectdefaultvalues_defaultvalueitemid ON gemini_projectdefaultvalues(defaultvalueitemid)

/* VIEWS */
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuesview') DROP VIEW gemini_issuesview
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuestatusfinal') DROP VIEW gemini_issuestatusfinal
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueresolutionfinal') DROP VIEW gemini_issueresolutionfinal

/* Versions Milestone*/
CREATE TABLE gemini_versionmilestone
(
	milestoneid NUMERIC(10,0) IDENTITY(1,1) CONSTRAINT gemini_versionmilestone_milestoneid_pk PRIMARY KEY,
	versionid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_versionmilestone_versionid_fk FOREIGN KEY REFERENCES gemini_versions(versionid),
	milestonename NVARCHAR(100) NOT NULL CONSTRAINT gemini_versionmilestone_milestonename_def DEFAULT (''),
	milestonedesc NVARCHAR(255) NOT NULL CONSTRAINT gemini_versionmilestone_milestonedesc_def DEFAULT (''),	
	milestonedate DATETIME NOT NULL CONSTRAINT gemini_versionmilestone_milestonedate_def DEFAULT GETUTCDATE(),   	
    created DATETIME NOT NULL CONSTRAINT gemini_versionmilestone_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)

/* Testing */
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_plans_created_def DEFAULT GETUTCDATE(),
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_plans_revised_def DEFAULT GETUTCDATE(),
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_cases_created_def DEFAULT GETUTCDATE(),
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_cases_revised_def DEFAULT GETUTCDATE(),
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_plan_cases_created_def DEFAULT GETUTCDATE(),
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_plan_cases_revised_def DEFAULT GETUTCDATE(),
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_case_issues_def DEFAULT GETUTCDATE(),
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_case_steps_created_def DEFAULT GETUTCDATE(),
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_case_steps_revised_def DEFAULT GETUTCDATE(),
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_runs_created_def DEFAULT GETUTCDATE(),
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_runs_revised_def DEFAULT GETUTCDATE(),
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
	caseorder INT NULL,
	projectid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_cases_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	haspassed BIT NULL,
	isclosed BIT NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_testing_run_cases_created_def DEFAULT GETUTCDATE(),
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
	stepid INT NOT NULL,
	steporder INT NOT NULL,
	stepdescription NVARCHAR(MAX) NOT NULL,
	expectedresult NVARCHAR(MAX) NOT NULL,
	actualresult NVARCHAR(MAX) NOT NULL,
	data NVARCHAR(MAX) NOT NULL,
	haspassed BIT NULL,
	createdby NUMERIC(10,0) NOT NULL CONSTRAINT gemini_testing_run_steps_createdby_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_run_steps_created_def DEFAULT GETUTCDATE(),
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
	created DATETIME NOT NULL CONSTRAINT gemini_testing_attachments_created_def DEFAULT GETUTCDATE(),
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
	timetypeid NUMERIC(10,0) NULL CONSTRAINT gemini_testing_run_times_timetypeid_fk FOREIGN KEY REFERENCES gemini_issuetimetype(timetypeid),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_run_times_created_def DEFAULT GETUTCDATE(),
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
	revised DATETIME NOT NULL CONSTRAINT gemini_testing_customdata_revised_def DEFAULT GETUTCDATE(),
	created DATETIME NOT NULL CONSTRAINT gemini_testing_customdata_created_def DEFAULT GETUTCDATE(),
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
	history NVARCHAR(MAX) NOT NULL,
	fullname NVARCHAR(255) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_testing_history_created_def DEFAULT GETUTCDATE()
)
CREATE INDEX ind_gemini_testing_history_testplanid ON gemini_testing_history(testplanid)
CREATE INDEX ind_gemini_testing_history_testcaseid ON gemini_testing_history(testcaseid)
CREATE INDEX ind_gemini_testing_history_testrunid ON gemini_testing_history(testrunid)
CREATE INDEX ind_gemini_testing_history_stepid ON gemini_testing_history(stepid)
CREATE INDEX ind_gemini_testing_history_projectid ON gemini_testing_history(projectid)

/**********************************************************************************************************************
* Active Directory
**********************************************************************************************************************/
CREATE TABLE gemini_adgroups
(
	adgroupid INT IDENTITY(1,1) NOT NULL CONSTRAINT gemini_adgroups_adgroupid_pk PRIMARY KEY,
	adgroupname NVARCHAR(500) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_adgroups_created_def DEFAULT (GETUTCDATE()),
	tstamp TIMESTAMP NOT NULL
 )
GO
 
CREATE TABLE gemini_admappings 
(
   mappingid INT IDENTITY (1,1) NOT NULL CONSTRAINT gemini_admappings_mappingid_pk PRIMARY KEY,
   prjectgroupid NUMERIC (10,0) NOT NULL CONSTRAINT gemini_admappings_projectgroups_fk FOREIGN KEY REFERENCES gemini_projectgroups(projectgroupid),
   adgroupid INT NOT NULL CONSTRAINT gemini_admappings_adgroups_fk FOREIGN KEY REFERENCES gemini_adgroups(adgroupid),
   lastsyncdate DATETIME NOT NULL,
   created DATETIME NOT NULL CONSTRAINT gemini_admappings_created_def DEFAULT (GETUTCDATE()),
   tstamp TIMESTAMP NOT NULL
)
GO

CREATE INDEX ind_gemini_admappings_projectgroupid ON gemini_admappings(projectgroupid)
GO

INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES (N'SyncWithActiveDirectory', N'Security', N'False', N'Do we sync users and groups with our Active Directory Server ?')
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES (N'ActiveDirectoryConnectionString', N'Security', N'', N'Active Directory Connection String (eg: LDAP://DC=Countersoft,DC=com')
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES (N'ActiveDirectoryUserName', N'Security', N'', N'Active Directory Username')
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES (N'ActiveDirectoryPassword', N'Security', N'', N'Active Directory Password')
INSERT INTO gemini_applicationsettings (settingname, settingvalue) VALUES (N'ActiveDirectoryAddNewUsers', N'Security', N'NO', N'Indicates whether to add new Active Directory users to Gemini')
GO

/**********************************************************************************************************************
* Navigation Cards
**********************************************************************************************************************/
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_navigationcard') DROP TABLE gemini_navigationcard
GO
CREATE TABLE gemini_navigationcard
(
	cardid INT IDENTITY(1,1) CONSTRAINT gemini_navigationcard_templateid_pk PRIMARY KEY NONCLUSTERED,
	projectid NUMERIC(10,0) CONSTRAINT gemini_navigationcard_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	issueid NUMERIC(10,0) CONSTRAINT gemini_navigationcard_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	userid NUMERIC(10,0) CONSTRAINT gemini_navigationcard_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	cardtype NVARCHAR(255) NOT NULL CONSTRAINT gemini_navigationcard_cardtype_def DEFAULT('1'),
	cardkey NVARCHAR(100) NOT NULL CONSTRAINT gemini_navigationcard_cardkey_def DEFAULT(''),
	cardtitle NVARCHAR(500) NOT NULL CONSTRAINT gemini_navigationcard_cardtitle_def DEFAULT(''),
	carddata NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_navigationcard_carddata_def DEFAULT(''),
	cardoptions NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_navigationcard_cardoptions_def DEFAULT(''),
	cardurl NVARCHAR(1000) NOT NULL CONSTRAINT gemini_navigationcard_cardurl_def DEFAULT(''),
	originatorid INT CONSTRAINT gemini_navigationcard_originatorid_fk FOREIGN KEY REFERENCES gemini_navigationcard(cardid),
	lastseen DATETIME,
	badgecount INT NOT NULL CONSTRAINT gemini_navigationcard_badgecount_def DEFAULT(0),
	sharedgroups NVARCHAR(1000) NOT NULL CONSTRAINT gemini_navigationcard_sharedgroups_def DEFAULT(''),
	color VARCHAR(20) NOT NULL CONSTRAINT gemini_navigationcard_color_def DEFAULT(''),
	visibletoanonuser BIT NOT NULL CONSTRAINT gemini_navigationcard_visibletoanonuser_def DEFAULT(0),
	visibletoauthuser BIT NOT NULL CONSTRAINT gemini_navigationcard_visibletoauthuser_def DEFAULT(0),
	generated BIT NOT NULL CONSTRAINT gemini_navigationcard_generated_def DEFAULT(0),
	sequence INT NOT NULL CONSTRAINT gemini_navigationcard_sequence_def DEFAULT(1),
	created DATETIME NOT NULL CONSTRAINT gemini_navigationcard_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP 	
)
GO
CREATE INDEX ind_gemini_navigationcards_cardid ON gemini_navigationcard(cardid)
CREATE INDEX ind_gemini_navigationcards_userid ON gemini_navigationcard(userid)
CREATE INDEX ind_gemini_navigationcards_projectid ON gemini_navigationcard(projectid)
CREATE INDEX ind_gemini_navigationcards_issueid ON gemini_navigationcard(issueid)
CREATE INDEX ind_gemini_navigationcards_cardtype ON gemini_navigationcard(cardtype)
CREATE INDEX ind_gemini_navigationcards_originatorid ON gemini_navigationcard(originatorid)

delete from gemini_navigationcard where generated=1
insert into gemini_navigationcard (generated, cardtype, cardkey, cardtitle, cardurl, color, visibletoanonuser, visibletoauthuser, badgecount, lastseen)
	values (1, 0, 'WHY GEMINI?', 'See Killer Features', 'http://www.geminiplatform.com', '#562366', 1, 0, 0, GETUTCDATE())
insert into gemini_navigationcard (generated, cardtype, cardkey, cardtitle, cardurl, color, visibletoanonuser, visibletoauthuser, badgecount, lastseen)
	values (1, 0, 'HELP', 'Docs & Videos', 'http://community.geminiplatform.com', '#562366', 0, 1, 0, GETUTCDATE())
insert into gemini_navigationcard (generated, cardtype, cardkey, cardtitle, cardurl, color, visibletoanonuser, visibletoauthuser, badgecount, lastseen)
	values (1, 0, '', '', 'projects', '#562366', 0, 0, 0, GETUTCDATE())
GO

/**********************************************************************************************************************
* Shared Views
**********************************************************************************************************************/
CREATE TABLE gemini_sharedviews
(
   sharedviewid INT IDENTITY (1,1) NOT NULL CONSTRAINT gemini_sharedviews_mappingid_pk PRIMARY KEY,
   userid NUMERIC (10,0) NULL CONSTRAINT gemini_sharedviews_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
   projectid NUMERIC (10,0) NULL CONSTRAINT gemini_sharedviews_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
   pagetype INT NOT NULL,
   pageid NVARCHAR(50),
   name NVARCHAR(50) NOT NULL,
   visibility NVARCHAR(1000) NOT NULL,
   value NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_sharedviews_value_def DEFAULT(''),
   created DATETIME NOT NULL CONSTRAINT gemini_sharedviews_created_def DEFAULT (GETUTCDATE()),
   tstamp TIMESTAMP NOT NULL
)
GO

CREATE INDEX ind_gemini_sharedviews_userid ON gemini_sharedviews(userid)
CREATE INDEX ind_gemini_sharedviews_projectid ON gemini_sharedviews(projectid)
GO

/**********************************************************************************************************************
* Planner Views
**********************************************************************************************************************/
CREATE TABLE gemini_plannerviews
(
   plannerviewid INT IDENTITY (1,1) NOT NULL CONSTRAINT gemini_plannerviews_plannerviewid_pk PRIMARY KEY,
   userid NUMERIC (10,0) NULL CONSTRAINT gemini_plannerviews_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
   issuesfilter NVARCHAR(MAX) NOT NULL,
   issuessequence VARCHAR(MAX) NOT NULL,
   axis1property VARCHAR(50) NOT NULL,
   axis1sortdirection VARCHAR(5) NOT NULL,
   axis2property VARCHAR(50) NOT NULL,
   axis2sortdirection VARCHAR(5) NOT NULL,
   orderbyproperty VARCHAR(50) NOT NULL,
   orderbysortdirection VARCHAR(5) NOT NULL,
   thenbyproperty VARCHAR(50) NOT NULL,
   thenbysortdirection VARCHAR(5) NOT NULL,
   colorbyproperty VARCHAR(50) NOT NULL,
   swimlanelimit INT NOT NULL,
   laneslimit INT NOT NULL,
   zoomlevel INT NOT NULL,
   tottingmodeproperty VARCHAR(50) NOT NULL,
   autolimit INT NOT NULL,
   daterangeproperty VARCHAR(50) NOT NULL,
   paginginfo VARCHAR(MAX) NOT NULL,
   created DATETIME NOT NULL CONSTRAINT gemini_plannerviews_created_def DEFAULT (GETUTCDATE()),
   tstamp TIMESTAMP NOT NULL
)
GO

CREATE INDEX ind_gemini_plannerviews_userid ON gemini_plannerviews(userid)
GO

/**********************************************************************************************************************
* Alert Templates
**********************************************************************************************************************/
CREATE TABLE gemini_alerttemplates
(
	alerttemplateid INT IDENTITY(1,1) CONSTRAINT gemini_alerttemplates_alerttemplateid_pk PRIMARY KEY NONCLUSTERED,
	alerttype INT CONSTRAINT gemini_alerttemplates_alerttype_def DEFAULT(0),
	label NVARCHAR(100) NOT NULL CONSTRAINT gemini_alerttemplates_alertlabel_def DEFAULT(''),
	alertcontent NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_alerttemplates_alertcontent_def DEFAULT(''),
	projects NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_alerttemplates_projects_def DEFAULT(''),
	created DATETIME NOT NULL CONSTRAINT ggemini_alerttemplates_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP 	
)
GO
INSERT gemini_alerttemplates(alerttype,label,alertcontent,projects) VALUES('4','When something in the AppNav Card changes',
'<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #8f0929;" cellpadding="20">
<tbody>
<tr>
<td style="color: white;">GEMINI TRACKER</td>
</tr>
</tbody>
</table>

<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know that there are <strong>@(Model.ChangeCount) changes </strong> to your <strong>@(Model.CardTitle)</strong> AppNav card.</td>
</tr>
</tbody>
</table>

@if (Model.TheItemsCreated.Count > 0)
{
	<h2 style="margin: 10px 0 10px 20px;">New</h2>
	<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
	<tbody>	
	@foreach(var item in Model.TheItemsCreated)
	{
		<tr>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;"><a href="@(Model.GeminiUrl)project/@(item.ProjectCode)/@(item.Entity.ProjectId)/item/@(item.Entity.Id)">@(item.IssueKey)</a></td>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; font-weight: normal; font-size: 12px;">@(item.Title)</td>
		</tr>
	}
	</tbody>
	</table>
}

@if (Model.TheItemsUpdated.Count > 0)
{
	<h2 style="margin: 10px 0 10px 20px;">Changed</h2>	
	<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
	<tbody>	
	@foreach(var item in Model.TheItemsUpdated)
	{
		<tr>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;"><a href="@(Model.GeminiUrl)project/@(item.ProjectCode)/@(item.Entity.ProjectId)/item/@(item.Entity.Id)">@(item.IssueKey)</a></td>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; font-weight: normal; font-size: 12px;">@(item.Title)</td>
		</tr>
	}
	</tbody>
	</table>	
}

@if (Model.TheItemsCommented.Count > 0)
{
	<h2 style="margin: 10px 0 10px 20px;">Comments</h2>	
	<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
	<tbody>	
	@foreach(var item in Model.TheItemsCommented)
	{
		<tr>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;">@(item.Comments[0].Entity.Fullname)</td>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; font-weight: normal; font-size: 12px;">
			<a href="@(Model.GeminiUrl)project/@(item.ProjectCode)/@(item.Entity.ProjectId)/item/@(item.Entity.Id)#comments">@(item.IssueKey)</a>
			&nbsp;@(item.Title)</td>
		</tr>
	}
	</tbody>
	</table>}

<table style="font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks.</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 11px; font-weight: normal; border: none; background-color: #8f0929;" cellpadding="5">
<tbody>
<tr>
<td style="color: white;">Sent by Countersoft Gemini v@(Model.Version</td>
</tr>
</tbody>
</table>'
,'')

INSERT gemini_alerttemplates(alerttype,label,alertcontent,projects) VALUES('2','When watched items change',
'<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #8f0929;" cellpadding="20">
<tbody>
<tr>
<td style="color: white;">GEMINI TRACKER</td>
</tr>
</tbody>
</table>

<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know that there are <strong>@(Model.ChangeCount) changes </strong> to your watched items.</td>
</tr>
</tbody>
</table>

@if (Model.TheItemsUpdated.Count > 0)
{
	<h2 style="margin: 10px 0 10px 20px;">Changed</h2>	
	<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
	<tbody>	
	@foreach(var item in Model.TheItemsUpdated)
	{
		<tr>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;"><a href="@(Model.GeminiUrl)project/@(item.ProjectCode)/@(item.Entity.ProjectId)/item/@(item.Entity.Id)">@(item.IssueKey)</a></td>
			<td style="color: #4c4c4c; border: 1px solid #f5f5f5; font-weight: normal; font-size: 12px;">@(item.Title)</td>
		</tr>
	}
	</tbody>
	</table>	
}

<table style="font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks.</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 11px; font-weight: normal; border: none; background-color: #8f0929;" cellpadding="5">
<tbody>
<tr>
<td style="color: white;">Sent by Countersoft Gemini v@(Model.Version</td>
</tr>
</tbody>
</table>','')


INSERT gemini_alerttemplates(alerttype,label,alertcontent,projects) VALUES('1','When new things are added',
'<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #8f0929;" cellpadding="20">
<tbody>
<tr>
<td style="color: white;">GEMINI TRACKER</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know that a new <strong>@(Model.TheItem.Type)</strong> has been added to <strong>@(Model.TheItem.ProjectName).</strong></td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;">@(Model.TheItem.IssueKey)</td>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;">@(Model.TheItem.Title)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5;"><strong>Status:</strong></td>
<td style="border: 1px solid #f5f5f5;">@(Model.TheItem.Status)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5;"><strong>Resourced:</strong></td>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5;">@(Model.TheItem.ResourceNames)</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">@(Model.LinkViewItem)</td>
</tr>
</tbody>
</table>
<table style="font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks.</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 11px; font-weight: normal; border: none; background-color: #8f0929;" cellpadding="5">
<tbody>
<tr>
<td style="color: white;">Sent by Countersoft Gemini v@(Model.Version</td>
</tr>
</tbody>
</table>','')

INSERT gemini_alerttemplates(alerttype,label,alertcontent,projects) VALUES('3','When someone is resourced',
'<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #8f0929;" cellpadding="20">
<tbody>
<tr>
<td style="color: white;">GEMINI TRACKER</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know the following <strong>@(Model.TheItem.Type)</strong>&nbsp;in <strong>@(Model.TheItem.ProjectName)</strong> has been assigned to you:</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;">@(Model.TheItem.IssueKey)</td>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5; background-color: #f5f5f5; font-weight: bold; font-size: 13px;">@(Model.TheItem.Title)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5;"><strong>Status:</strong></td>
<td style="border: 1px solid #f5f5f5;">@(Model.TheItem.Status)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5;"><strong>Resourced:</strong></td>
<td style="color: #4c4c4c; border: 1px solid #f5f5f5;">@(Model.TheItem.ResourceNames)</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">@(Model.LinkViewItem)</td>
</tr>
</tbody>
</table>
<table style="font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks.</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 11px; font-weight: normal; border: none; background-color: #8f0929;" cellpadding="5">
<tbody>
<tr>
<td style="color: white;">Sent by Countersoft Gemini v@(Model.Version</td>
</tr>
</tbody>
</table>','')
GO

/**********************************************************************************************************************
* Issue Sequence
**********************************************************************************************************************/
CREATE TABLE gemini_projectissuesequence
(
	id INT IDENTITY(1,1) CONSTRAINT gemini_projectissuesequence_id_pk PRIMARY KEY,
	projectid NUMERIC(10,0) NULL CONSTRAINT gemini_projectissuesequence_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid),
	sequence VARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_projectissuesequence_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
CREATE INDEX ind_gemini_projectissuesequence_projectid ON gemini_projectissuesequence(projectid)
GO



/**********************************************************************************************************************
* Breeze Tables																										  *
***********************************************************************************************************************/


CREATE TABLE breeze_smtpserver (
      smtpserverid  INT IDENTITY(1,1) NOT NULL CONSTRAINT breeze_smtpserver_smtpserverid_pk PRIMARY KEY,
      smtpservername NVARCHAR(255) NOT NULL CONSTRAINT breeze_smtpserver_smtpservername_def  DEFAULT (''),
      server NVARCHAR(255) NOT NULL CONSTRAINT breeze_smtpserver_server_def  DEFAULT (''),
      serverport INT NOT NULL CONSTRAINT breeze_smtpserver_serverport_def  DEFAULT (0),
      username NVARCHAR(255) NOT NULL CONSTRAINT breeze_smtpserver_username_def  DEFAULT (''),
      password NVARCHAR(255) NOT NULL CONSTRAINT breeze_smtpserver_password_def  DEFAULT (''),
      encodingtype INT NOT NULL CONSTRAINT breeze_smtpserver_encodingtype_def  DEFAULT (0),
      usessl BIT NOT NULL CONSTRAINT breeze_smtpserver_usessl_def  DEFAULT (0),
      sslmode INT NOT NULL CONSTRAINT breeze_smtpserver_sslmode_def  DEFAULT (0),
      authmode INT NOT NULL CONSTRAINT breeze_smtpserver_authmode_def  DEFAULT (0),
      popbeforesmtp BIT NOT NULL CONSTRAINT breeze_smtpserver_popbeforesmtp_def  DEFAULT (0),
      created DATETIME NOT NULL CONSTRAINT breeze_smtpserver_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

CREATE TABLE breeze_queue (
      queueid INT IDENTITY(1, 1) NOT NULL CONSTRAINT breeze_queue_queueid_pk PRIMARY KEY,
      name NVARCHAR(500) NOT NULL CONSTRAINT breeze_queue_name_def DEFAULT (''), 
      queuedescription NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_queue_queuedescription_def DEFAULT (''), 
      userid INT NOT NULL CONSTRAINT breeze_queue_userid_def DEFAULT(0),
      visibility VARCHAR(MAX) NOT NULL CONSTRAINT breeze_queue_visibility_def DEFAULT (''),
      colour VARCHAR(50) NOT NULL CONSTRAINT breeze_queue_color_def DEFAULT ('white'),
      sequence INT NOT NULL CONSTRAINT breeze_queue_sequence_def DEFAULT (0),
      projectid INT NOT NULL CONSTRAINT breeze_queue_projectid_def DEFAULT (0),
      active BIT NOT NULL CONSTRAINT breeze_queue_active_def DEFAULT (0),
      created DATETIME NOT NULL CONSTRAINT breeze_queue_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

CREATE TABLE breeze_mailbox (
      mailboxid INT IDENTITY(1,1) NOT NULL CONSTRAINT breeze_mailbox_mailboxid_pk PRIMARY KEY,
      queueid INT NOT NULL CONSTRAINT breeze_mailbox_queueid_fk FOREIGN KEY REFERENCES breeze_queue(queueid),
      mailboxname NVARCHAR(100) NOT NULL CONSTRAINT breeze_mailbox_mailboxname_def  DEFAULT ('') ,
      server NVARCHAR(255) NOT NULL CONSTRAINT breeze_mailbox_server_def  DEFAULT (''),
      serverport INT NOT NULL CONSTRAINT breeze_mailbox_serverport_def  DEFAULT (0),
      emailaddress NVARCHAR(255) NOT NULL CONSTRAINT breeze_mailbox_emailaddress_def  DEFAULT (''),
      username NVARCHAR(100) NOT NULL CONSTRAINT breeze_mailbox_username_def  DEFAULT (''),
      password NVARCHAR(100) NOT NULL CONSTRAINT breeze_mailbox_password_def  DEFAULT (''),
      authenticationmode INT NOT NULL CONSTRAINT breeze_mailbox_authenticationmode_def  DEFAULT (0),
      usessl BIT NOT NULL CONSTRAINT breeze_mailbox_usessl_def  DEFAULT (0),
      deletemessages BIT NOT NULL CONSTRAINT breeze_mailbox_deletemessages_def  DEFAULT (0),
      debugmode BIT NOT NULL CONSTRAINT breeze_mailbox_incomingdebugmode_def  DEFAULT (0),
      userid INT NOT NULL CONSTRAINT breeze_mailbox_userid_def  DEFAULT (0),
      usesenderassubmitter BIT NOT NULL CONSTRAINT breeze_mailbox_usesenderassubmitter_def  DEFAULT (0),
      mode INT NOT NULL CONSTRAINT breeze_mailbox_mode_def  DEFAULT (0),
      imapfolder NVARCHAR(255) NOT NULL CONSTRAINT breeze_mailbox_imapfolder_def  DEFAULT (''),
      blacklist NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_blacklist_def  DEFAULT (''),
      noreplylist NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_noreplylist_def  DEFAULT (''),
      lastmessageid NVARCHAR(255) NULL,
      lastmessagedate DATETIME NULL,
      alerttemplateid INT NULL CONSTRAINT breeze_mailbox_alerttemplateid_fk FOREIGN KEY REFERENCES gemini_alerttemplates(alerttemplateid), 
      smtpserverid INT NULL CONSTRAINT breeze_mailbox_smtpserverid_fk FOREIGN KEY REFERENCES breeze_smtpserver(smtpserverid), 
      stripsignature BIT NOT NULL CONSTRAINT breeze_mailbox_stripsignature_def DEFAULT (0),
      ignoreattachments BIT NOT NULL CONSTRAINT breeze_mailbox_ignoreattachments_def DEFAULT (0),
      subjectlikeexp NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_subjectlikeexp_def DEFAULT (''),
      subjectnotlikeexp NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_subjectnotlikeexp_def DEFAULT (''),
      replaceexp NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_replaceexp_def DEFAULT (''),
      truncateexp NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_truncateexp_def DEFAULT (''),
      projectid INT NULL,
	  issuetypeid INT NULL,
      created DATETIME NOT NULL CONSTRAINT breeze_mailbox_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

CREATE TABLE breeze_enquiry(
      enquiryid BIGINT IDENTITY(1, 1) NOT NULL CONSTRAINT breeze_enquiry_enquiryid_pk PRIMARY KEY,
      queueid INT NULL CONSTRAINT breeze_enquiry_queueid_fk FOREIGN KEY REFERENCES breeze_queue(queueid),
      issueid NUMERIC(10, 0) NULL CONSTRAINT breeze_enquiry_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
      projectid INT NULL,
      issuekey NVARCHAR(25) NULL,
      issuecommentid NUMERIC(10, 0) NULL CONSTRAINT breeze_enquiry_issuecommentid_fk FOREIGN KEY REFERENCES gemini_issuecomments(commentid),
      alerttemplateid INT NULL CONSTRAINT breeze_enquiry_alerttemplateid_fk FOREIGN KEY REFERENCES gemini_alerttemplates(alerttemplateid), 
      enquirysource INT NOT NULL CONSTRAINT breeze_enquiry_source_def DEFAULT (0),
      enquirydata NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_enquiry_enquirydata_def DEFAULT (''),
      rawenquiry NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_enquiry_rawenquiry_def DEFAULT (''),
      rawid NVARCHAR(255) NOT NULL CONSTRAINT breeze_enquiry_rawid_def DEFAULT (''),
      cancontact BIT NOT NULL CONSTRAINT breeze_qnquiry_cancontact_def DEFAULT (0),
      acknowledged DATETIME  NULL CONSTRAINT breeze_qnquiry_acknowledged_def DEFAULT (GETUTCDATE()),
      received DATETIME NOT NULL CONSTRAINT breeze_enquiry_received_def DEFAULT (GETUTCDATE()),
      created DATETIME NOT NULL CONSTRAINT breeze_enquiry_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

CREATE TABLE breeze_matchexpression(
      expressionid BIGINT IDENTITY(1, 1) NOT NULL CONSTRAINT breeze_matchexpression_expressionid_pk PRIMARY KEY,
      name VARCHAR(50) NOT NULL CONSTRAINT breeze_matchexpression_name_def DEFAULT (''),
      expression NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_matchexpression_expression_def DEFAULT (''),
      replacevalue NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_matchexpression_replacevalue_def DEFAULT (''),
      created DATETIME NOT NULL CONSTRAINT breeze_matchexpression_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

/**********************************************************************************************************************
* INSERT PROJECT TEMPLATE DATA
**********************************************************************************************************************/
SET IDENTITY_INSERT gemini_issuetypes ON
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('57','3','Task','assets/images/meta/AGILE/type-task.png','#e68012','{"ReferenceId":55,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedTime","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T18:40:49.4754629Z","Revised":"2012-08-01T18:40:49.4754629Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":55,"Status":[{"StatusId":65,"Top":10,"Left":10,"Transitions":[]},{"StatusId":66,"Top":10,"Left":160,"Transitions":[]},{"StatusId":67,"Top":0,"Left":0,"Transitions":[{"StatusId":68,"Groups":[1]}]},{"StatusId":68,"Top":10,"Left":160,"Transitions":[{"StatusId":69,"Groups":[1]}]},{"StatusId":69,"Top":10,"Left":310,"Transitions":[{"StatusId":70,"Groups":[1]}]},{"StatusId":70,"Top":10,"Left":460,"Transitions":[]},{"StatusId":71,"Top":80,"Left":10,"Transitions":[]}]}','','10')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('70','2','Bug','assets/images/meta/ISSUES/type-bug.png','#ff0000','{"ReferenceId":82,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"30","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":26,"Label":"","Id":"AssociatedWatchers","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"30","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":26,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":27,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":28,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":29,"Label":"","Id":"AssociatedTime","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"30","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":26,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":27,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":28,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":29,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":30,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":31,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T08:48:33.6919324Z","Revised":"2012-08-01T08:48:33.6919324Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":82,"Status":[{"StatusId":96,"Top":0,"Left":9,"Transitions":[{"StatusId":97,"Groups":[1]},{"StatusId":98,"Groups":[1]}]},{"StatusId":98,"Top":407,"Left":0,"Transitions":[{"StatusId":99,"Groups":[1]}]},{"StatusId":93,"Top":10,"Left":310,"Transitions":[]},{"StatusId":97,"Top":0,"Left":577,"Transitions":[{"StatusId":98,"Groups":[1]}]},{"StatusId":94,"Top":10,"Left":610,"Transitions":[]},{"StatusId":99,"Top":41,"Left":151,"Transitions":[{"StatusId":96,"Groups":[1]},{"StatusId":95,"Groups":[1]}]},{"StatusId":95,"Top":0,"Left":0,"Transitions":[{"StatusId":96,"Groups":[1]}]}]}','','13')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('83','2','Enquiry','assets/images/meta/ENQUIRY/status-reopened.png','#e63777','{"ReferenceId":61,"Create":[],"Edit":[],"View":[],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T09:00:19.0392759Z","Revised":"2012-08-01T09:00:19.0392759Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":61,"Status":[]}','','11')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('61','1','Open Issue','assets/images/meta/test-validation.png','#3300ff','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"24","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"26","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"25","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Source","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"24","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"26","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"25","Type":1}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"26","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"25","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"24","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"ReportedBy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":26,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":27,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":28,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":29,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:06:29.9914014Z","Revised":"2012-08-01T10:06:29.9914014Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":72,"Top":40,"Left":376,"Transitions":[]},{"StatusId":73,"Top":41,"Left":196,"Transitions":[]},{"StatusId":76,"Top":10,"Left":10,"Transitions":[]},{"StatusId":74,"Top":185,"Left":62,"Transitions":[{"StatusId":77,"Groups":[1]},{"StatusId":81,"Groups":[1]}]},{"StatusId":75,"Top":63,"Left":631,"Transitions":[{"StatusId":77,"Groups":[1]}]},{"StatusId":77,"Top":186,"Left":397,"Transitions":[{"StatusId":78,"Groups":[1]},{"StatusId":80,"Groups":[1]}]},{"StatusId":78,"Top":341,"Left":674,"Transitions":[{"StatusId":79,"Groups":[1]}]},{"StatusId":79,"Top":508,"Left":296,"Transitions":[{"StatusId":81,"Groups":[1]}]},{"StatusId":80,"Top":188,"Left":687,"Transitions":[{"StatusId":78,"Groups":[1]},{"StatusId":75,"Groups":[1]}]},{"StatusId":81,"Top":301,"Left":218,"Transitions":[{"StatusId":82,"Groups":[1]}]},{"StatusId":82,"Top":344,"Left":437,"Transitions":[{"StatusId":77,"Groups":[1]}]}]}','','11')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('59','5','Bug','assets/images/meta/AGILE/type-bug.png','#ff0000','{"ReferenceId":55,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"DueDate","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Visibility","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:18:20.5330421Z","Revised":"2012-08-01T10:18:20.5330421Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":55,"Status":[{"StatusId":64,"Top":10,"Left":10,"Transitions":[]},{"StatusId":68,"Top":564,"Left":423,"Transitions":[{"StatusId":69,"Groups":[1]}]},{"StatusId":70,"Top":523,"Left":726,"Transitions":[]},{"StatusId":65,"Top":67,"Left":345,"Transitions":[]},{"StatusId":69,"Top":10,"Left":760,"Transitions":[{"StatusId":70,"Groups":[1]}]},{"StatusId":66,"Top":498,"Left":91,"Transitions":[{"StatusId":68,"Groups":[1]},{"StatusId":65,"Groups":[1]}]},{"StatusId":71,"Top":206,"Left":10,"Transitions":[{"StatusId":65,"Groups":[1]}]},{"StatusId":67,"Top":334,"Left":308,"Transitions":[{"StatusId":68,"Groups":[1]},{"StatusId":69,"Groups":[1]}]}]}','','10')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('64','1','Investigation','assets/images/meta/HELPDESK/type-investigation.png','#ffd000','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Visibility","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"27","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"29","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"StartDate","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"29","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"27","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ReportedBy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"ResolvedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssociatedComments","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T19:04:16.4859393Z","Revised":"2012-08-01T19:04:16.4859393Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":66,"Status":[{"StatusId":90,"Top":10,"Left":10,"Transitions":[]},{"StatusId":86,"Top":0,"Left":0,"Transitions":[{"StatusId":85,"Groups":[1]},{"StatusId":87,"Groups":[1]}]},{"StatusId":88,"Top":10,"Left":310,"Transitions":[]},{"StatusId":83,"Top":10,"Left":460,"Transitions":[]},{"StatusId":87,"Top":217,"Left":383,"Transitions":[{"StatusId":88,"Groups":[1]}]},{"StatusId":84,"Top":10,"Left":760,"Transitions":[]},{"StatusId":89,"Top":80,"Left":10,"Transitions":[]},{"StatusId":85,"Top":0,"Left":0,"Transitions":[]}]}','','12')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('63','4','Task','assets/images/meta/AGILE/type-task.png','#e68012','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedComments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedTime","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T09:00:27.1497398Z","Revised":"2012-08-01T09:00:27.1497398Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":72,"Top":24,"Left":37,"Transitions":[]},{"StatusId":73,"Top":10,"Left":245,"Transitions":[]},{"StatusId":76,"Top":198,"Left":478,"Transitions":[{"StatusId":80,"Groups":[1]},{"StatusId":75,"Groups":[1]}]},{"StatusId":74,"Top":402,"Left":88,"Transitions":[{"StatusId":77,"Groups":[1]},{"StatusId":82,"Groups":[1]},{"StatusId":81,"Groups":[1]}]},{"StatusId":75,"Top":142,"Left":275,"Transitions":[{"StatusId":77,"Groups":[1]}]},{"StatusId":77,"Top":298,"Left":378,"Transitions":[{"StatusId":78,"Groups":[1]},{"StatusId":76,"Groups":[1]}]},{"StatusId":78,"Top":287,"Left":589,"Transitions":[]},{"StatusId":79,"Top":80,"Left":160,"Transitions":[]},{"StatusId":80,"Top":139,"Left":652,"Transitions":[{"StatusId":78,"Groups":[1]}]},{"StatusId":81,"Top":281,"Left":20,"Transitions":[{"StatusId":82,"Groups":[1]}]},{"StatusId":82,"Top":208,"Left":132,"Transitions":[{"StatusId":77,"Groups":[1]}]}]}','','11')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('79','1','Plan','assets/images/meta/SENTRY/test-component.png','#374fe8','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"ReportedBy","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"ReportedBy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ResolvedDate","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Source","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"ReportedBy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"ResolvedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"D8DECEB7-BA6D-4A3F-A4A7-C79A5A5585BA","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"598B4999-4C31-427D-9BBC-C84AD954E55A","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"EFEE5D50-7DF6-49C3-9D69-E7EFC1AFEF72","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"AC93C4F9-B512-4A3D-8B37-BC3D5F83429D","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:52:35.0285525Z","Revised":"2012-08-01T10:52:35.0285525Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":120,"Top":94,"Left":32,"Transitions":[{"StatusId":117,"Groups":[1]},{"StatusId":116,"Groups":[1]}]},{"StatusId":116,"Top":253,"Left":124,"Transitions":[{"StatusId":115,"Groups":[1]}]},{"StatusId":117,"Top":17,"Left":224,"Transitions":[]},{"StatusId":115,"Top":247,"Left":458,"Transitions":[{"StatusId":118,"Groups":[1]},{"StatusId":117,"Groups":[1]}]},{"StatusId":118,"Top":517,"Left":284,"Transitions":[{"StatusId":119,"Groups":[1]}]},{"StatusId":119,"Top":570,"Left":608,"Transitions":[{"StatusId":114,"Groups":[1]}]},{"StatusId":114,"Top":452,"Left":687,"Transitions":[]}]}','','16')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('58','4','Change Request','assets/images/meta/AGILE/type-changerequest.png','#171517','{"ReferenceId":55,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"DueDate","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Visibility","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:18:16.5718155Z","Revised":"2012-08-01T10:18:16.5718155Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":55,"Status":[{"StatusId":64,"Top":0,"Left":0,"Transitions":[{"StatusId":65,"Groups":[1]}]},{"StatusId":65,"Top":0,"Left":0,"Transitions":[{"StatusId":66,"Groups":[1]}]},{"StatusId":66,"Top":0,"Left":0,"Transitions":[{"StatusId":68,"Groups":[1]},{"StatusId":69,"Groups":[1]}]},{"StatusId":67,"Top":10,"Left":460,"Transitions":[{"StatusId":68,"Groups":[1]}]},{"StatusId":68,"Top":10,"Left":610,"Transitions":[{"StatusId":69,"Groups":[1]}]},{"StatusId":69,"Top":10,"Left":760,"Transitions":[{"StatusId":70,"Groups":[1]}]},{"StatusId":70,"Top":0,"Left":0,"Transitions":[]},{"StatusId":71,"Top":0,"Left":0,"Transitions":[{"StatusId":65,"Groups":[1]}]}]}','','10')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('62','3','New Requirement','assets/images/meta/ENQUIRY/status-ready-for-approval.png','#18ad59','{"ReferenceId":61,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"39","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"40","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"AssociatedHierarchy","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"39","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"40","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"Status","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"39","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"40","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"AssociatedHistory","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssociatedSourceControl","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T09:00:22.5454765Z","Revised":"2012-08-01T09:00:22.5454765Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":72,"Top":10,"Left":10,"Transitions":[]},{"StatusId":73,"Top":10,"Left":160,"Transitions":[]},{"StatusId":76,"Top":437,"Left":709,"Transitions":[{"StatusId":78,"Groups":[1]}]},{"StatusId":74,"Top":194,"Left":62,"Transitions":[{"StatusId":81,"Groups":[1]}]},{"StatusId":75,"Top":152,"Left":441,"Transitions":[]},{"StatusId":77,"Top":281,"Left":620,"Transitions":[{"StatusId":78,"Groups":[1]},{"StatusId":76,"Groups":[1]}]},{"StatusId":78,"Top":431,"Left":439,"Transitions":[]},{"StatusId":79,"Top":86,"Left":229,"Transitions":[]},{"StatusId":80,"Top":94,"Left":30,"Transitions":[]},{"StatusId":81,"Top":316,"Left":143,"Transitions":[{"StatusId":82,"Groups":[1]}]},{"StatusId":82,"Top":265,"Left":391,"Transitions":[{"StatusId":77,"Groups":[1]}]}]}','','11')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('67','4','Change Request','assets/images/meta/HELPDESK/type-changerequest.png','#171517','{"ReferenceId":64,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedHierarchy","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedHistory","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssociatedWatchers","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T19:03:41.8119561Z","Revised":"2012-08-01T19:03:41.8119561Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":66,"Status":[{"StatusId":92,"Top":0,"Left":9,"Transitions":[{"StatusId":87,"Groups":[1]}]},{"StatusId":86,"Top":0,"Left":0,"Transitions":[{"StatusId":85,"Groups":[1]},{"StatusId":87,"Groups":[1]}]},{"StatusId":88,"Top":0,"Left":0,"Transitions":[]},{"StatusId":83,"Top":10,"Left":460,"Transitions":[]},{"StatusId":87,"Top":0,"Left":0,"Transitions":[]},{"StatusId":84,"Top":10,"Left":760,"Transitions":[]},{"StatusId":90,"Top":0,"Left":0,"Transitions":[{"StatusId":87,"Groups":[1]}]},{"StatusId":89,"Top":80,"Left":160,"Transitions":[]},{"StatusId":85,"Top":0,"Left":0,"Transitions":[]},{"StatusId":91,"Top":0,"Left":0,"Transitions":[{"StatusId":88,"Groups":[1]}]}]}','','12')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('68','5','Task','assets/images/meta/HELPDESK/type-task.png','#e68012','{"ReferenceId":64,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedComments","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedTime","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T19:03:45.5901722Z","Revised":"2012-08-01T19:03:45.5901722Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":66,"Status":[{"StatusId":92,"Top":0,"Left":0,"Transitions":[]},{"StatusId":86,"Top":0,"Left":0,"Transitions":[{"StatusId":87,"Groups":[1]}]},{"StatusId":88,"Top":0,"Left":0,"Transitions":[]},{"StatusId":83,"Top":10,"Left":460,"Transitions":[]},{"StatusId":87,"Top":0,"Left":0,"Transitions":[{"StatusId":88,"Groups":[1]}]},{"StatusId":84,"Top":10,"Left":760,"Transitions":[]},{"StatusId":90,"Top":80,"Left":10,"Transitions":[]},{"StatusId":89,"Top":80,"Left":160,"Transitions":[]},{"StatusId":85,"Top":0,"Left":0,"Transitions":[]},{"StatusId":91,"Top":80,"Left":460,"Transitions":[]}]}','','12')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('66','3','Support Request','assets/images/meta/HELPDESK/type-enhancement.png','#e612e6','{"ReferenceId":64,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"AffectedVersions","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Visibility","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"AssociatedHistory","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedSourceControl","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T19:03:38.1437463Z","Revised":"2012-08-01T19:03:38.1437463Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":85,"Top":112,"Left":156,"Transitions":[{"StatusId":92,"Groups":[1]},{"StatusId":121,"Groups":[1]}]},{"StatusId":92,"Top":275,"Left":28,"Transitions":[{"StatusId":87,"Groups":[1]}]},{"StatusId":121,"Top":103,"Left":392,"Transitions":[{"StatusId":87,"Groups":[1]}]},{"StatusId":87,"Top":390,"Left":359,"Transitions":[{"StatusId":88,"Groups":[1]}]},{"StatusId":88,"Top":254,"Left":557,"Transitions":[]}]}','','12')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('55','2','Story','assets/images/meta/AGILE/type-enhancement.png','#e612e6','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"DueDate","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Visibility","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"23","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:18:10.2924563Z","Revised":"2012-08-01T10:18:10.2924563Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":65,"Top":24,"Left":48,"Transitions":[]},{"StatusId":66,"Top":108,"Left":48,"Transitions":[{"StatusId":69,"Groups":[1]}]},{"StatusId":69,"Top":288,"Left":219,"Transitions":[{"StatusId":68,"Groups":[1]}]},{"StatusId":68,"Top":459,"Left":313,"Transitions":[{"StatusId":70,"Groups":[1]}]},{"StatusId":70,"Top":587,"Left":525,"Transitions":[]}]}','','10')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('82','0','New Feature','assets/images/meta/type-newfeature.png','#ed974c','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Visibility","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"DueDate","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"ReportedBy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ResolvedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Severity","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"CalculatedTimeExceeded","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"CalculatedTimeRemaining","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":26,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":27,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":28,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":29,"Label":"","Id":"AssociatedSourceControl","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":30,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:06:17.8907093Z","Revised":"2012-08-01T10:06:17.8907093Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":96,"Top":128,"Left":54,"Transitions":[{"StatusId":97,"Groups":[1]}]},{"StatusId":98,"Top":477,"Left":497,"Transitions":[{"StatusId":99,"Groups":[1]}]},{"StatusId":97,"Top":297,"Left":259,"Transitions":[{"StatusId":98,"Groups":[1]}]},{"StatusId":99,"Top":126,"Left":673,"Transitions":[{"StatusId":95,"Groups":[1]},{"StatusId":97,"Groups":[1]}]},{"StatusId":95,"Top":35,"Left":273,"Transitions":[{"StatusId":96,"Groups":[1]},{"StatusId":97,"Groups":[1]}]}]}','','13')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('69','1','Investigation','assets/images/meta/ISSUES/type-investigation.png','#ffd000','{"ReferenceId":82,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"26","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"28","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Votes","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"26","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"28","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedComments","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"26","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"28","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedComments","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T08:48:03.368198Z","Revised":"2012-08-01T08:48:03.368198Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":82,"Status":[{"StatusId":96,"Top":0,"Left":9,"Transitions":[{"StatusId":97,"Groups":[1]},{"StatusId":98,"Groups":[1]}]},{"StatusId":98,"Top":407,"Left":0,"Transitions":[{"StatusId":99,"Groups":[1]}]},{"StatusId":93,"Top":10,"Left":310,"Transitions":[]},{"StatusId":97,"Top":0,"Left":577,"Transitions":[{"StatusId":98,"Groups":[1]}]},{"StatusId":94,"Top":10,"Left":610,"Transitions":[]},{"StatusId":99,"Top":41,"Left":151,"Transitions":[{"StatusId":96,"Groups":[1]},{"StatusId":95,"Groups":[1]}]},{"StatusId":95,"Top":0,"Left":0,"Transitions":[{"StatusId":96,"Groups":[1]}]}]}','','13')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('71','3','Enhancement','assets/images/meta/ISSUES/type-enhancement.png','#e612e6','{"ReferenceId":82,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssociatedWatchers","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"AssociatedHistory","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"Visibility","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AffectedVersions","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"AssociatedHistory","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"AssociatedTime","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedSourceControl","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T08:48:37.9301748Z","Revised":"2012-08-01T08:48:37.9301748Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":82,"Status":[{"StatusId":100,"Top":10,"Left":10,"Transitions":[{"StatusId":96,"Groups":[1]},{"StatusId":95,"Groups":[1]}]},{"StatusId":96,"Top":10,"Left":160,"Transitions":[]},{"StatusId":98,"Top":10,"Left":310,"Transitions":[]},{"StatusId":93,"Top":10,"Left":460,"Transitions":[]},{"StatusId":97,"Top":0,"Left":0,"Transitions":[{"StatusId":98,"Groups":[1]}]},{"StatusId":94,"Top":10,"Left":760,"Transitions":[]},{"StatusId":99,"Top":80,"Left":10,"Transitions":[]},{"StatusId":95,"Top":80,"Left":160,"Transitions":[{"StatusId":97,"Groups":[1]},{"StatusId":96,"Groups":[1]}]}]}','','13')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('72','4','Change Request','assets/images/meta/ISSUES/type-changerequest.png','#171517','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedAttachments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedHistory","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Points","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Votes","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"AssociatedHistory","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"AssociatedLinks","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedWatchers","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T08:48:43.3254834Z","Revised":"2012-08-01T08:48:43.3254834Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":82,"Status":[{"StatusId":100,"Top":10,"Left":10,"Transitions":[{"StatusId":96,"Groups":[1]},{"StatusId":95,"Groups":[1]}]},{"StatusId":96,"Top":10,"Left":160,"Transitions":[]},{"StatusId":98,"Top":10,"Left":310,"Transitions":[]},{"StatusId":93,"Top":10,"Left":460,"Transitions":[]},{"StatusId":97,"Top":0,"Left":0,"Transitions":[{"StatusId":98,"Groups":[1]}]},{"StatusId":94,"Top":10,"Left":760,"Transitions":[]},{"StatusId":99,"Top":80,"Left":10,"Transitions":[]},{"StatusId":95,"Top":80,"Left":160,"Transitions":[{"StatusId":97,"Groups":[1]},{"StatusId":96,"Groups":[1]}]}]}','','13')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('73','5','Task','assets/images/meta/ISSUES/type-task.png','#3c12e6','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedTime","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T08:48:45.8836297Z","Revised":"2012-08-01T08:48:45.8836297Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":82,"Status":[{"StatusId":100,"Top":10,"Left":10,"Transitions":[]},{"StatusId":96,"Top":0,"Left":0,"Transitions":[{"StatusId":98,"Groups":[1]},{"StatusId":95,"Groups":[1]},{"StatusId":97,"Groups":[1]}]},{"StatusId":98,"Top":10,"Left":310,"Transitions":[]},{"StatusId":93,"Top":10,"Left":460,"Transitions":[]},{"StatusId":97,"Top":0,"Left":0,"Transitions":[{"StatusId":98,"Groups":[1]}]},{"StatusId":94,"Top":10,"Left":760,"Transitions":[]},{"StatusId":99,"Top":9,"Left":0,"Transitions":[]},{"StatusId":95,"Top":80,"Left":160,"Transitions":[{"StatusId":96,"Groups":[1]}]}]}','','13')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('75','2','Task','assets/images/meta/MARKETING/type-task.png','#522c52','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"34","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"35","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"33","Type":1}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"34","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"35","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"33","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"PercentComplete","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"PercentComplete","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"34","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"35","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"33","Type":1},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"C8F0693D-129C-4D19-9865-9CED964F06AB","Type":2}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:07:43.677616Z","Revised":"2012-08-01T10:07:43.677616Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":104,"Top":21,"Left":211,"Transitions":[]},{"StatusId":101,"Top":221,"Left":497,"Transitions":[{"StatusId":103,"Groups":[1]}]},{"StatusId":102,"Top":124,"Left":279,"Transitions":[{"StatusId":101,"Groups":[1]}]},{"StatusId":103,"Top":311,"Left":261,"Transitions":[{"StatusId":102,"Groups":[1]}]}]}','','14')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('78','3','Task','assets/images/meta/REQUIREMENTS/type-task.png','#e68012','{"ReferenceId":76,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedAttachments","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedComments","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssociatedTime","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T11:03:58.7526593Z","Revised":"2012-08-01T11:03:58.7526593Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":76,"Status":[{"StatusId":105,"Top":189,"Left":202,"Transitions":[{"StatusId":112,"Groups":[1]}]},{"StatusId":110,"Top":211,"Left":553,"Transitions":[{"StatusId":111,"Groups":[1]}]},{"StatusId":106,"Top":264,"Left":10,"Transitions":[]},{"StatusId":112,"Top":385,"Left":152,"Transitions":[{"StatusId":110,"Groups":[1]}]},{"StatusId":107,"Top":22,"Left":176,"Transitions":[]},{"StatusId":111,"Top":92,"Left":628,"Transitions":[{"StatusId":108,"Groups":[1]}]},{"StatusId":108,"Top":84,"Left":328,"Transitions":[{"StatusId":105,"Groups":[1]}]},{"StatusId":109,"Top":438,"Left":560,"Transitions":[]}]}','','15')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('76','1','Requirement','assets/images/meta/REQUIREMENTS/type-enhancement.png','#e612e6','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"DueDate","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Resolution","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"IssueKey","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Priority","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"FixedInVersion","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"Resolution","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"ResolvedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"EstimatedEffort","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"CalculatedTimeLogged","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":17,"Label":"","Id":"CalculatedTimeExceeded","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":18,"Label":"","Id":"CalculatedTimeRemaining","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":19,"Label":"","Id":"Visibility","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":20,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":21,"Label":"","Id":"AssociatedAttachments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":22,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":23,"Label":"","Id":"AssociatedHierarchy","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":24,"Label":"","Id":"C8F0693D-129C-4D19-9865-9CED964F06AB","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":25,"Label":"","Id":"AssociatedWatchers","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":26,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T11:03:53.3703514Z","Revised":"2012-08-01T11:03:53.3703514Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":0,"Status":[{"StatusId":108,"Top":25,"Left":98,"Transitions":[{"StatusId":110,"Groups":[1]},{"StatusId":109,"Groups":[1]}]},{"StatusId":109,"Top":40,"Left":575,"Transitions":[{"StatusId":105,"Groups":[1]}]},{"StatusId":105,"Top":329,"Left":526,"Transitions":[{"StatusId":112,"Groups":[1]}]},{"StatusId":112,"Top":558,"Left":503,"Transitions":[{"StatusId":110,"Groups":[1]}]},{"StatusId":110,"Top":378,"Left":70,"Transitions":[{"StatusId":111,"Groups":[1]}]},{"StatusId":111,"Top":222,"Left":288,"Transitions":[{"StatusId":109,"Groups":[1]}]}]}','','15')
INSERT gemini_issuetypes(typeid,seq,typedesc,imagepath,color,screen,workflow,tag,templateid) VALUES('80','2','Case','assets/images/meta/type-task.png','#20700c','{"ReferenceId":0,"Create":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0}],"Edit":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"DueDate","Type":0}],"View":[{"ProjectGroups":[1],"Required":false,"Sequence":0,"Label":"","Id":"Type","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":1,"Label":"","Id":"Title","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":2,"Label":"","Id":"Status","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":3,"Label":"","Id":"Component","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":4,"Label":"","Id":"AssignedTo","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":5,"Label":"","Id":"StartDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":6,"Label":"","Id":"DueDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":7,"Label":"","Id":"ResolvedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":8,"Label":"","Id":"ClosedDate","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":9,"Label":"","Id":"DateCreated","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":10,"Label":"","Id":"DateRevised","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":11,"Label":"","Id":"Description","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":12,"Label":"","Id":"AssociatedComments","Type":0},{"ProjectGroups":[1],"Required":false,"Sequence":13,"Label":"","Id":"617F1435-C0AA-48E6-B6A9-2C1F756E02A6","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":14,"Label":"","Id":"ACE2F8B3-C724-444F-9B72-B8B2137DDA16","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":15,"Label":"","Id":"15627A0F-5AD2-4D35-BF24-60D678F59354","Type":2},{"ProjectGroups":[1],"Required":false,"Sequence":16,"Label":"","Id":"AssociatedHistory","Type":0}],"IsNew":true,"IsExisting":false,"Active":true,"Archived":false,"Deleted":false,"Created":"2012-08-01T10:55:12.1545396Z","Revised":"2012-08-01T10:55:12.1545396Z","Errors":[],"HasErrors":false,"Id":0}','{"ReferenceId":79,"Status":[{"StatusId":116,"Top":143,"Left":332,"Transitions":[{"StatusId":118,"Groups":[1]}]},{"StatusId":119,"Top":10,"Left":160,"Transitions":[]},{"StatusId":115,"Top":227,"Left":394,"Transitions":[{"StatusId":114,"Groups":[1]},{"StatusId":116,"Groups":[1]},{"StatusId":117,"Groups":[1]}]},{"StatusId":114,"Top":360,"Left":399,"Transitions":[{"StatusId":115,"Groups":[1]}]},{"StatusId":118,"Top":20,"Left":445,"Transitions":[{"StatusId":119,"Groups":[1]},{"StatusId":117,"Groups":[1]}]},{"StatusId":117,"Top":10,"Left":760,"Transitions":[{"StatusId":114,"Groups":[1]}]},{"StatusId":113,"Top":317,"Left":173,"Transitions":[{"StatusId":114,"Groups":[1]}]}]}','','16')
SET IDENTITY_INSERT gemini_issuetypes OFF

SET IDENTITY_INSERT gemini_issuepriorities ON
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('29','1','Low','assets/images/meta/AGILE/priority-low.png','#0000ff','10')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('30','2','Medium','assets/images/meta/AGILE/priority-medium.png','#ffffff','10')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('31','3','High','assets/images/meta/AGILE/priority-high.png','#eb0c1f','10')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('32','1','Low','assets/images/meta/ENQUIRY/priority-low.png','#0000ff','11')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('33','2','Medium','assets/images/meta/ENQUIRY/priority-medium.png','#ffffff','11')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('34','3','High','assets/images/meta/ENQUIRY/priority-high.png','#eb0c1f','11')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('35','1','Low','assets/images/meta/HELPDESK/priority-low.png','#0000ff','12')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('36','2','Medium','assets/images/meta/HELPDESK/priority-medium.png','#ffffff','12')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('37','3','High','assets/images/meta/HELPDESK/priority-high.png','#eb0c1f','12')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('38','1','Low','assets/images/meta/ISSUES/priority-low.png','#0000ff','13')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('39','2','Medium','assets/images/meta/ISSUES/priority-medium.png','#ffffff','13')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('40','3','High','assets/images/meta/ISSUES/priority-high.png','#eb0c1f','13')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('41','1','High','assets/images/meta/MARKETING/priority-high.png','#a30d21','14')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('42','2','Low','assets/images/meta/MARKETING/priority-low.png','#0000ff','14')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('43','3','Medium','assets/images/meta/MARKETING/priority-medium.png','#161670','14')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('44','1','Low','assets/images/meta/REQUIREMENTS/priority-low.png','#0000ff','15')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('45','2','Medium','assets/images/meta/REQUIREMENTS/priority-medium.png','#ffffff','15')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('46','3','High','assets/images/meta/REQUIREMENTS/priority-high.png','#eb0c1f','15')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('47','1','High','assets/images/meta/SENTRY/priority-high.png','#e81717','16')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('48','2','Low','assets/images/meta/SENTRY/priority-low.png','#b8b8e6','16')
INSERT gemini_issuepriorities(priorityid,seq,prioritydesc,imagepath,color,templateid) VALUES('49','3','Medium','assets/images/meta/SENTRY/priority-medium.png','#c7732a','16')
SET IDENTITY_INSERT gemini_issuepriorities OFF

SET IDENTITY_INSERT gemini_issueseverity ON
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('30','1','Trivial','assets/images/meta/AGILE/severity-trivial.png','','10')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('31','2','Minor','assets/images/meta/AGILE/severity-minor.png','#0000ff','10')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('32','3','Major','assets/images/meta/AGILE/severity-major.png','#8c054d','10')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('33','1','Trivial','assets/images/meta/ENQUIRY/severity-trivial.png','#1a6145','11')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('34','2','Minor','assets/images/meta/ENQUIRY/severity-minor.png','#0000ff','11')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('35','3','Major','assets/images/meta/ENQUIRY/severity-major.png','#8c054d','11')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('36','4','Critical','assets/images/meta/ENQUIRY/severity-showstopper.png','#fa0021','11')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('37','1','Trivial','assets/images/meta/HELPDESK/severity-trivial.png','','12')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('38','2','Minor','assets/images/meta/HELPDESK/severity-minor.png','#0000ff','12')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('39','3','Major','assets/images/meta/HELPDESK/severity-major.png','#8c054d','12')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('40','1','Trivial','assets/images/meta/ISSUES/severity-trivial.png','','13')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('41','2','Minor','assets/images/meta/ISSUES/severity-minor.png','#0000ff','13')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('42','3','Major','assets/images/meta/ISSUES/severity-major.png','#8c054d','13')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('43','1','Minor','assets/images/meta/MARKETING/severity-minor.png','#0000ff','14')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('44','2','Major','assets/images/meta/MARKETING/severity-major.png','#a80a31','14')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('45','1','Trivial','assets/images/meta/REQUIREMENTS/severity-trivial.png','','15')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('46','2','Minor','assets/images/meta/REQUIREMENTS/severity-minor.png','#0000ff','15')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('47','3','Major','assets/images/meta/REQUIREMENTS/severity-major.png','#8c054d','15')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('48','1','Minor','assets/images/meta/SENTRY/severity-minor.png','#9595d6','16')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('49','2','Major','assets/images/meta/SENTRY/severity-major.png','#bd20bd','16')
INSERT gemini_issueseverity(severityid,seq,severitydesc,imagepath,color,templateid) VALUES('50','3','Critical','assets/images/meta/SENTRY/severity-showstopper.png','#e80523','16')
SET IDENTITY_INSERT gemini_issueseverity OFF

SET IDENTITY_INSERT gemini_issuestatus ON
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('65','0','In Backlog','0','assets/images/meta/AGILE/test-blackbox.png','','#3d213d','1','10')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('66','0','In Sprint','0','assets/images/meta/status-ready-for-approval.png','','#b4bf17','2','10')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('68','0','Tested','0','assets/images/meta/type-qualitycheck.png','','#d16817','4','10')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('69','0','In Progress','0','assets/images/meta/AGILE/status-inprogress.png','','#166b08','3','10')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('70','1','Closed','1','assets/images/meta/AGILE/status-closed.png','','#1326f5','5','10')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('72','0','Escalation-Level1','0','assets/images/meta/ENQUIRY/test-requirements.png','','#bf6a1f','1','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('73','0','Escalation-Level2','0','assets/images/meta/ENQUIRY/test-stress.png','','#f50a0a','2','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('74','0','Raised','0','assets/images/meta/ENQUIRY/type-newfeature.png','','#a0c218','3','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('75','0','User Rejected','0','assets/images/meta/ENQUIRY/status-rejected.png','','#754b0d','6','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('76','0','Moved to Delivery','0','assets/images/meta/ENQUIRY/test-blackbox.png','','#7a12a3','9','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('77','0','Assigned','0','assets/images/meta/ENQUIRY/status-assigned.png','','#47d119','7','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('78','1','Closed','1','assets/images/meta/ENQUIRY/status-closed.png','','#0f0907','10','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('79','0','Case Reopened','0','assets/images/meta/ENQUIRY/status-reopened.png','','#0a1c91','11','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('80','0','User Accepted','0','assets/images/meta/ENQUIRY/test-acceptance.png','','#541454','8','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('81','0','Pending Approval','0','assets/images/meta/ENQUIRY/status-ready-for-approval.png','','#787167','4','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('82','0','Approved','0','assets/images/meta/ENQUIRY/status-approved.png','','#099e38','5','11')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('85','0','Unassigned','0','assets/images/meta/HELPDESK/status-unassigned.png','','#0000ff','1','12')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('87','0','In Progress','0','assets/images/meta/HELPDESK/status-inprogress.png','','#a130a1','5','12')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('88','1','Closed','1','assets/images/meta/HELPDESK/status-closed.png','','#eb8023','6','12')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('92','0','Approved','0','assets/images/meta/HELPDESK/status-approved.png','','#099e38','2','12')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('95','0','Unassigned','0','assets/images/meta/ISSUES/status-unassigned.png','','#0000ff','1','13')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('96','0','Assigned','0','assets/images/meta/ISSUES/status-assigned.png','','#d9782e','2','13')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('97','0','In Progress','0','assets/images/meta/ISSUES/status-inprogress.png','','#a130a1','3','13')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('98','1','Closed','1','assets/images/meta/ISSUES/status-closed.png','','#28b845','4','13')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('99','0','Reopened','0','assets/images/meta/ISSUES/status-reopened.png','','#f52525','5','13')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('101','1','Planned','1','assets/images/meta/MARKETING/status-assigned.png','','#16b821','2','14')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('102','0','In Progress','0','assets/images/meta/MARKETING/status-inprogress.png','','#941894','3','14')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('103','0','Completed','0','assets/images/meta/MARKETING/status-closed.png','','#c7bf2a','4','14')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('104','0','Parked','0','assets/images/meta/MARKETING/status-postponed.png','','#5e105e','1','14')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('105','0','Approved','0','assets/images/meta/REQUIREMENTS/status-approved.png','','#36a820','3','15')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('108','0','Requirement','0','assets/images/meta/REQUIREMENTS/status-unassigned.png','','#0000ff','1','15')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('109','0','Walkthrough','0','assets/images/meta/REQUIREMENTS/status-assigned.png','','#47d119','2','15')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('110','1','Closed','1','assets/images/meta/REQUIREMENTS/status-closed.png','','#eb1deb','5','15')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('111','0','Reopened','0','assets/images/meta/REQUIREMENTS/status-reopened.png','','#0a1c91','6','15')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('112','0','In Progress','0','assets/images/meta/REQUIREMENTS/status-inprogress.png','','#8c3d8c','4','15')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('114','1','Closed','0','assets/images/meta/status-closed.png','','#818f17','7','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('115','0','In Progress','0','assets/images/meta/status-inprogress.png','','#c95d36','4','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('116','0','Accepted','0','assets/images/meta/SENTRY/test-acceptance.png','','#126b0d','2','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('117','1','Rejected','0','assets/images/meta/SENTRY/status-rejected.png','','#e60330','3','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('118','0','Ready For Deploy','0','assets/images/meta/test-whitebox.png','','#2e292e','5','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('119','0','Deployed','0','assets/images/meta/test-blackbox.png','','#3636d1','6','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('120','0','Assessing','0','assets/images/meta/status-check.png','','#e316e3','1','16')
INSERT gemini_issuestatus(statusid,isfinal,statusdesc,statustype,imagepath,comment,color,seq,templateid) VALUES('121','0','Rejected','0','assets/images/meta/status-rejected.png','','#b3164f','3','12')
SET IDENTITY_INSERT gemini_issuestatus OFF

SET IDENTITY_INSERT gemini_issueresolutions ON
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('21','1','0','Unresolved','10')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('22','5','1','Complete','10')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('23','1','1','Back to Client','11')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('24','2','1','Complete','11')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('25','1','0','Unresolved','12')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('26','2','1','Complete','12')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('27','1','0','Unresolved','13')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('28','5','1','Complete','13')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('29','1','0','Unresolved','14')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('30','3','1','Complete','14')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('31','2','0','Parked','15')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('32','4','1','Complete','15')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('33','1','0','Unresolved','16')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('34','3','1','Resolved','16')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('35','4','1','Rejected','10')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('36','3','1','Duplicate','10')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('37','2','0','Parked','10')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('38','3','1','Duplicate','13')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('39','4','1','Rejected','13')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('40','2','0','Parked','13')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('41','0','0','Unresolved','11')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('42','0','1','Rejected','12')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('43','2','0','Parked','14')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('44','1','0','Unresolved','15')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('45','3','0','Rejected','15')
INSERT gemini_issueresolutions(resolutionid,seq,isfinal,resdesc,templateid) VALUES('46','2','1','Rejected','16')
SET IDENTITY_INSERT gemini_issueresolutions OFF

SET IDENTITY_INSERT gemini_issuelinktypes ON
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('19','Duplicated','','10')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('20','Related','','10')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('21','Duplicated','','11')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('22','Related','','11')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('23','Duplicated','','12')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('24','Related','','12')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('25','Duplicated','','13')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('26','Related','','13')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('27','Duplicated','','14')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('28','Related','','14')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('29','Duplicated','','15')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('30','Related','','15')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('31','Duplicated','','16')
INSERT gemini_issuelinktypes(linktypeid,linkname,linkdesc,templateid) VALUES('32','Related','','16')
SET IDENTITY_INSERT gemini_issuelinktypes OFF

SET IDENTITY_INSERT gemini_issuetimetype ON
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('30','Billable','','10')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('31','Non-Billable','','10')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('32','Internal','','10')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('33','Scrum Master PM','','10')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('34','Testing','','10')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('35','Billable','','11')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('36','Non-Billable','','11')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('37','Internal','','11')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('38','Billable','','12')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('39','Non-Billable','','12')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('40','Internal','','12')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('41','Scrum Master PM','','12')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('42','Testing','','12')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('43','Billable','','13')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('44','Non-Billable','','13')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('45','Internal','','13')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('46','Scrum Master PM','','13')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('47','Testing','','13')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('48','Billable','','14')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('49','non-billable','','14')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('50','Internal','','14')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('51','Billable','','15')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('52','Non-Billable','','15')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('53','Internal','','15')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('54','Scrum Master PM','','15')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('55','Testing','','15')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('56','Billable','','16')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('57','Non-billable','','16')
INSERT gemini_issuetimetype(timetypeid,timetypename,timetypedesc,templateid) VALUES('58','Internal','','16')
SET IDENTITY_INSERT gemini_issuetimetype OFF

SET IDENTITY_INSERT gemini_customfielddefinitions ON
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('22','Customer','0','Customer','Our Client name','Select the customer from the list','0','1','','C','','','','','1','1','Customer A
Customer B
Customer C
','0.00000','0.00000','','0','10','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('24','Customer','0','Customer','','Select the customer from the list','0','1','','L','','','','','1','1','Customer A
Customer B
Customer C
','0.00000','0.00000','','0','11','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('25','Product Platform','0','Product Platform (OS)','','Product Platform (OS)','0','0','','C','','','','','0','1','Windows 7
Windows 8
Linux
Ubuntu
Mac OS
iPad
','0.00000','0.00000','','0','11','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('26','Needs Approval','0','Needs Approval','','Needs Approval','0','0','','Y','','','','','0','1','                                              ','0.00000','0.00000','','0','11','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('27','Customer','0','Customer','Our Client name','Select the customer from the list','0','1','','L','','','','','1','1','Customer A
Customer B
Customer C
','0.00000','0.00000','','0','12','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('28','User Application','0','User Application','','User Application','0','0','','C','','','','','0','1','Peoplesoft Financials
Peoplesoft HR
Dynamics CRM
OURSYS
Inventory Management
Other
','0.00000','0.00000','','0','12','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('29','Product Platform','0','Product Platform (OS)','','Product Platform (OS)','0','0','','C','','','','','0','1','Windows 7
Windows 8
Linux
Ubuntu
Mac OS
iPad
','0.00000','0.00000','','0','12','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('30','Customer','0','Customer','Our Client name','Select the customer from the list','0','1','','L','','','','','1','1','Customer A
Customer B
Customer C
','0.00000','0.00000','','0','13','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('31','User Application','0','User Application','','User Application','0','0','','C','','','','','0','1','Peoplesoft Financials
Peoplesoft HR
Dynamics CRM
OURSYS
Inventory Management
Other
','0.00000','0.00000','','0','13','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('32','Product Platform','0','Product Platform (OS)','','Product Platform (OS)','0','0','','C','','','','','0','1','Windows 7
Windows 8
Linux
Ubuntu
Mac OS
iPad
','0.00000','0.00000','','0','13','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('33','Owner','0','Owner','Who ownes it?','Select the owner from the list','0','0','','C','','','','','0','1','N/A
Me
You
Some Else
','0.00000','0.00000','','0','14','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('34','Agencies','0','Agencies','','Agencies Involved','0','0','','C','','','','','0','1','N/A
MRM Worldwide
Mcann
Ogilvy and Mather
Saatchi and Saatchi
Jalebi
Jellbean Creative
Other
','0.00000','0.00000','','0','14','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('35','Budget Approved','0','Budget Approved','','Budget Approver','0','0','','Y','','','','','0','1','                                              ','0.00000','0.00000','','0','14','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('36','Customer','0','Customer','Our Client name','Select the customer from the list','0','1','','C','','','','','1','1','Customer A
Customer B
Customer C
','0.00000','0.00000','','0','15','1')
INSERT gemini_customfielddefinitions(customfieldid,customfieldname,screenorder,screenlabel,screendescription,screentooltip,maxlen,canmultiselect,regularexp,customfieldtype,lookupname,lookupvaluefield,lookuptextfield,lookupsortfield,projectidfilter,showinline,lookupdata,maxvalue,minvalue,listlimiter,usedin,templateid,usestaticdata) VALUES('38','Client/Project','0','Client/Project','','Client/Project','0','0','','C','','','','','0','1','N/A
Client A - Project A
Client A - Project B
Client A - Project C
Client B - Project 1
Client B - Project 2
Client C  Client D
','0.00000','0.00000','','0','16','1')
SET IDENTITY_INSERT gemini_customfielddefinitions OFF
GO

CREATE TABLE breeze_mailboxmessage (
      messageid INT IDENTITY(1,1) NOT NULL CONSTRAINT breeze_mailboxmessage_messageid_pk PRIMARY KEY,
      mailboxid INT NOT NULL CONSTRAINT breeze_mailboxmessage_mailboxid_def DEFAULT(0),
      [uid] NVARCHAR(255) NOT NULL CONSTRAINT breeze_mailboxmesssage_uid_def DEFAULT(''),
      created DATETIME NOT NULL CONSTRAINT breeze_mailboxmessage_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

/**********************************************************************************************************************
* End
**********************************************************************************************************************/

/*

DETECT FK ISSUES

select distinct name from sys.objects where object_id in 
(   select fk.constraint_object_id from sys.foreign_key_columns as fk
    where fk.referenced_object_id = 
        (select object_id from sys.tables where name = 'gemini_mailboxprocessor')
)

select t.name as TableWithForeignKey, fk.constraint_column_id as FK_PartNo , c.name as ForeignKeyColumn 
from sys.foreign_key_columns as fk
inner join sys.tables as t on fk.parent_object_id = t.object_id
inner join sys.columns as c on fk.parent_object_id = c.object_id and fk.parent_column_id = c.column_id
where fk.referenced_object_id = (select object_id from sys.tables where name = 'gemini_mailboxprocessor')
order by TableWithForeignKey, FK_PartNo

*/

