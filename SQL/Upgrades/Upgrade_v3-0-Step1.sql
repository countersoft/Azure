--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 3.0
--
-- DATA MIGRATION SCRIPT (STEP 1): Moves data from OLD tables to NEW tables
--
--*********************************************************************************
--*********************************************************************************

--*********************************************************************************
-- Application Settings
--*********************************************************************************
/*DELETE FROM gemini_applicationsettings
SET IDENTITY_INSERT gemini_applicationsettings ON
INSERT INTO gemini_applicationsettings (settingid, settingname, settingcategory, settingvalue, settingdesc)
	SELECT settingid, settingname, settingcategory, settingvalue, settingdesc FROM geminiappsettings
SET IDENTITY_INSERT gemini_applicationsettings OFF

INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('HelpDeskModeGroup','Security','0','Any users within selected group will only see Issues list')

UPDATE gemini_applicationsettings SET 
	settingvalue = 'US English|en-US|UK English|en-GB|German|de-DE|Spanish|es-ES|Italian|it-IT|French|fr-FR|Japanese|ja-JP|Portuguese|pt-PT|Chinese|zh-CHS|Russian|ru-RU|Greek|el-GR|Dutch|nl-NL|Polish|pl-PL|Brazilian Portuguese|pt-BR|Czech|cs-CZ|Slovak|sk-SK'
	where settingname = 'InstalledLanguages'

UPDATE gemini_applicationsettings SET 
	settingvalue = 'Default|Army|AVG|Blue|BlueMetal|BlueSteel|Leather'
	where settingname = 'InstalledThemes'*/

--*********************************************************************************
-- Error Log
--*********************************************************************************
/*DELETE FROM gemini_errorlog
SET IDENTITY_INSERT gemini_errorlog ON
INSERT INTO gemini_errorlog (srn, errormessage, stacktrace, otherinfo, created)
	SELECT srn, errormessage, stacktrace, otherinfo, created FROM errorlog
SET IDENTITY_INSERT gemini_errorlog OFF*/

--*********************************************************************************
-- Groups
--*********************************************************************************
DELETE FROM gemini_globalgroupmembership
DELETE FROM gemini_users
SET IDENTITY_INSERT gemini_users ON
IF NOT EXISTS(SELECT userid FROM users WHERE userid = -1)
	INSERT INTO gemini_users (userid,username,firstname,surname,pwd,emailaddress) VALUES (-1,N'anon',N'* Anonymous',N'User *',0x2AE66F90B7788AB8950E8F81B829C947,N'anon@anon.com')	
INSERT INTO gemini_users (userid, username, firstname, surname, pwd, emailaddress, roles, created, lastupdated, resetpwd, comment,active)
	SELECT userid, username, firstname, surname, pwd, emailaddress, roles, created, lastupdated, resetpwd, comment,active FROM users
		WHERE username NOT IN (SELECT username FROM users GROUP BY username having COUNT(*)>1)
SELECT 'users not imported because of duplicate user name',username FROM users GROUP BY username HAVING COUNT(*)>1
SET IDENTITY_INSERT gemini_users OFF

INSERT INTO gemini_globalgroupmembership (globalgroupid,userid) 
	SELECT 1 AS globalgroupid, userid FROM gemini_users
INSERT INTO gemini_globalgroupmembership (globalgroupid,userid) 
	SELECT 2 AS globalgroupid, userid FROM gemini_users WHERE roles = 'G!'
INSERT INTO gemini_globalgroupmembership (globalgroupid,userid) 
	SELECT 3 AS globalgroupid, userid FROM gemini_users where userid != -1

--*********************************************************************************
-- Issue Types
--*********************************************************************************
DELETE FROM gemini_issuetypeschemeitems
DELETE FROM gemini_issuetypeschemes
DELETE FROM gemini_issuetypes

