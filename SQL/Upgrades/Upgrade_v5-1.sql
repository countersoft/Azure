--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT from Gemini 5.0 to Gemini 5.1
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.1.0')
GO

ALTER TABLE gemini_projectdefaultvalues DROP CONSTRAINT gemini_projectdefaultvalues_typeid_fk
GO

/**********************************************************************************************************************
* New Tables
**********************************************************************************************************************/
CREATE TABLE gemini_globalconfigurationwidgetdata
(
	id INT IDENTITY(1,1) CONSTRAINT gemini_globalconfigurationwidgetdata_watchid_pk PRIMARY KEY NONCLUSTERED,
	appid VARCHAR(38) NOT NULL,
	value NVARCHAR(MAX) not null,
	created DATETIME NOT NULL CONSTRAINT gemini_globalconfigurationwidgetdata_created_def DEFAULT GETUTCDATE()
)
CREATE UNIQUE INDEX uind_gemini_globalconfigurationwidgetdata_id ON gemini_globalconfigurationwidgetdata(appid)
GO

