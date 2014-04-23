--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 6.1.0
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.1.0')
GO

ALTER TABLE breeze_mailbox ADD whitelist NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_whitelist_def  DEFAULT ('')
GO

CREATE TABLE gemini_apppermissions
(
	id int IDENTITY(1,1) NOT NULL CONSTRAINT gemini_apppermissions_id_pk PRIMARY KEY,
	appguid NVARCHAR(100) NOT NULL,
	apppermissions NVARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_apppermissions_created_def DEFAULT GETUTCDATE()
)
GO
CREATE INDEX gemini_apppermissions_appguid ON gemini_apppermissions(appguid)
GO

SELECT * INTO bkup_gemini_navigationcard FROM gemini_navigationcard
GO

--Planner
UPDATE gemini_navigationcard SET cardoptions = '{"Planner":"' + cardoptions + '"}' WHERE cardtype=2
--Items
UPDATE gemini_navigationcard SET cardoptions = '{"Items":"' + REPLACE(cardoptions,'"','\"') + '"}' WHERE cardtype=1
--progress/burndown
UPDATE gemini_navigationcard SET cardoptions = '{"Burndown":"' + REPLACE(cardoptions,'"','\"') + '"}' WHERE cardtype=5
--Calendar
UPDATE gemini_navigationcard SET cardoptions = '{"Calendar":"' + REPLACE(cardoptions,'"','\"') + '"}' WHERE cardtype=20
--Timeline
UPDATE gemini_navigationcard SET cardoptions = '{"Timeline":"' + cardoptions +'"}'  WHERE cardtype=19
--Cardtype = 0 (custom)
UPDATE gemini_navigationcard SET cardoptions = '{"1B9CB627-A2F2-4CC5-BE5B-D0FABB489F87":"' + REPLACE(cardoptions,'"','\"') + '"}' WHERE cardtype=0
GO

-- DocStore Permissions --
DECLARE @result1 TABLE (projects NVARCHAR(MAX), viewGroups NVARCHAR(MAX), manageGroups NVARCHAR(MAX))

INSERT INTO @result1
SELECT 
SUBSTRING(value, 14, CHARINDEX(']',value,14) - 14) as projects,
SUBSTRING(value,CHARINDEX('CanViewDocumentGroups":[',value,1)+LEN('CanViewDocumentGroups":['),CHARINDEX('],"CanManageDocument',value,1) - (CHARINDEX('CanViewDocumentGroups":[',value,1)  + LEN('CanViewDocumentGroups":['))) as viewGroups,
SUBSTRING(value,(CHARINDEX('CanManageDocumentGroups":[',value,1)+LEN('CanManageDocumentGroups":[')),CHARINDEX(']}',value,CHARINDEX('CanManageDocumentGroups":[',value,1)) - (CHARINDEX('CanManageDocumentGroups":[',value,1) + LEN('CanManageDocumentGroups":['))) as manageGroups
FROM gemini_globalconfigurationwidgetdata  
WHERE appid = '1B9CB627-A2F2-4CC5-BE5B-D0FABB489F87'

IF EXISTS(SELECT * FROM @result1)
BEGIN
	INSERT INTO gemini_apppermissions (appguid, apppermissions) VALUES ('1B9CB627-A2F2-4CC5-BE5B-D0FABB489F87','{"Projects":[' + (SELECT TOP 1 projects FROM @result1) + '],"ViewGroups":['+ (SELECT TOP 1 viewGroups FROM @result1) +'],"CreateGroups":[],"EditGroups":[' + (SELECT TOP 1 manageGroups FROM @result1) +'],"DeleteGroups":[]}');
END

DELETE FROM gemini_globalconfigurationwidgetdata WHERE appid = '1B9CB627-A2F2-4CC5-BE5B-D0FABB489F87'
GO

CREATE INDEX ind_breeze_enquiry_rawid ON breeze_enquiry (rawid)
GO

UPDATE gemini_users SET languageid='', culture='' WHERE userid=-1
GO

ALTER TABLE breeze_enquiry ALTER COLUMN [issuekey] [nvarchar] (100) 
GO