SET IDENTITY_INSERT gemini_issuetypes ON
INSERT INTO gemini_issuetypes (typeid, seq, typedesc, imagepath)
	SELECT typeid, seq, typedesc, imagepath FROM issuetypelut
SET IDENTITY_INSERT gemini_issuetypes OFF

declare @seq numeric(10,0)
select @seq=max(seq) from gemini_issuetypes

INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+1,N'Bug',N'images/Type_Bug.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+2,N'Enhancement',N'images/Type_Enhancement.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+3,N'New Feature',N'images/Type_NewFeature.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+4,N'Task',N'images/Type_Task.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+5,N'Investigation',N'images/Type_Investigation.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+6,N'Sub-task',N'images/Type_Subtask.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+7,N'Requirement',N'images/Type_Requirement.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+8,N'Quality Check',N'images/Type_QA.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+9,N'Support Request',N'images/Type_Support.png')
INSERT INTO gemini_issuetypes (seq,typedesc,imagepath) VALUES (@seq+10,N'Change Request',N'images/Type_ChangeRequest.png')

SET IDENTITY_INSERT gemini_issuetypeschemes ON
INSERT INTO gemini_issuetypeschemes (issuetypeschemeid,schemename,schemedesc) VALUES (1,N'Software Development Projects',N'Scheme to be used by software development projects')
INSERT INTO gemini_issuetypeschemes (issuetypeschemeid,schemename,schemedesc) VALUES (2,N'Support Projects',N'Scheme to be used by support projects')
INSERT INTO gemini_issuetypeschemes (issuetypeschemeid,schemename,schemedesc) VALUES (3,N'Gemini 3.0 Migration Projects',N'Scheme created during 3.0 Gemini upgrade')
SET IDENTITY_INSERT gemini_issuetypeschemes OFF

INSERT INTO gemini_issuetypeschemeitems (issuetypeschemeid,typeid,seq) 
	select 3 as issuetypeschemeid, typeid, seq from gemini_issuetypes

INSERT INTO gemini_issuetypeschemeitems (issuetypeschemeid,typeid,seq) 
	select 2 as issuetypeschemeid, typeid, 1 as seq from gemini_issuetypes 
	where typedesc = 'Investigation'
INSERT INTO gemini_issuetypeschemeitems (issuetypeschemeid,typeid,seq) 
	select 2 as issuetypeschemeid, typeid, 2 as seq from gemini_issuetypes 
	where typedesc = 'Support Request'
INSERT INTO gemini_issuetypeschemeitems (issuetypeschemeid,typeid,seq) 
	select 2 as issuetypeschemeid, typeid, 3 as seq from gemini_issuetypes 
	where typedesc = 'Change Request'

--*********************************************************************************
-- Issue Priorities
--*********************************************************************************
DELETE FROM gemini_issuepriorityschemeitems
DELETE FROM gemini_issuepriorityschemes
DELETE FROM gemini_issuepriorities
SET IDENTITY_INSERT gemini_issuepriorities ON
INSERT INTO gemini_issuepriorities (priorityid, seq, prioritydesc, imagepath)
	SELECT priorityid, seq, prioritydesc, imagepath FROM issueprioritylut
SET IDENTITY_INSERT gemini_issuepriorities OFF

declare @seq1 numeric(10,0)
select @seq1=max(seq) from gemini_issuepriorities

INSERT INTO gemini_issuepriorities (seq,prioritydesc,imagepath) VALUES (@seq1+1,N'Low',N'images/Priority_Low.png')
INSERT INTO gemini_issuepriorities (seq,prioritydesc,imagepath) VALUES (@seq1+2,N'Medium',N'images/Priority_Medium.png')
INSERT INTO gemini_issuepriorities (seq,prioritydesc,imagepath) VALUES (@seq1+3,N'High',N'images/Priority_High.png')

