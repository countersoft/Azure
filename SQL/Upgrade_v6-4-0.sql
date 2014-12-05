--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.4.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.4.0')
GO

CREATE TABLE gemini_organization
(
	organizationid INT IDENTITY(1,1) NOT NULL CONSTRAINT gemini_organization_organizationid_pk PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	organizationdesc NVARCHAR(500) NOT NULL,
	created datetime NOT NULL CONSTRAINT gemini_organization_created_def DEFAULT (getutcdate())
)
GO

CREATE TABLE gemini_organizationmembership
(
	id INT IDENTITY(1,1) CONSTRAINT gemini_gemini_organizationmembership_id_pk PRIMARY KEY,
	organizationid INT NOT NULL CONSTRAINT gemini_organizationmembership_organizationid_fk FOREIGN KEY REFERENCES gemini_organization(organizationid),
	userid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_organizationmembership_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	created DATETIME NOT NULL CONSTRAINT gemini_organizationmembership_created_def DEFAULT GETUTCDATE()
)
CREATE INDEX ind_gemini_organizationmembership_organizationid ON gemini_organizationmembership(organizationid)
CREATE INDEX ind_gemini_organizationmembership_userid ON gemini_organizationmembership(userid)
GO
