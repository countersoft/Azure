--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT from Gemini 5.1.3 to Gemini 5.1.5
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.1.5')
GO

ALTER TABLE breeze_mailbox ADD domain NVARCHAR(255) NULL 
GO
ALTER TABLE breeze_mailbox ADD exchangeversion INT NULL 
GO

ALTER TABLE gemini_customfielddefinitions ADD cascadinglookupvaluefield NVARCHAR(100) NULL
GO

ALTER TABLE gemini_customfielddefinitions ADD cascadingparentfield int null
GO

CREATE TABLE gemini_timerapps
(
	id INT IDENTITY(1,1) CONSTRAINT gemini_timerapps_id_pk PRIMARY KEY,
	appid VARCHAR(50) NOT NULL,
	nodeid VARCHAR(50) NOT NULL,
	runstatus INT NOT NULL,
	lastruntime DATETIME NULL,
	nextruntime DATETIME NULL,
	lasterrormessage NVARCHAR(MAX) NOT NULL,
	lastdebugmessage NVARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_timerapps_created_def DEFAULT GETUTCDATE()
)
GO

CREATE UNIQUE INDEX ind_gemini_timerapps_appid ON gemini_timerapps(appid)
GO

ALTER TABLE gemini_systemlog ALTER COLUMN messagesource VARCHAR(100) NOT NULL
GO
