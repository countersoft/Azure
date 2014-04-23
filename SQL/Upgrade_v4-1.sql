--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini v4.1
--
-- DATA MIGRATION SCRIPT from Gemini 4.0 to Gemini 4.1
--
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'4.1')
GO

/**********************************************************************************************************************
* Fix inline edit list custom fields bug.
**********************************************************************************************************************/
UPDATE gemini_customfielddata SET fielddata=fielddata+'|'
WHERE fielddata != '' AND
customfieldid IN (SELECT customfieldid from gemini_customfielddefinitions where customfieldtype='L' OR (customfieldtype IN ('U','V','M') AND (canmultiselect=1 OR numrows>1)))
AND SUBSTRING(fielddata, LEN(fielddata),1)!='|'

/**********************************************************************************************************************
* Remove constraint from run steps as we want to allow deletion of steps from cases!
**********************************************************************************************************************/
ALTER TABLE gemini_testing_run_steps DROP CONSTRAINT gemini_testing_run_steps_stepid_fk 
GO

/***********************************************************
* Reports
***********************************************************/
DELETE FROM gemini_reportsvisibility WHERE reportid IN (SELECT reportid FROM gemini_reports WHERE reportsource IN ('~/Project/Reports/IssueAgeReportUC.ascx','~/Project/Reports/IssueStatusandResolutionReportUC.ascx','~/Project/Reports/IssuePriorityandTypeUC.ascx','~/Project/Reports/IssueByComponentUC.ascx','~/Project/Reports/ProjectTimeReportUC.ascx','~/Project/Reports/IssueTimeDurationReportUC.ascx'))
DELETE FROM gemini_reports WHERE reportsource IN
(
'~/Project/Reports/IssueAgeReportUC.ascx',
'~/Project/Reports/IssueStatusandResolutionReportUC.ascx',
'~/Project/Reports/IssuePriorityandTypeUC.ascx',
'~/Project/Reports/IssueByComponentUC.ascx',
'~/Project/Reports/ProjectTimeReportUC.ascx',
'~/Project/Reports/IssueTimeDurationReportUC.ascx'
)
GO
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Item Age','Item Age', '~/Project/Reports/IssueAgeReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Opened Recently', 'Opened Recently', '~/Project/Reports/RecentlyOpened.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Closed Recently', 'Closed Recently', '~/Project/Reports/RecentlyClosed.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due Next 90 Days', 'Due Next 90 Days', '~/Project/Reports/DueNext90Days.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due Next 60 Days', 'Due Next 60 Days', '~/Project/Reports/DueNext60Days.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due Next 30 Days', 'Due Next 30 Days', '~/Project/Reports/DueNext30Days.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due Next 10 Days', 'Due Next 10 Days', '~/Project/Reports/DueNext10Days.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due This Week', 'Due This Week', '~/Project/Reports/DueThisWeek.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due Next Week', 'Due Next Week', '~/Project/Reports/DueNextWeek.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due This Month', 'Due This Month', '~/Project/Reports/DueThisMonth.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Due Next Month', 'Due Next Month', '~/Project/Reports/DueNextMonth.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Resource Items Allocation', 'Resource Items Allocation', '~/Project/Reports/ResourcePlanningByItemsReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Resource Hours Allocation', 'Resource Hours Allocation', '~/Project/Reports/ResourcePlanningByHoursReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Component Activity', 'Component Activity', '~/Project/Reports/ComponentActivityReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Version Activity', 'Version Activity', '~/Project/Reports/VersionActivityReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Resource Activity', 'Resource Activity', '~/Project/Reports/ResourceActivityReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Type Activity', 'Type Activity', '~/Project/Reports/TypeActivityReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Severity Activity', 'Severity Activity', '~/Project/Reports/SeverityActivityReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Priority Activity', 'Priority Activity', '~/Project/Reports/PriorityActivityReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Activity Trend', 'Activity Trend', '~/Project/Reports/ActivityTrendReportUC.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Component Summary', 'Component Summary', '~/Project/ProjectNestedComponentsTab.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Version Progress', 'Version Progress', '~/Project/ProjectVersionTab.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Time Tracking', 'Time Tracking', '~/Project/ProjectTimeTab.ascx',getdate())
INSERT INTO gemini_reports (reportname, reportdesc, reportsource, created) VALUES ('Workload', 'Workload', '~/Controls/TabAllProjectsWorkload.ascx',getdate())
GO


