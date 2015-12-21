--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.7.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.7.0')
GO

CREATE TABLE gemini_reportpermission
(
	reportid INT IDENTITY(1,1) CONSTRAINT gemini_reportpermission_reportid_pk PRIMARY KEY,
	reportname NVARCHAR(100) NOT NULL,
	reportfilename NVARCHAR(500) NOT NULL,
	groups NVARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_reportpermission_created_def DEFAULT GETUTCDATE()
)
GO
ALTER TABLE gemini_rulesactions ADD isenabled BIT NOT NULL CONSTRAINT gemini_rulesactions_isenabled_def DEFAULT 1
GO
