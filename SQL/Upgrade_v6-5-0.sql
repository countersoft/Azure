--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.5.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.5.0')
GO
ALTER TABLE gemini_issuecomments ALTER COLUMN originatordata NVARCHAR(MAX)
GO
ALTER TABLE gemini_sla ADD timezoneid VARCHAR(100)
GO
