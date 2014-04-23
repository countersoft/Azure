ALTER TABLE gemini_applicationsettings ALTER COLUMN settingvalue NVARCHAR(MAX)
GO

ALTER TABLE gemini_customfielddefinitions ADD canfilter BIT NOT NULL CONSTRAINT gemini_customfielddefinitions_canfilter_def DEFAULT 0
GO

CREATE TABLE breeze_mailboxmessage (
      messageid INT IDENTITY(1,1) NOT NULL CONSTRAINT breeze_mailboxmessage_messageid_pk PRIMARY KEY,
      mailboxid INT NOT NULL CONSTRAINT breeze_mailboxmessage_mailboxid_def DEFAULT(0),
      [uid] NVARCHAR(255) NOT NULL CONSTRAINT breeze_mailboxmesssage_uid_def DEFAULT(''),
      created DATETIME NOT NULL CONSTRAINT breeze_mailboxmessage_created_def DEFAULT (GETUTCDATE()),
      tstamp TIMESTAMP NOT NULL
)
GO

ALTER TABLE breeze_mailbox ADD issuetypeid INT NULL
GO
