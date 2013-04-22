--*********************************************************************************
--*********************************************************************************
--
-- Gemini Project Issue Tracking -- Version 3.1
--
-- DATA MIGRATION SCRIPT: Prepare 3.0.4 Gemini database schema for use with 3.1
--
--*********************************************************************************
--*********************************************************************************
TRUNCATE TABLE gemini_install
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'3.1')
GO

--*********************************************************************************
-- Application Settings
--*********************************************************************************
UPDATE gemini_applicationsettings SET 
	settingvalue = 'US English|en-US|UK English|en-GB|German|de-DE|Spanish|es-ES|Italian|it-IT|French|fr-FR|Japanese|ja-JP|Portuguese|pt-PT|Chinese Simplified|zh-CHS|Chinese Traditional|zh-TW|Russian|ru-RU|Greek|el-GR|Dutch|nl-NL|Polish|pl-PL|Brazilian Portuguese|pt-BR|Czech|cs-CZ|Slovak|sk-SK|Swedish|se-SE'
	where settingname = 'InstalledLanguages'
GO

INSERT INTO gemini_applicationsettings (settingname, settingcategory, settingvalue, settingdesc)
	VALUES('CaptchaEnabled','Security','NO','Are we running captcha mode for user input?')
GO

--*********************************************************************************
-- Project Components
--*********************************************************************************
ALTER TABLE gemini_components ADD parentcomponentid NUMERIC(10, 0) NULL 
GO

--*********************************************************************************
-- Project Labels
--*********************************************************************************
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectlabels') DROP TABLE gemini_projectlabels
GO

CREATE TABLE gemini_projectlabels
(
	labelid NUMERIC(10,0) NOT NULL IDENTITY(1,1) CONSTRAINT gemini_projectlabels_appointment_pk PRIMARY KEY,
	labelname NVARCHAR(100) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_projectlabels_created_def DEFAULT CURRENT_TIMESTAMP,
	tstamp TIMESTAMP NOT NULL
)
GO

ALTER TABLE gemini_projects ADD projectlabelid NUMERIC(10, 0) NULL CONSTRAINT gemini_projects_labelid_fk FOREIGN KEY REFERENCES gemini_projectlabels(labelid)
GO

--*********************************************************************************
-- Users
--*********************************************************************************
ALTER TABLE gemini_users ADD apikey VARCHAR(50) NOT NULL CONSTRAINT gemini_users_apikey_def DEFAULT('')
GO