SET IDENTITY_INSERT gemini_issuepriorityschemes ON
INSERT INTO gemini_issuepriorityschemes (issuepriorityschemeid,schemename,schemedesc) VALUES (1,N'Software Development Projects',N'Scheme to be used by software development projects')
SET IDENTITY_INSERT gemini_issuepriorityschemes OFF

INSERT INTO gemini_issuepriorityschemeitems (issuepriorityschemeid,priorityid,seq) 
	select 1 as issuepriorityschemeid, priorityid, seq from gemini_issuepriorities

--*********************************************************************************
-- Issue Severity
--*********************************************************************************
DELETE FROM gemini_issueseverityschemeitems
DELETE FROM gemini_issueseverityschemes
DELETE FROM gemini_issueseverity
SET IDENTITY_INSERT gemini_issueseverity ON
INSERT INTO gemini_issueseverity (severityid, seq, severitydesc, imagepath)
	SELECT priorityid, seq, prioritydesc, imagepath FROM issueprioritylut
SET IDENTITY_INSERT gemini_issueseverity OFF

declare @seq2 numeric(10,0)
select @seq2=max(seq) from gemini_issueseverity

INSERT INTO gemini_issueseverity (seq,severitydesc,imagepath) VALUES (@seq2+1,N'Trivial',N'images/Severity_Trivial.png')
INSERT INTO gemini_issueseverity (seq,severitydesc,imagepath) VALUES (@seq2+2,N'Minor',N'images/Severity_Minor.png')
INSERT INTO gemini_issueseverity (seq,severitydesc,imagepath) VALUES (@seq2+3,N'Major',N'images/Severity_Major.png')
INSERT INTO gemini_issueseverity (seq,severitydesc,imagepath) VALUES (@seq2+4,N'Show Stopper',N'images/Severity_ShowStopper.png')

SET IDENTITY_INSERT gemini_issueseverityschemes ON
INSERT INTO gemini_issueseverityschemes (issueseverityschemeid,schemename,schemedesc) VALUES (1,N'Software Development Projects',N'Scheme to be used by software development projects')
SET IDENTITY_INSERT gemini_issueseverityschemes OFF

INSERT INTO gemini_issueseverityschemeitems (issueseverityschemeid,severityid,seq) 
	select 1 as issueseverityschemeid, severityid, seq from gemini_issueseverity

--*********************************************************************************
-- Issue Workflow (Issue Status)
--*********************************************************************************
DELETE FROM gemini_issueworkflowitemgroup
DELETE FROM gemini_issueworkflowitemtransition
DELETE FROM gemini_issueworkflowitem

--*********************************************************************************
-- Issue Status
--*********************************************************************************
DELETE FROM gemini_issuestatus
SET IDENTITY_INSERT gemini_issuestatus ON
INSERT INTO gemini_issuestatus (statusid,isfinal,statusdesc,statustype,imagepath,comment)
	SELECT statusid, isfinal, statusdesc, statustype, N'images/IssueStatus_Unassigned.png' as imagepath, N'Migrated' as comment FROM issuestatuslut
SET IDENTITY_INSERT gemini_issuestatus OFF

SET IDENTITY_INSERT gemini_issueworkflowitem ON
INSERT INTO gemini_issueworkflowitem(issueworkflowitemid, issueworkflowid, issuestatusid, seq)
     SELECT statusid, 1, statusid, seq FROM issuestatuslut
SET IDENTITY_INSERT gemini_issueworkflowitem OFF

INSERT INTO gemini_issueworkflowitemgroup(issueworkflowitemid, issueworkflowid, memberid, membertype)
     SELECT issueworkflowitemid, 1, 1, 2 FROM gemini_issueworkflowitem

INSERT INTO gemini_issueworkflowitemtransition(issueworkflowitemid ,issueworkflowid, targetstatusid)
     SELECT DISTINCT statusid, 1, otherstate FROM issuestatetransitionlut WHERE otherstate!=statusid

