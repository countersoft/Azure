--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 5.4.2
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.4.2')
GO

UPDATE gemini_navigationcard SET cardoptions = REPLACE(REPLACE(REPLACE(cardoptions,'First','VersionId'),'Second', 'Days'),'Third','ItemHour') WHERE cardtype=5
UPDATE gemini_navigationcard SET cardoptions = REPLACE(REPLACE(cardoptions,'"items"','0'), '"hours"','1') WHERE cardtype=5
GO

UPDATE gemini_projecttemplate SET templatekey = 'TESTING' WHERE templatekey  = 'SENTRY'
GO
