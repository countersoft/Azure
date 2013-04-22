--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini v4.2
--
-- DATA MIGRATION SCRIPT from Gemini 4.1 to Gemini 4.2
--
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'4.2')
GO

/**********************************************************************************************************************
* Amend Issues Table to include mailbox id
**********************************************************************************************************************/
ALTER TABLE gemini_issues ADD popmailboxid NUMERIC(10, 0) NULL
GO

/**********************************************************************************************************************
* Amend Mailbox Table 
**********************************************************************************************************************/
ALTER TABLE gemini_mailboxprocessor ADD smtpserver NVARCHAR(100) NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpserver_def DEFAULT ('')
ALTER TABLE gemini_mailboxprocessor ADD smtpserverport INT NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpserverport_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD smtpuseincomingauthdetail BIT NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpuseincomingauthdetail_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD smtpusername NVARCHAR(255) NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpusername_def DEFAULT ('')
ALTER TABLE gemini_mailboxprocessor ADD smtppassword NVARCHAR(255) NOT NULL CONSTRAINT gemini_mailboxprocessor_smtppassword_def DEFAULT ('')
ALTER TABLE gemini_mailboxprocessor ADD smtpencodingtype INT NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpencodingtype_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD smtpusessl BIT NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpusessl_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD smtpsslmode INT NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpsslmode_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD smtpauthmode INT NOT NULL CONSTRAINT gemini_mailboxprocessor_smtpauthmode_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD mode INT NOT NULL CONSTRAINT gemini_mailboxprocessor_mode_def DEFAULT (0)
ALTER TABLE gemini_mailboxprocessor ADD imapfolder NVARCHAR(255) NOT NULL CONSTRAINT gemini_mailboxprocessor_imapfolder_def DEFAULT ('')
ALTER TABLE gemini_mailboxprocessor ADD blacklist NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_mailboxprocessor_blacklist_def DEFAULT ('')
ALTER TABLE gemini_mailboxprocessor ADD noreplylist NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_mailboxprocessor_noreplylist_def DEFAULT ('')
ALTER TABLE gemini_mailboxprocessor ADD customfields NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_mailboxprocessor_customfields_def DEFAULT ('')
GO

ALTER TABLE gemini_projectdefaultvalues DROP CONSTRAINT gemini_projectdefaultvalues_defaultvalue_def
GO
ALTER TABLE gemini_projectdefaultvalues ALTER COLUMN defaultvalue NVARCHAR(MAX) NOT NULL 
GO
ALTER TABLE gemini_projectdefaultvalues ADD CONSTRAINT gemini_projectdefaultvalues_defaultvalue_def DEFAULT('') FOR defaultvalue 
GO

/**********************************************************************************************************************
* Add Converse Mailbox Supporting Tables
**********************************************************************************************************************/
CREATE TABLE gemini_converse_mailboxprocessor_message(
   processedmessageid INT IDENTITY(1, 1) NOT NULL CONSTRAINT gemini_converse_mailboxprocessor_message_processedmessageid_pk PRIMARY KEY,
   popmailboxid NUMERIC(10,0) NOT NULL CONSTRAINT gemini_converse_mailboxprocessor_message_gemini_mailboxprocessor_popmailboxid_fk FOREIGN KEY REFERENCES gemini_mailboxprocessor(popmailboxid),
   messageid NVARCHAR(255) NOT NULL,
   fromaddress NVARCHAR(500) NOT NULL,
   datereceived DATETIME NOT NULL,
   subject NVARCHAR(500) NOT NULL,
   created DATETIME NOT NULL CONSTRAINT [gemini_converse_mailboxprocessor_message_created_def] DEFAULT (GETDATE()),
   tstamp TIMESTAMP NOT NULL
)
GO

CREATE TABLE gemini_converse_mailboxprocessor_string (
   stringreplaceid INT IDENTITY (1, 1) NOT NULL CONSTRAINT gemini_converse_mailboxprocessor_string_stringreplaceid_pk PRIMARY KEY,
   popmailboxid NUMERIC(10, 0) NOT NULL CONSTRAINT gemini_converse_mailboxprocessor_string_gemini_mailboxprocessor_popmailboxid_fk FOREIGN KEY REFERENCES gemini_mailboxprocessor(popmailboxid),
   match NVARCHAR(MAX) NOT NULL,
   regex BIT NOT NULL,
   replacewith NVARCHAR(MAX) NOT NULL,
   truncatestring BIT NOT NULL,
   orderby INT NOT NULL,
   created DATETIME NOT NULL CONSTRAINT gemini_converse_mailboxprocessor_string_created_def DEFAULT(GETDATE()),
   tstamp TIMESTAMP NOT NULL
)
GO

/* Converse Settings */
CREATE TABLE gemini_converse_settings
(
	settingid INT NOT NULL IDENTITY(1,1) CONSTRAINT gemini_converse_settings_settingid_pk PRIMARY KEY,
	settingname NVARCHAR(200) NOT NULL,
	settingvalue NVARCHAR(MAX) NOT NULL,
	tstamp TIMESTAMP NOT NULL 
)
GO

ALTER TABLE gemini_testing_history ALTER COLUMN history NVARCHAR(MAX) NOT NULL
GO
