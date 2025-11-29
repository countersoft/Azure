--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.8.4

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.8.4')
GO

ALTER TABLE gemini_issues 
	ADD organizationid INT NULL CONSTRAINT gemini_issues_organizationid_fk FOREIGN KEY REFERENCES gemini_organization( organizationid )
GO

ALTER TABLE gemini_users
	ADD defaultorganizationid INT NULL CONSTRAINT gemini_users_organizationid_fk FOREIGN KEY REFERENCES gemini_organization( organizationid )
GO

UPDATE gemini_issues set organizationid = (select top 1 organizationid from gemini_organizationmembership m where m.userid = gemini_issues.reportedby order by m.id asc)
GO