--*********************************************************************************
-- Misc Issue Metadata
--*********************************************************************************
DELETE FROM gemini_issueresolutions
SET IDENTITY_INSERT gemini_issueresolutions ON
INSERT INTO gemini_issueresolutions (resolutionid, seq, isfinal, resdesc)
	SELECT resid, seq, isfinal, resdesc FROM issueresolutionlut
SET IDENTITY_INSERT gemini_issueresolutions OFF

DELETE FROM gemini_issuerisklevels
SET IDENTITY_INSERT gemini_issuerisklevels ON
INSERT INTO gemini_issuerisklevels (rowid, seq, risklevelid, riskdesc, imagepath)
	SELECT rowid, seq, riskid, riskdesc, imagepath FROM issuerisklevellut
SET IDENTITY_INSERT gemini_issuerisklevels OFF

--*********************************************************************************
-- Projects (projects, components, versions, attributes...)
--*********************************************************************************
DELETE FROM gemini_projects
SET IDENTITY_INSERT gemini_projects ON
INSERT INTO gemini_projects (projectid, projectcode, projectname, projectleader, projectdesc, projectreadonly, projectarchived, schemeid, resourcemode, componentmode, issuetypeschemeID, issuepriorityschemeID, issueseverityschemeid, issueworkflowID, fieldvisibilityschemeid, created)
	SELECT projid, projcode, projname, projleader, projdesc, projreadonly, projarchived, schemeid, resourcemode, componentmode, 3 as issuetypeschemeID, 1 as issuepriorityschemeID, 1 as issueseverityschemeid, 1 as issueworkflowID, 0 as fieldvisibilityschemeid, created FROM projects
SET IDENTITY_INSERT gemini_projects OFF
-- project.globalschemeid set by "Upgrade_v3_0-Step1.sql"

/*DELETE FROM gemini_projectresources
SET IDENTITY_INSERT gemini_projectresources ON
INSERT INTO gemini_projectresources (rowid, projectid, userid, isactive, created)
	SELECT rowid, projid, userid, isactive, created FROM projectresource 
		WHERE projid IN (SELECT projectid FROM gemini_projects)
		AND userid IN (SELECT userid FROM gemini_users)
SET IDENTITY_INSERT gemini_projectresources OFF*/

DELETE FROM gemini_versions
SET IDENTITY_INSERT gemini_versions ON
INSERT INTO gemini_versions (versionid, projectid, versionnumber, versionname, versiondesc, versionreleased, versionorder, versionarchived, created)
	SELECT verid, projid, vernumber, vername, verdesc, verreleased, verorder, verarchived, created FROM versions
SET IDENTITY_INSERT gemini_versions OFF

DELETE FROM gemini_components
SET IDENTITY_INSERT gemini_components ON
INSERT INTO gemini_components (componentid, projectid, componentname, componentdesc, componentreadonly, created)
	SELECT compid, projid, compname, compdesc, compreadonly, created FROM components
SET IDENTITY_INSERT gemini_components OFF

/*DELETE FROM gemini_projectrepository
SET IDENTITY_INSERT gemini_projectrepository ON
INSERT INTO gemini_projectrepository (nodeid, parentnodeid, projectid, nodetext, navigateurl, tooltip, imageindex, ispostback, isfolder, sendparams, nodedata, contenttype)
	SELECT nodeid, parentnodeid, projid, nodetext, navigateurl, tooltip, imageindex, ispostback, isfolder, sendparams, nodedata, contenttype FROM projectrepository
		WHERE projid IN (SELECT projectid FROM gemini_projects)
SET IDENTITY_INSERT gemini_projectrepository OFF*/
--*********************************************************************************
-- Project Documents
--*********************************************************************************
SET IDENTITY_INSERT gemini_projectdocuments ON
INSERT INTO gemini_projectdocuments (documentid, parentdocumentid, projectid, documentname, documentdesc, isfolder, contenttype, documentdata, created, contentlength)
	SELECT nodeid, parentnodeid, projid, nodetext, tooltip, isfolder, contenttype, nodedata, GETDATE(), ISNULL(DATALENGTH(nodedata),0) FROM projectrepository
		WHERE projid IN (SELECT projectid FROM gemini_projects)

