--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.8.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.8.0')
GO

CREATE TABLE gemini_calendar
(
	id INT IDENTITY(1,1) NOT NULL CONSTRAINT gemini_sla_calendar_id_pk PRIMARY KEY,
	name NVARCHAR(50) NOT NULL,
	[description] NVARCHAR(500) NOT NULL,
	nonworkingdays NVARCHAR(MAX) NOT NULL,
	workingdays NVARCHAR(MAX) NOT NULL,
	[created] DATETIME NOT NULL CONSTRAINT gemini_sla_calendar_created_def DEFAULT GETUTCDATE(),
	[revised] DATETIME NOT NULL CONSTRAINT [gemini_sla_calendar_revised_def] DEFAULT (GETUTCDATE()),
)
GO


ALTER TABLE gemini_sla
ADD calendarid INT NULL CONSTRAINT gemini_sla_calendarid_fk FOREIGN KEY REFERENCES gemini_calendar( id )
GO

CREATE INDEX ind_gemini_sla_calendarid ON gemini_sla(calendarid)
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'gemini_tr_users_update'))
DROP TRIGGER gemini_tr_users_update
GO

CREATE TRIGGER gemini_tr_users_update
    ON gemini_users
    AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON

IF EXISTS (SELECT * FROM inserted i JOIN deleted d ON i.userid = d.userid WHERE i.userid=-2 AND i.username!=d.username)
BEGIN
	-- Revert the username to -2system and throw!
	UPDATE gemini_users SET username='-2system' WHERE userid=-2
	RAISERROR ('Cannot update the system user name.', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               ); 
END
               
END
GO

ALTER TABLE breeze_mailbox ADD sslmode VARCHAR(10)
GO

IF COL_LENGTH('gemini_users','adfssid') IS NULL 
ALTER TABLE gemini_users ADD adfssid NVARCHAR(124) NULL 
GO

IF COL_LENGTH('gemini_users','lockuservaluesfromadsync') IS NULL 
ALTER TABLE gemini_users ADD lockuservaluesfromadsync BIT NULL 
GO

IF NOT EXISTS (SELECT index_id FROM sys.indexes WHERE NAME = 'ind_gemini_users_username_adfssid' AND object_id = OBJECT_ID('gemini_users'))
CREATE NONCLUSTERED INDEX ind_gemini_users_username_adfssid ON gemini_users (username, adfssid)
GO