INSERT INTO gemini_reportsvisibility (reportid, reporttype, projectid, visibility, visibilitymembertype)
	SELECT r.reportid, 3 as reportype, p.projectid, 1 as visibility, 2 as visibilitymembertype FROM gemini_projects p, gemini_reports r 
	WHERE r.reportsource IN 
	('~/Project/Reports/IssueAgeReportUC.ascx',
	 '~/Project/Reports/RecentlyOpened.ascx',
	 '~/Project/Reports/RecentlyClosed.ascx',
	 '~/Project/Reports/DueNext90Days.ascx',
	 '~/Project/Reports/DueNext60Days.ascx',
	 '~/Project/Reports/DueNext30Days.ascx',
	 '~/Project/Reports/DueNext10Days.ascx',
	 '~/Project/Reports/DueThisWeek.ascx',
	 '~/Project/Reports/DueNextWeek.ascx',
	 '~/Project/Reports/DueThisMonth.ascx',
	 '~/Project/Reports/DueNextMonth.ascx',
	 '~/Project/Reports/ResourcePlanningByItemsReportUC.ascx',
	 '~/Project/Reports/ResourcePlanningByHoursReportUC.ascx',
	 '~/Project/Reports/ComponentActivityReportUC.ascx',
	 '~/Project/Reports/VersionActivityReportUC.ascx',
	 '~/Project/Reports/ResourceActivityReportUC.ascx',
	 '~/Project/Reports/TypeActivityReportUC.ascx',
	 '~/Project/Reports/SeverityActivityReportUC.ascx',
	 '~/Project/Reports/PriorityActivityReportUC.ascx',
	 '~/Project/Reports/ActivityTrendReportUC.ascx',
	 '~/Project/ProjectNestedComponentsTab.ascx',
	 '~/Project/ProjectVersionTab.ascx',
	 '~/Project/ProjectTimeTab.ascx',
	 '~/Controls/TabAllProjectsWorkload.ascx'
	)
GO

/**********************************************************************************************************************
* AD table.
**********************************************************************************************************************/

CREATE TABLE gemini_adgroups
(
	adgroupid INT IDENTITY(1,1) NOT NULL CONSTRAINT gemini_adgroups_adgroupid_pk PRIMARY KEY,
	adgroupname NVARCHAR(500) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_adgroups_created_def DEFAULT (GETDATE()),
	tstamp TIMESTAMP NOT NULL
 )
 GO


CREATE TABLE gemini_admappings
(
   mappingid INT IDENTITY (1,1) NOT NULL CONSTRAINT gemini_admappings_mappingid_pk PRIMARY KEY,
   globalgroupid NUMERIC (10,0) NOT NULL CONSTRAINT gemini_admappings_globalgroups_fk FOREIGN KEY REFERENCES gemini_globalgroups(globalgroupid),
   adgroupid INT NOT NULL CONSTRAINT gemini_admappings_adgroups_fk FOREIGN KEY REFERENCES gemini_adgroups(adgroupid),
   lastsyncdate DATETIME NOT NULL,
   created DATETIME NOT NULL CONSTRAINT gemini_admappings_created_def DEFAULT (GETDATE()),
   tstamp TIMESTAMP NOT NULL
)
GO

CREATE INDEX ind_gemini_admappings_globalgroupid ON gemini_admappings(globalgroupid)
GO

INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc) VALUES (N'SyncWithActiveDirectory', N'Security', N'False', N'Do we sync users and groups with our Active Directory Server ?')
INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc) VALUES (N'ActiveDirectoryConnectionString', N'Security', N'', N'Active Directory Connection String (eg: LDAP://DC=Countersoft,DC=com')
INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc) VALUES (N'ActiveDirectoryUserName', N'Security', N'', N'Active Directory Username')
INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc) VALUES (N'ActiveDirectoryPassword', N'Security', N'', N'Active Directory Password')
INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc) VALUES (N'ActiveDirectoryAddNewUsers', N'Security', N'NO', N'Indicates whether to add new Active Directory users to Gemini')
GO

ALTER TABLE gemini_applicationsettings ALTER COLUMN settingvalue NVARCHAR(MAX) NOT NULL
GO