SET IDENTITY_INSERT gemini_projectdocuments OFF



DELETE FROM gemini_projectattributes
SET IDENTITY_INSERT gemini_projectattributes ON
INSERT INTO gemini_projectattributes (attributeid, projectid, attributename, attributevalue, attributeorder)
	SELECT attributeid, projid, attributename, attributevalue, attributeorder FROM projectattributes
SET IDENTITY_INSERT gemini_projectattributes OFF

DELETE FROM gemini_projectversionattributes
SET IDENTITY_INSERT gemini_projectversionattributes ON
INSERT INTO gemini_projectversionattributes (attributeid, projectid, attributename, attributeorder, defaultvalue)
	SELECT attributeid, projid, attributename, attributeorder, defaultvalue FROM projectversionattributes
		WHERE projid IN (SELECT projectid FROM gemini_projects)	
SET IDENTITY_INSERT gemini_projectversionattributes OFF

DELETE FROM gemini_projectversionattributevalues
SET IDENTITY_INSERT gemini_projectversionattributevalues ON
INSERT INTO gemini_projectversionattributevalues (attributevalueid, attributeid, projectid, versionid, attributevalue)
	SELECT attributevalueid, attributeid, projid, verid, attributevalue FROM projectversionattributevalues
SET IDENTITY_INSERT gemini_projectversionattributevalues OFF

--*********************************************************************************
-- Issues (add associated issue level data)
--*********************************************************************************
DELETE FROM gemini_issues
SET IDENTITY_INSERT gemini_issues ON
INSERT INTO gemini_issues (issueid, projectid, fixedinversionid, reportedby, summary, longdesc, issuetypeid, issuepriorityid, issueseverityid, issuestatusid, issueresolutionid, issuerisklevelid, userdata1, userdata2, userdata3, percentcomplete, estimatedays, estimatehours, estimateminutes, startdate, duedate, isprivate, created, revised, resolveddate, closeddate)
	SELECT issueid, projid, (CASE fixedinverid WHEN 0 THEN NULL ELSE fixedinverid end) as fixedinversionid, ISNULL(userid,-1) as reportedby, summary, longdesc, isstype, isspriority, isspriority as issueseverityid, issstatus, issresolution, risklevel, userdata1, userdata2, userdata3, percentcomplete, estimatedays, estimatehours, estimateminutes, startdate, duedate, isprivate, issues.created, revised, resolveddate, closeddate FROM issues LEFT JOIN gemini_users ON reportedby = userid 
		WHERE projid IN (SELECT projects.projid FROM projects)
		AND risklevel IN (SELECT risklevelid FROM gemini_issuerisklevels)
		AND issresolution IN (SELECT resolutionid FROM gemini_issueresolutions)
SELECT  'Issue not imported because Project ID is invalid',issueid FROM issues WHERE projid NOT IN (SELECT projects.projid FROM projects) UNION ALL
SELECT  'Issue not imported because Risk Level ID is invalid',issueid FROM issues WHERE risklevel NOT IN (SELECT risklevelid FROM gemini_issuerisklevels) UNION ALL
SELECT  'Issue not imported because Resolution ID is invalid',issueid FROM issues WHERE issresolution NOT IN (SELECT resolutionid FROM gemini_issueresolutions)
SET IDENTITY_INSERT gemini_issues OFF
-- gemini_issues.visibility set by "Upgrade_v3_0-Step1.sql"

