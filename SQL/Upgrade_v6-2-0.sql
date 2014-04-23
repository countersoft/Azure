--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 6.2.0
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.2.0')
GO

CREATE TABLE gemini_webnode
(
	id int IDENTITY(1,1) NOT NULL CONSTRAINT gemini_webnode_id_pk PRIMARY KEY,
	nodeguid NVARCHAR(100) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_webnode_created_def DEFAULT GETUTCDATE()
)
GO
CREATE INDEX ind_gemini_webnode_appguid ON gemini_webnode(nodeguid)
GO

CREATE TABLE gemini_webnodedata
(
	id int IDENTITY(1,1) NOT NULL CONSTRAINT gemini_webnodedata_id_pk PRIMARY KEY,
	nodeguid NVARCHAR(100) NOT NULL,
	datakey NVARCHAR(500) NOT NULL,
	datavalue NVARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_webnodedata_created_def DEFAULT GETUTCDATE()
)
GO
CREATE INDEX ind_gemini_webnodedata_appguid ON gemini_webnodedata(nodeguid)
GO

ALTER TABLE gemini_issues ADD slaid INT NULL 
GO
CREATE INDEX ind_gemini_issues_slaid ON gemini_issues(slaid)
GO

ALTER TABLE gemini_issues ADD slastatus INT NULL 
GO
CREATE INDEX ind_gemini_issues_slastatus ON gemini_issues(slastatus)
GO

ALTER TABLE gemini_issues ADD slaresolution INT NULL 
GO
CREATE INDEX ind_gemini_issues_slaresolution ON gemini_issues(slaresolution)
GO
ALTER TABLE gemini_issues ADD slaresolutiondate DATETIME NULL 
GO

ALTER TABLE gemini_issues ADD slastatusdate DATETIME NULL 
GO

ALTER TABLE gemini_issues ADD slastatustimepassed INT NULL 
GO


CREATE TABLE gemini_sla
(
	id INT IDENTITY(1,1) NOT NULL CONSTRAINT gemini_sla_id_pk PRIMARY KEY,
	sequence INT NOT NULL,
	name NVARCHAR(50) NOT NULL,
	sladesc NVARCHAR(500) NOT NULL,
	startrules INT NULL,
	pauserules INT NULL,
	resumerules INT NULL,
	stoprules INT NULL,
	interval INT NOT NULL,	
	is24x7 BIT NOT NULL,
	startdayhour INT NOT NULL,
	startdayminute INT NOT NULL,
	enddayhour INT NOT NULL,
	enddayminute INT NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_sla_created_def DEFAULT GETUTCDATE()
)
GO

CREATE TABLE gemini_rulesactions
(
	id INT IDENTITY(1,1) NOT NULL CONSTRAINT gemini_rulesactions_id_pk PRIMARY KEY,
	slaid INT NULL,
	sequence INT NOT NULL,
	name NVARCHAR(50) NOT NULL,
	longdesc NVARCHAR(500) NOT NULL,
	stopprocessing BIT NOT NULL,
	onbeforecreate BIT NOT NULL,
	onbeforeupdate BIT NOT NULL,
	onaftercreate BIT NOT NULL,
	onafterupdate BIT NOT NULL,
	ontimer BIT NOT NULL,
	onetimeaction BIT NOT NULL,
	rules NVARCHAR(MAX) NOT NULL,
	actions NVARCHAR(MAX) NOT NULL,
	revised DATETIME NOT NULL CONSTRAINT gemini_rulesactions_revised_def DEFAULT GETUTCDATE(),
	created DATETIME NOT NULL CONSTRAINT gemini_rulesactions_created_def DEFAULT GETUTCDATE()
)
GO

CREATE INDEX ind_gemini_rulesactions_slaid ON gemini_rulesactions(slaid)
GO
