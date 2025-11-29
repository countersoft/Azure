--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.8.1

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.8.1')
GO

CREATE TABLE gemini_languages (
	[languageid] [int] IDENTITY(1,1) CONSTRAINT gemini_languages_languageid_pk PRIMARY KEY,
	[languagecode] varchar(10),
	[culturecode] varchar(10),
	[name] nvarchar(100),
	[preinstalled] bit,
	[active] bit
) 
GO

CREATE TABLE gemini_translationcontent (
	[contentid] [int] IDENTITY(1,1) CONSTRAINT gemini_translationcontent_contentid_pk PRIMARY KEY,
	[languageid] int  CONSTRAINT gemini_translationcontent_languageid_fk FOREIGN KEY REFERENCES gemini_languages(languageid),
	[entitytype] int NULL,
	[contentkey] varchar(20),
	[content] nvarchar(max),
	[created] DATETIME NOT NULL CONSTRAINT gemini_translationcontent_created_def DEFAULT GETUTCDATE(),
	[revised] DATETIME NOT NULL CONSTRAINT [gemini_translationcontent_revised_def] DEFAULT (getutcdate()),
)
GO

IF NOT EXISTS (SELECT * FROM gemini_languages) BEGIN

	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('af', 'ZA', 'Afrikaans - South Africa', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'AE', 'Arabic - United Arab Emirates', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'BH', 'Arabic - Bahrain', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'DZ', 'Arabic - Algeria', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'EG', 'Arabic - Egypt', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'IQ', 'Arabic - Iraq', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'JO', 'Arabic - Jordan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'KW', 'Arabic - Kuwait', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'LB', 'Arabic - Lebanon', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'LY', 'Arabic - Libya', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'MA', 'Arabic - Morocco', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'OM', 'Arabic - Oman', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'QA', 'Arabic - Qatar', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'SA', 'Arabic - Saudi Arabia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'SY', 'Arabic - Syria', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'TN', 'Arabic - Tunisia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ar', 'YE', 'Arabic - Yemen', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('be', 'BY', 'Belarusian - Belarus', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('bg', 'BG', 'Bulgarian - Bulgaria', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ca', 'ES', 'Catalan - Catalan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('cs', 'CZ', 'Czech - Czech Republic', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('Cy', 'az-AZ', 'Azeri (Cyrillic) - Azerbaijan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('Cy', 'sr-SP', 'Serbian (Cyrillic) - Serbia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('Cy', 'uz-UZ', 'Uzbek (Cyrillic) - Uzbekistan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('da', 'DK', 'Danish - Denmark', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('de', 'AT', 'German - Austria', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('de', 'CH', 'German - Switzerland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('de', 'DE', 'German - Germany', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('de', 'LI', 'German - Liechtenstein', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('de', 'LU', 'German - Luxembourg', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('di', '-MV', 'Dhivehi - Maldives', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('el', 'GR', 'Greek - Greece', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'AU', 'English - Australia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'BZ', 'English - Belize', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'CA', 'English - Canada', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'CB', 'English - Caribbean', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'GB', 'English - United Kingdom', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'IE', 'English - Ireland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'JM', 'English - Jamaica', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'NZ', 'English - New Zealand', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'PH', 'English - Philippines', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'TT', 'English - Trinidad and Tobago', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'US', 'English - United States', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'ZA', 'English - South Africa', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('en', 'ZW', 'English - Zimbabwe', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'AR', 'Spanish - Argentina', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'BO', 'Spanish - Bolivia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'CL', 'Spanish - Chile', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'CO', 'Spanish - Colombia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'CR', 'Spanish - Costa Rica', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'DO', 'Spanish - Dominican Republic', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'EC', 'Spanish - Ecuador', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'ES', 'Spanish - Spain', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'GT', 'Spanish - Guatemala', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'HN', 'Spanish - Honduras', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'MX', 'Spanish - Mexico', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'NI', 'Spanish - Nicaragua', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'PA', 'Spanish - Panama', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'PE', 'Spanish - Peru', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'PR', 'Spanish - Puerto Rico', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'PY', 'Spanish - Paraguay', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'SV', 'Spanish - El Salvador', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'UY', 'Spanish - Uruguay', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('es', 'VE', 'Spanish - Venezuela', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('et', 'EE', 'Estonian - Estonia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('eu', 'ES', 'Basque - Basque', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fa', 'IR', 'Farsi - Iran', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fi', 'FI', 'Finnish - Finland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fo', 'FO', 'Faroese - Faroe Islands', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fr', 'BE', 'French - Belgium', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fr', 'CA', 'French - Canada', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fr', 'CH', 'French - Switzerland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fr', 'FR', 'French - France', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fr', 'LU', 'French - Luxembourg', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('fr', 'MC', 'French - Monaco', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('gl', 'ES', 'Galician - Galician', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('gu', 'IN', 'Gujarati - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('he', 'IL', 'Hebrew - Israel', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('hi', 'IN', 'Hindi - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('hr', 'HR', 'Croatian - Croatia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('hu', 'HU', 'Hungarian - Hungary', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('hy', 'AM', 'Armenian - Armenia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('id', 'ID', 'Indonesian - Indonesia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('is', 'IS', 'Icelandic - Iceland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('it', 'CH', 'Italian - Switzerland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('it', 'IT', 'Italian - Italy', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ja', 'JP', 'Japanese - Japan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ka', 'GE', 'Georgian - Georgia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('kk', 'KZ', 'Kazakh - Kazakhstan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('kn', 'IN', 'Kannada - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ko', '-IN', 'Konkani - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ko', 'KR', 'Korean - Korea', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ky', 'KZ', 'Kyrgyz - Kazakhstan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('Lt', 'az-AZ', 'Azeri (Latin) - Azerbaijan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('lt', 'LT', 'Lithuanian - Lithuania', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('Lt', 'sr-SP', 'Serbian (Latin) - Serbia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('Lt', 'uz-UZ', 'Uzbek (Latin) - Uzbekistan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('lv', 'LV', 'Latvian - Latvia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('mk', 'MK', 'Macedonian (FYROM)', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('mn', 'MN', 'Mongolian - Mongolia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('mr', 'IN', 'Marathi - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ms', 'BN', 'Malay - Brunei', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ms', 'MY', 'Malay - Malaysia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('nb', 'NO', 'Norwegian (Bokmål) - Norway', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('nl', 'BE', 'Dutch - Belgium', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('nl', 'NL', 'Dutch - The Netherlands', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('nn', 'NO', 'Norwegian (Nynorsk) - Norway', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('pa', 'IN', 'Punjabi - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('pl', 'PL', 'Polish - Poland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('pt', 'BR', 'Portuguese - Brazil', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('pt', 'PT', 'Portuguese - Portugal', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ro', 'RO', 'Romanian - Romania', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ru', 'RU', 'Russian - Russia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sa', 'IN', 'Sanskrit - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sk', 'SK', 'Slovak - Slovakia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sl', 'SI', 'Slovenian - Slovenia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sq', 'AL', 'Albanian - Albania', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sv', 'FI', 'Swedish - Finland', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sv', 'SE', 'Swedish - Sweden', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sw', 'KE', 'Swahili - Kenya', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('sy', '-SY', 'Syriac - Syria', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ta', 'IN', 'Tamil - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('te', 'IN', 'Telugu - India', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('th', 'TH', 'Thai - Thailand', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('tr', 'TR', 'Turkish - Turkey', 1, 1)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('tt', 'RU', 'Tatar - Russia', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('uk', 'UA', 'Ukrainian - Ukraine', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('ur', 'PK', 'Urdu - Pakistan', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('vi', 'VN', 'Vietnamese - Vietnam', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'CHS', 'Chinese (Simplified)', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'CHT', 'Chinese (Traditional)', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'CN', 'Chinese - China', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'HK', 'Chinese - Hong Kong SAR', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'MO', 'Chinese - Macau SAR', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'SG', 'Chinese - Singapore', 0, 0)
	INSERT INTO gemini_languages (languagecode, culturecode, name, active, preinstalled) VALUES ('zh', 'TW', 'Chinese - Taiwan', 0, 0)

END
GO


ALTER TABLE gemini_rulesactions ALTER COLUMN name NVARCHAR(100);
GO

