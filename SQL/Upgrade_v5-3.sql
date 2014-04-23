--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 5.3.0
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.3.0')
GO

ALTER TABLE gemini_userissuesviews DROP CONSTRAINT gemini_userissuesviews_customfieldid_fk
GO
ALTER TABLE gemini_userissuesviews ALTER COLUMN customfieldid VARCHAR(100) 
GO
UPDATE gemini_userissuesviews SET customfieldid = 'cf_' + customfieldid WHERE customfieldid IS NOT NULL
GO
UPDATE gemini_navigationcard SET cardoptions = REPLACE(REPLACE(REPLACE(cardoptions, '"Key":','"Key":"'), ',"Value":"','|","Value":"'),'"CustomFields":','"CustomFieldsAcrossTemplates":') WHERE cardtype=1 AND cardoptions NOT LIKE '%CustomFields":\[\]%' ESCAPE '\'
GO
UPDATE gemini_plannerviews SET issuesfilter = REPLACE(REPLACE(REPLACE(issuesfilter, '"Key":','"Key":"'), ',"Value":"','|","Value":"'),'"CustomFields":','"CustomFieldsAcrossTemplates":') WHERE issuesfilter NOT LIKE '%CustomFields":\[\]%' ESCAPE '\'
GO
UPDATE gemini_navigationcard SET cardkey = ''
GO
UPDATE gemini_navigationcard SET cardkey = 'GEM' where cardtype = 0
UPDATE gemini_navigationcard SET cardkey = 'Grd' where cardtype = 1
UPDATE gemini_navigationcard SET cardkey = 'Pln' where cardtype = 2
UPDATE gemini_navigationcard SET cardkey = 'Rmp' where cardtype = 3
UPDATE gemini_navigationcard SET cardkey = 'Log' where cardtype = 4
UPDATE gemini_navigationcard SET cardkey = 'Brn' where cardtype = 5
UPDATE gemini_navigationcard SET cardkey = 'Tst' where cardtype = 6
UPDATE gemini_navigationcard SET cardkey = 'Rpt' where cardtype = 7
UPDATE gemini_navigationcard SET cardkey = 'Doc' where cardtype = 8
UPDATE gemini_navigationcard SET cardkey = 'Act' where cardtype = 9
UPDATE gemini_navigationcard SET cardkey = 'Task' where cardtype = 11
UPDATE gemini_navigationcard SET cardkey = 'Act' where cardtype = 12
UPDATE gemini_navigationcard SET cardkey = 'Act' where cardtype = 13
UPDATE gemini_navigationcard SET cardkey = 'Act' where cardtype = 14
UPDATE gemini_navigationcard SET cardkey = 'Act' where cardtype = 15
UPDATE gemini_navigationcard SET cardkey = 'Act' where cardtype = 16
UPDATE gemini_navigationcard SET cardkey = 'Me' where cardtype = 17
UPDATE gemini_navigationcard SET cardkey = 'See' where cardtype = 18
UPDATE gemini_navigationcard SET cardkey = 'Tml' where cardtype = 19
UPDATE gemini_navigationcard SET cardkey = 'Cal' where cardtype = 20
UPDATE gemini_navigationcard SET cardkey = 'All' where cardtype = 21
UPDATE gemini_navigationcard SET cardkey = 'Csft' where cardtype = 99
GO
ALTER TABLE breeze_matchexpression DROP CONSTRAINT breeze_matchexpression_name_def
GO
ALTER TABLE breeze_matchexpression ALTER COLUMN [name] NVARCHAR(100) NOT NULL 
GO
ALTER TABLE breeze_matchexpression ADD CONSTRAINT breeze_matchexpression_name_def DEFAULT('') FOR [name]
GO
