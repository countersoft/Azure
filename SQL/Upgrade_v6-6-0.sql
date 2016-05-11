--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.6.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.6.0')
GO
ALTER TABLE gemini_watchissues ADD email NVARCHAR(255)
GO
ALTER TABLE gemini_watchissues ALTER COLUMN userid NUMERIC(10,0) NULL
GO
DROP INDEX gemini_watchissues.uind_gemini_watchissues_id
GO
CREATE UNIQUE NONCLUSTERED INDEX uind_gemini_watchissues_id ON gemini_watchissues (issueid, userid, email)
GO

CREATE TABLE breeze_cannedresponse
(
	cannedresponseid INT IDENTITY(1,1) CONSTRAINT breeze_cannedresponse_cannedresponseid_pk PRIMARY KEY,
	name NVARCHAR(100) NOT NULL,
	response NVARCHAR(MAX) NOT NULL,
	projects NVARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT breeze_cannedresponse_created_def DEFAULT GETUTCDATE()
)
GO