DELETE FROM gemini_issuecomments
SET IDENTITY_INSERT gemini_issuecomments ON
INSERT INTO gemini_issuecomments (commentid, userid, issueid, projectid, comment, username, isprivate, isclosing, created)
	SELECT commentid, CASE WHEN u.userid IS NULL THEN -1 ELSE ic.userid end, issueid, projid, ic.comment, ic.username, isprivate, isclosing, ic.created FROM issuecomments ic LEFT JOIN gemini_users u ON ic.userid = u.userid
		WHERE issueid IN (SELECT issueid FROM gemini_issues) and projid in (select projectid from gemini_projects)
SET IDENTITY_INSERT gemini_issuecomments OFF
-- gemini_issuecomments.visibility set by "Upgrade_v3_0-Step1.sql"

DELETE FROM gemini_issuehistory
SET IDENTITY_INSERT gemini_issuehistory ON
INSERT INTO gemini_issuehistory (historyid, issueid, projectid, history, username, created, visibility, visibilitymembertype)
	SELECT historyid, issueid, projid, history, username, created, 1 as visibility, 2 AS membertype FROM issuehistory 
		WHERE issueid IN (SELECT issueid FROM gemini_issues) and projid in (select projectid from gemini_projects)
SET IDENTITY_INSERT gemini_issuehistory OFF

DELETE FROM gemini_issueattachments
SET IDENTITY_INSERT gemini_issueattachments ON
INSERT INTO gemini_issueattachments (fileid, projectid, issueid, commentid, contenttype, contentlength, thefilename, filecontent, created)
	SELECT fileid, projid, issueid, CASE WHEN commentid = 0 THEN NULL ELSE commentid END, contenttype, contentlength, thefilename, filecontent, created FROM issueattachments
		WHERE issueid IN (SELECT issueid FROM gemini_issues) and projid in (select projectid from gemini_projects)
		AND ( commentid IN (SELECT commentid FROM gemini_issuecomments) OR commentid = 0)
SET IDENTITY_INSERT gemini_issueattachments OFF

DELETE FROM gemini_issuevotes
SET IDENTITY_INSERT gemini_issuevotes ON
INSERT INTO gemini_issuevotes (voteid, issueid, userid, created)
	SELECT voteid, issueid, userid, created FROM issuevotes
		WHERE issueid IN (SELECT issueid FROM gemini_issues)
SET IDENTITY_INSERT gemini_issuevotes OFF

DELETE FROM gemini_affectedversions
SET IDENTITY_INSERT gemini_affectedversions ON
INSERT INTO gemini_affectedversions (affectedversionid, issueid, versionid, created)
	SELECT affectedversionid, issueid, versionid, created FROM affectedversion
		WHERE issueid IN (SELECT issueid FROM gemini_issues)
SET IDENTITY_INSERT gemini_affectedversions OFF

DELETE FROM gemini_issueresources
SET IDENTITY_INSERT gemini_issueresources ON
INSERT INTO gemini_issueresources (issueresourceid, issueid, userid, created)
	SELECT issueresourceid, issueid, userid, created FROM issueresource
		WHERE issueid IN (SELECT issueid FROM gemini_issues)
		AND userid IN (SELECT userid FROM gemini_users)
SET IDENTITY_INSERT gemini_issueresources OFF

DELETE FROM gemini_issuecomponents
SET IDENTITY_INSERT gemini_issuecomponents ON
INSERT INTO gemini_issuecomponents (issuecomponentid, issueid, componentid, created)
	SELECT issuecomponentid, issueid, componentid, created FROM issuecomponent
		WHERE issueid IN (SELECT issueid FROM gemini_issues)
SET IDENTITY_INSERT gemini_issuecomponents OFF

--*********************************************************************************
-- Watchers
--*********************************************************************************
DELETE FROM gemini_watchissues
SET IDENTITY_INSERT gemini_watchissues ON
INSERT INTO gemini_watchissues (watchid, projectid, issueid, userid, created)
	SELECT wi.watchid, wi.projid, wi.issueid, wi.userid, wi.created FROM watchissue wi
		JOIN gemini_issues i ON wi.issueid = i.issueid AND wi.projid = i.projectid
		WHERE wi.userid IN (SELECT userid FROM gemini_users)
