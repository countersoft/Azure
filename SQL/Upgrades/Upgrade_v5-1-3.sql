--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT from Gemini 5.1.2 to Gemini 5.1.3
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.1.3')
GO

CREATE TABLE gemini_codecommits
(
	commitid INT IDENTITY(1,1) CONSTRAINT gemini_codecommits_commitid_pk PRIMARY KEY,
	issueid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_codecommits_issueid_fk FOREIGN KEY REFERENCES gemini_issues(issueid),
	provider INT NOT NULL,
	comment NVARCHAR(MAX) NOT NULL,
	data NVARCHAR(MAX) NOT NULL,
	fullname NVARCHAR(100) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_codecommits_created_def DEFAULT GETUTCDATE(),
	tstamp TIMESTAMP NOT NULL
)
GO

CREATE INDEX ind_gemini_codecommits_issueid ON gemini_codecommits(issueid)
GO

ALTER TABLE gemini_globalconfigurationwidgetdata ADD projectid NUMERIC(10,0) NULL CONSTRAINT gemini_globalconfigurationwidgetdata_projectid_fk FOREIGN KEY REFERENCES gemini_projects(projectid)
GO

