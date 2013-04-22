--*********************************************************************************
--*********************************************************************************
--
-- (c) CouterSoft Gemini Issue Tracker -- Version 3.7
--
-- DATA MIGRATION SCRIPT from Gemini 3.6 to Gemini 3.7
--
--*********************************************************************************
--*********************************************************************************

TRUNCATE TABLE gemini_install
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'3.7')
GO

/***********************************************************
* Percent Complete
***********************************************************/
UPDATE gemini_issues SET percentcomplete=0
GO

UPDATE i
	SET i.percentcomplete = CAST(CASE WHEN (t.hours * 60 + t.minutes) / (i.estimatehours * 60 + i.estimateminutes) * 100 > 100 THEN 100 ELSE (t.hours * 60 + t.minutes) / (i.estimatehours * 60 + i.estimateminutes) * 100 END AS INT)
FROM gemini_issues i JOIN (SELECT tr.issueid, SUM(tr.hours) AS hours, SUM(tr.minutes) AS minutes FROM gemini_timetracking tr GROUP BY tr.issueid) t ON  i.issueid = t.issueid
WHERE i.estimatehours + i.estimateminutes > 0

ALTER TABLE gemini_issues DROP CONSTRAINT gemini_issues_percentcomplete_def
ALTER TABLE gemini_issues ALTER COLUMN percentcomplete INT NOT NULL 
ALTER TABLE gemini_issues ADD CONSTRAINT gemini_issues_percentcomplete_def DEFAULT(0) FOR percentcomplete
GO

/***********************************************************
* Components Ordering
***********************************************************/
ALTER TABLE gemini_components ADD componentorder INT NOT NULL CONSTRAINT gemini_components_componentorder_def  DEFAULT(0)
GO

/***********************************************************
* Planner role - add project and issue admins
***********************************************************/
INSERT INTO gemini_globalsecurityschemeroles(schemeid, schemerole, memberid, membertype)
SELECT schemeid, 37, memberid, membertype FROM gemini_globalsecurityschemeroles WHERE schemerole = 1
UNION 
SELECT schemeid, 37, memberid, membertype FROM gemini_globalsecurityschemeroles WHERE schemerole = 2
GO

/***********************************************************
* New Images
***********************************************************/
UPDATE gemini_issuetypes 
SET imagepath = REPLACE(imagepath,'.gif','.png')
WHERE imagepath IN (
'images/Type_Bug.gif',
'images/Type_Enhancement.gif',
'images/Type_NewFeature.gif',
'images/Type_Task.gif',
'images/Type_Investigation.gif',
'images/Type_Subtask.gif',
'images/Type_Requirement.gif',
'images/Type_QA.gif',
'images/Type_Support.gif',
'images/Type_ChangeRequest.gif') 

UPDATE gemini_issuetypes 
SET imagepath = REPLACE(imagepath,'.jpg','.png')
WHERE imagepath IN (
'images/Type_Bug.jpg',
'images/Type_Enhancement.jpg',
'images/Type_NewFeature.jpg',
'images/Type_Task.jpg',
'images/Type_Investigation.jpg',
'images/Type_Subtask.jpg',
'images/Type_Requirement.jpg',
'images/Type_QA.jpg',
'images/Type_Support.jpg',
'images/Type_ChangeRequest.jpg') 

UPDATE gemini_issuepriorities 
SET imagepath = REPLACE(imagepath,'.gif','.png')
WHERE imagepath IN (
'images/Priority_Low.gif',
'images/Priority_Medium.gif',
'images/Priority_High.gif')

UPDATE gemini_issueseverity 
SET imagepath = REPLACE(imagepath,'.gif','.png')
WHERE imagepath IN (
'images/Severity_Trivial.gif',
'images/Severity_Minor.gif',
'images/Severity_Major.gif',
'images/Severity_ShowStopper.gif')

UPDATE gemini_issuestatus
SET imagepath = REPLACE(imagepath,'.gif','.png')
WHERE imagepath IN (
'images/IssueStatus_Unassigned.gif',
'images/IssueStatus_assigned.gif',
'images/IssueStatus_InProgress.gif',
'images/IssueStatus_closed.gif',
'images/IssueStatus_Reopened.gif')
GO

/***********************************************************
* New Visibility Items (Votes, Comments etc...)
***********************************************************/
INSERT INTO gemini_fieldvisibilityschemeitems(fieldvisibilityschemeid, fieldid, iscustomfield, isrequired)
SELECT fieldvisibilityschemeid, 45, 0, 1  FROM gemini_fieldvisibilityschemes
UNION ALL
SELECT fieldvisibilityschemeid, 69, 0, 1  FROM gemini_fieldvisibilityschemes
UNION ALL
SELECT fieldvisibilityschemeid, 70, 0, 1  FROM gemini_fieldvisibilityschemes
UNION ALL
SELECT fieldvisibilityschemeid, 71, 0, 1  FROM gemini_fieldvisibilityschemes
UNION ALL
SELECT fieldvisibilityschemeid, 72, 0, 1  FROM gemini_fieldvisibilityschemes
UNION ALL
SELECT fieldvisibilityschemeid, 73, 0, 1  FROM gemini_fieldvisibilityschemes
GO

INSERT INTO gemini_fieldvisibilityschemeitemgroups(fieldvisibilityschemeitemid, memberid, membertype)
SELECT fieldvisibilityschemeitemid, 1, 2 FROM gemini_fieldvisibilityschemeitems WHERE fieldid IN (45, 69, 70, 71, 72, 73)
GO