SET IDENTITY_INSERT gemini_watchissues OFF

DELETE FROM gemini_watchproject
SET IDENTITY_INSERT gemini_watchproject ON
INSERT INTO gemini_watchproject (watchid, projectid, userid, watchcode, created)
	SELECT watchid, projid, userid, watchcode, created FROM watchproject
		WHERE projid IN (SELECT projectid FROM gemini_projects)
		AND userid IN (SELECT userid FROM gemini_users)
SET IDENTITY_INSERT gemini_watchproject OFF

--*********************************************************************************
-- Issue Links
--*********************************************************************************
DELETE FROM gemini_issuelinktypes
SET IDENTITY_INSERT gemini_issuelinktypes ON
INSERT INTO gemini_issuelinktypes (linktypeid, linkname, linkdesc, created)
	SELECT linktypeid, linkname, linkdesc, created FROM issuelinktypes
SET IDENTITY_INSERT gemini_issuelinktypes OFF

DELETE FROM gemini_issuelinks
SET IDENTITY_INSERT gemini_issuelinks ON
INSERT INTO gemini_issuelinks (issuelinkid, linktypeid, issueid, otherissueid, linkdirection, created)
	SELECT issuelinkid, linktypeid, issueid, otherissueid, linkdirection, created FROM issuelinks
		WHERE issueid IN (SELECT issueid FROM gemini_issues) AND otherissueid IN (SELECT issueid FROM gemini_issues) 
SET IDENTITY_INSERT gemini_issuelinks OFF

--*********************************************************************************
-- Issue Custom Fields
--*********************************************************************************
DELETE FROM gemini_customfielddefinitions
SET IDENTITY_INSERT gemini_customfielddefinitions ON
INSERT INTO gemini_customfielddefinitions (customfieldid, customfieldname, isactive, screenorder, screenlabel, screendescription, screentooltip, maxlen, numcols, numrows, cancreate, canedit, canview, canmultiselect, requiredfield, regularexp, customfieldtype, defaultvalue, lookupname, lookupvaluefield, lookuptextfield, lookupsortfield, created)
	SELECT customfieldid, customfieldname+' ('+projectcode+')', isactive, screenorder, screenlabel, screendescription, screentooltip, maxlen, numcols, numrows, cancreate, canedit, canview, canmultiselect, requiredfield, regularexp, customfieldtype, defaultvalue, lookupname, lookupvaluefield, lookuptextfield, lookupsortfield, customfielddefs.created 
		FROM customfielddefs 
		JOIN gemini_projects ON projid=projectid
SET IDENTITY_INSERT gemini_customfielddefinitions OFF

DELETE FROM gemini_customfieldusage
INSERT INTO gemini_customfieldusage (customfieldid, projectid)
	SELECT customfieldid, projid FROM customfielddefs WHERE projid IN (SELECT projectid FROM gemini_projects)

DELETE FROM gemini_customfielddata
SET IDENTITY_INSERT gemini_customfielddata ON
INSERT INTO gemini_customfielddata (customfielddataid, customfieldid, userid, projectid, issueid, fielddata, created)
	SELECT customfielddataid, customfieldid, CASE WHEN u.userid IS NULL THEN -1 ELSE cfd.userid END, projid, issueid, fielddata, cfd.created FROM customfielddata cfd LEFT JOIN gemini_users u ON cfd.userid = u.userid
		WHERE issueid IN (SELECT issueid FROM gemini_issues) AND customfieldid IN (select customfieldid FROM gemini_customfielddefinitions)
SET IDENTITY_INSERT gemini_customfielddata OFF

