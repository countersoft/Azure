--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT from Gemini 5.1.5 to Gemini 5.1.6
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.1.6')
GO

DROP INDEX gemini_globalconfigurationwidgetdata.uind_gemini_globalconfigurationwidgetdata_id
GO

CREATE INDEX ind_gemini_globalconfigurationwidgetdata_id ON gemini_globalconfigurationwidgetdata(appid)
GO

