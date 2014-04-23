--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 5.4.4
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.4.4')
GO

ALTER TABLE gemini_issues ADD creator NUMERIC(10,0) CONSTRAINT gemini_issues_creator_fk FOREIGN KEY REFERENCES gemini_users(userid)
GO
UPDATE gemini_issues SET creator = reportedby
GO
ALTER TABLE gemini_issues ALTER COLUMN creator NUMERIC(10,0) NOT NULL
GO