--*********************************************************************************
-- Issue Filters
--*********************************************************************************
DELETE FROM gemini_personalfilters
SET IDENTITY_INSERT gemini_personalfilters ON
INSERT INTO gemini_personalfilters (filterid, filtername, userid, projectid, projectids, components, versions, affectedversions, resources, issuetypes, issuepriorities, issuestatuses, issueresolutions, risklevels, keywords, excludeclosed, systemfilter, issueids, sortfield, sortdirection, createdafter, createdbefore, revisedafter, revisedbefore, created)
	SELECT filterid, filtername, userid, projid, projids, components, versions, affectedversions, resources, issuetype, issuepriority, issuestatus, issueresolution, risklevel, keywords, excludeclosed, systemfilter, issueid, sortfield, sortdirection, createdafter, createdbefore, revisedafter, revisedbefore, created FROM personalfilters
		WHERE userid IN (SELECT userid FROM gemini_users)
		AND projid IN (SELECT projectid FROM gemini_projects)
SET IDENTITY_INSERT gemini_personalfilters OFF

--*********************************************************************************
-- Issue Source Control Files
--*********************************************************************************
DELETE FROM gemini_sourcecontrolissuefiles
SET IDENTITY_INSERT gemini_sourcecontrolissuefiles ON
INSERT INTO gemini_sourcecontrolissuefiles (fileid, issueid, [filename], filepath, sourcecontrolrepository)
	SELECT fileid, issueid, [filename], filepath, sourcecontrolrepository FROM sourcecontrolissuefiles
		WHERE issueid IN (SELECT issueid FROM gemini_issues)
SET IDENTITY_INSERT gemini_sourcecontrolissuefiles OFF

--*********************************************************************************
-- Issue Time Tracking
--*********************************************************************************
DELETE FROM gemini_timetracking
SET IDENTITY_INSERT gemini_timetracking ON
INSERT INTO gemini_timetracking (entryid, projectid, issueid, userid, hours, minutes, comment, timeentrydate, created)
	SELECT entryid, projid, issueid, CASE WHEN u.userid IS NULL THEN -1 ELSE t.userid END, hours, minutes, t.comment, timeentrydate, t.created FROM timetracking t LEFT JOIN gemini_users u ON  t.userid = u.userid
		WHERE issueid IN (SELECT issueid FROM gemini_issues)
SET IDENTITY_INSERT gemini_timetracking OFF

--*********************************************************************************
-- User Views
--*********************************************************************************
DELETE FROM gemini_usersettings
INSERT INTO gemini_usersettings (userid, sname, svalue, created)
	SELECT userid, sname, svalue, created FROM usersettings
	
DELETE FROM gemini_userissuesviews
SET IDENTITY_INSERT gemini_userissuesviews ON
INSERT INTO gemini_userissuesviews (itemid, userid, projectid, issueattribute, customfieldid, displayorder)
	SELECT itemid, userid, CASE projectid WHEN -2 THEN NULL ELSE projectid end, issueattribute, CASE customfieldid WHEN 0 THEN NULL ELSE customfieldid END, displayorder FROM userissuesview
		WHERE projectid IN (SELECT projectid FROM gemini_projects) OR projectid = -2
SET IDENTITY_INSERT gemini_userissuesviews OFF

--*********************************************************************************
-- User Settings
--*********************************************************************************
truncate table gemini_usersettings

--*********************************************************************************
-- Default Issue visibility
--*********************************************************************************
UPDATE gemini_issues SET visibility=1,visibilitymembertype=2 WHERE isprivate<>1
UPDATE gemini_issues SET visibility=(SELECT MAX(globalgroupid) FROM gemini_globalgroups),visibilitymembertype=2 WHERE isprivate=1
UPDATE gemini_issuecomments SET visibility=(SELECT MAX(globalgroupid) FROM gemini_globalgroups),visibilitymembertype=2 WHERE isprivate=1

--*********************************************************************************
-- Default Project Workflow
--*********************************************************************************
UPDATE gemini_projects SET issueworkflowid=1

