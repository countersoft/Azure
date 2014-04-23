--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 5.4.3
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.4.3')
GO

ALTER TABLE gemini_customfielddefinitions ADD allownoselection BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_allownoselection_def DEFAULT(0)
ALTER TABLE gemini_customfielddefinitions ADD autocomplete BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_autocomplete_def DEFAULT(0)
GO

ALTER TABLE gemini_issuecomments ADD commenttype INT NOT NULL CONSTRAINT gemini_issuecomments_commenttype_def DEFAULT(0)
GO

IF EXISTS(SELECT * FROM gemini_projecttemplate WHERE templateid=19)
BEGIN
	INSERT INTO [gemini_customfielddefinitions] ([customfieldname], [screenorder], [screenlabel], [screendescription], [screentooltip], [maxlen], [canmultiselect], [regularexp], [customfieldtype], [lookupname], [lookupvaluefield], [lookuptextfield], [lookupsortfield], [projectidfilter], [created], [showinline], [lookupdata], [maxvalue], [minvalue], [listlimiter], [usedin], [templateid], [usestaticdata], [canfilter], [cascadinglookupvaluefield], [cascadingparentfield], [allownoselection], [autocomplete]) VALUES (N'Run Status', 0, N'Run Status', N'', N'Run Status', 0, 0, N'', N'R', N'', N'', N'', N'', 0, '2013-09-12T11:05:01.670', 1, N'', NULL, NULL, N'', 0, 19, 0, 0, N'', 0, 0, 0)

	INSERT INTO gemini_customfielddata(customfieldid, issueid, projectid, fielddata, userid)
	SELECT customfieldid, testplanid, projectid, '<table cellspacing=''0'' cellpadding=''0'' style=''height:20px;font-size:14px;border-style: none; border-width: 0pt; padding: 2px 0 0 0;text-align:center;''><tbody><tr style=''border-style: none; border-width: 0pt;''><td title=''Pending'' style=''padding:0px;border-bottom:0px;border-left:0px;font-size:14px; background-color: DarkGray !important; color: White; width: 33px; height: 10px;''>' + CAST(SUM(CASE WHEN haspassed IS NULL THEN 1 ELSE 0 END) AS VARCHAR) + '</td><td title=''Passed'' style=''padding:0px;border-bottom:0px;border-left:0px;font-size:14px; background-color: DarkGreen !important; color: White; width: 33px; height: 10px;''>' + CAST(SUM(CASE WHEN haspassed = 1 THEN 1 ELSE 0 END) AS VARCHAR) + '</td><td title=''Failed'' style=''padding:0px;border-bottom:0px;border-left:0px;font-size:14px; background-color: DarkRed !important; color: White; width: 33px; height: 10px;''>' + CAST(SUM(CASE WHEN haspassed = 0 THEN 1 ELSE 0 END) AS VARCHAR) + '</td></tr><tbody></table>', createdby
	FROM gemini_testing_runs, gemini_customfielddefinitions WHERE customfieldname='Run Status' AND templateid = 19 AND testplanid IN (SELECT issueid FROM gemini_issues) GROUP BY testplanid, customfieldid, projectid, createdby

	INSERT INTO gemini_customfielddata(customfieldid, issueid, projectid, fielddata, userid)
	SELECT customfieldid, a.testcaseid, projectid,  '<table cellspacing=''0'' cellpadding=''0'' style=''height:20px;font-size:14px;border-style: none; border-width: 0pt; padding: 2px 0 0 0;text-align:center;''><tbody><tr style=''border-style: none; border-width: 0pt;''><td title=''Pending'' style=''padding:0px;border-bottom:0px;border-left:0px;font-size:14px; background-color: DarkGray !important; color: White; width: 33px; height: 10px;''>' + CAST(SUM(CASE WHEN a.haspassed = -1 AND b.haspassed IS NULL THEN 1 ELSE 0 END) AS VARCHAR) + '</td><td title=''Passed'' style=''padding:0px;border-bottom:0px;border-left:0px;font-size:14px; background-color: DarkGreen !important; color: White; width: 33px; height: 10px;''>' + CAST(SUM(CASE WHEN a.haspassed = 1 THEN 1 ELSE 0 END) AS VARCHAR) + '</td><td title=''Failed'' style=''padding:0px;border-bottom:0px;border-left:0px;font-size:14px; background-color: DarkRed !important; color: White; width: 33px; height: 10px;''>' + CAST(SUM(CASE WHEN a.haspassed IN (0,-1) THEN 1 ELSE 0 END) AS VARCHAR) + '</td></tr><tbody></table>', createdby
	FROM 
		(SELECT z.testcaseid, z.testrunid, MIN(ISNULL(CAST(z.haspassed AS INT), -1)) AS haspassed FROM gemini_testing_run_steps z GROUP BY z.testcaseid, z.testrunid) a
			JOIN gemini_testing_runs b ON a.testrunid = b.testrunid
			, gemini_customfielddefinitions WHERE customfieldname='Run Status' AND templateid = 19  AND a.testcaseid IN (SELECT issueid FROM gemini_issues) 
		GROUP BY customfieldid, a.testcaseid, projectid, createdby
END
GO
