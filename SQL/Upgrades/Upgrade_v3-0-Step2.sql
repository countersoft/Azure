--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 3.0 UPGRADE SCRIPT
--
--*********************************************************************************
--*********************************************************************************


/*************************************************************************************************************
Security data migration
=======================
1. Create global security scheme per project 
(e.g. "Project GEM" security scheme)

2. Create group for each current security scheme 
(e.g. "Issue Worker" group, "Project Administration" group)

3. Map users to newly created group 
(e.g. user "Jon" belongs to "Issue Worker" group)

4. Attach each newly created group to role(s) within project specific global security scheme 
(e.g. "Issue Worker" group linked to "Create Issue" role, "Edit Issue" role)

5. Place anyone with "View Private Issue" role and put into re-defined "Private Issue Viewers" group

6. Work out project resources (assignable stuff!)

7. Process DEFAULT project scheme roles (everyone group)

NOTE:
  "Private Issue Viewers" group is not attached to any scheme AS they are attached to issues directly.
*************************************************************************************************************/
INSERT INTO gemini_globalgroups (globalgroupname,globalgroupdesc,globalgroupsystem)
	VALUES (N'Private Issue Viewers', N'Users who can view private issues (legacy)', 0)
go

-- Step 1: Create global security scheme per project
INSERT INTO gemini_globalsecurityschemes (schemename,schemedesc)
	SELECT LEFT(LTRIM(RTRIM(projectname)),500) AS schemename, 'Scheme created during 3.0 migration' AS schemedesc
	FROM gemini_projects
GO

-- Link global security scheme to it's project
UPDATE gemini_projects SET globalschemeid=gss.schemeid
FROM gemini_projects p, gemini_globalsecurityschemes gss
WHERE LEFT(LTRIM(RTRIM(p.projectname)),500) = gss.schemename
GO

-- Step 2: Create group for each current security scheme 
INSERT INTO gemini_globalgroups (globalgroupname,globalgroupdesc,globalgroupsystem)
	SELECT LEFT(LTRIM(RTRIM(schemename)),500) AS globalgroupname, 'Group created during 3.0 migration' AS globalgroupdesc, 0 AS globalgroupsystem
	FROM securityschemes
GO

-- Step 3: Map users to newly created group 
IF EXISTS(SELECT name FROM sysobjects WHERE name='Migration30_TempGroups1') DROP TABLE Migration30_TempGroups1

SELECT ur.userid, ur.projid as projectid, 
ISNULL(ss.roles,'') AS projectroles, ss.schemeid AS oldschemeid, LEFT(LTRIM(RTRIM(ss.schemename)),500) AS oldschemename,
ISNULL(pr.isactive,'N') AS isprojectresource,
ISNULL(gg.globalgroupname,'') AS globalgroupname,
/*ISNULL(*/gg.globalgroupid/*,-1)*/ AS globalgroupid,
ISNULL(gss.schemename, '') AS globalschemename,
ISNULL(gss.schemeid, -1) AS globalschemeid
INTO Migration30_TempGroups1
FROM userroles ur
LEFT OUTER JOIN securityschemes ss ON ur.schemeid=ss.schemeid
LEFT OUTER JOIN projectresource pr ON ur.userid=pr.userid and ur.projid=pr.projid
LEFT OUTER JOIN gemini_globalgroups gg ON LEFT(LTRIM(RTRIM(ss.schemename)),500)=gg.globalgroupname
LEFT OUTER JOIN gemini_projects p ON ur.projid=p.projectid
LEFT OUTER JOIN gemini_globalsecurityschemes gss ON LEFT(LTRIM(RTRIM(p.projectname)),500)=gss.schemename
WHERE ur.userid IN (SELECT userid FROM gemini_users)
GO

INSERT INTO gemini_globalgroupmembership (globalgroupid,userid) 
	SELECT globalgroupid, userid FROM Migration30_TempGroups1
GO

-- Step: 4. Attach each newly created group to role(s) within project specific global security scheme 
INSERT INTO gemini_globalsecurityschemeroles (schemeid,schemerole,memberid,membertype)
	SELECT MIN(globalschemeid) AS schemeid, 1 AS schemerole, MIN(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%P!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 2 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%I!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 3 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%C!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 4 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%E!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 5 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%D!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 7 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%L!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 8 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%W!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 13 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%A!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 15 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%8!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 16 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%9!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 17 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%U!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 18 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%1!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 19 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%3!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 20 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%4!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 21 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%5!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 22 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%M!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 27 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%2!%', projectroles) > 0 GROUP BY globalgroupid
	UNION ALL
	SELECT MIN(globalschemeid) AS schemeid, 29 AS schemerole, min(globalgroupid) AS memberid, 2 AS membertype
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%V!%', projectroles) > 0 GROUP BY globalgroupid
GO

-- Step: 5. Place anyone with "View Private Issue" role and put into re-defined "Private Issue Viewers" group
INSERT INTO gemini_globalgroupmembership (globalgroupid,userid) 
	SELECT (SELECT MAX(globalgroupid) FROM gemini_globalgroups) AS globalgroupid, userid
		FROM Migration30_TempGroups1 WHERE  PATINDEX('%H!%', projectroles) > 0
go

-- Step: 6. Work out project resources (assignable stuff!)
INSERT INTO gemini_globalsecurityschemeroles (schemeid,schemerole,memberid,membertype)
	SELECT globalschemeid AS schemeid, 14 AS schemerole, userid AS memberid, 1 AS membertype
		FROM Migration30_TempGroups1 WHERE isprojectresource='Y'
go

