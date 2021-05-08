--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 7.1.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'7.1.0')

GO

TRUNCATE TABLE gemini_systemlog
GO

CREATE TABLE breeze_closeticketoptions
(
	id INT IDENTITY(1,1) NOT NULL CONSTRAINT breeze_closeticketoptions_id_pk PRIMARY KEY,
	confirmationtext NVARCHAR(MAX) NOT NULL,
	allowfinalcomment BIT NOT NULL,
	finalcommenttext NVARCHAR(MAX) NOT NULL,
	templateclosedstatus NVARCHAR(MAX) NOT NULL,
	commentbuttontext NVARCHAR(100) NOT NULL,
	[created] DATETIME NOT NULL CONSTRAINT breeze_closeticketoptions_created_def DEFAULT GETUTCDATE(),
	[revised] DATETIME NOT NULL CONSTRAINT breeze_closeticketoptions_revised_def DEFAULT (GETUTCDATE()),
)
GO

SET IDENTITY_INSERT dbo.breeze_closeticketoptions ON 
GO

INSERT breeze_closeticketoptions (id, confirmationtext, allowfinalcomment, finalcommenttext, templateclosedstatus, commentbuttontext, created, revised) 
VALUES (1, N'<p>Thank you! @Model.TheItem.Title has been closed. You may add a comment for the sender below.</p>', 1, N'<p>Thank you, the ticket is closed, and your comment added to it.</p>', N'{"10":70,"12":88,"13":98,"22":167,"21":160,"19":151}', N'Add and Close', CAST(N'2020-07-27 09:08:37.437' AS DateTime), CAST(N'2020-07-29 13:44:16.000' AS DateTime))
GO

SET IDENTITY_INSERT breeze_closeticketoptions OFF
GO


/*  ENQUIRY SMTP OAUTH FIELDS  */
ALTER TABLE breeze_smtpserver ADD scopes NVARCHAR(250)
GO
ALTER TABLE breeze_smtpserver ADD discoveryurl NVARCHAR(250)
GO
ALTER TABLE breeze_smtpserver ADD clientid NVARCHAR(100)
GO
ALTER TABLE breeze_smtpserver ADD tenantid NVARCHAR(100)
GO
ALTER TABLE breeze_smtpserver ADD clientsecret NVARCHAR(500)
GO
ALTER TABLE breeze_smtpserver ADD oauthprovider NVARCHAR(100)
GO
ALTER TABLE breeze_smtpserver ADD tokenstore varbinary(max)
GO


/*  ENQUIRY Mailbox OAUTH FIELDS  */
ALTER TABLE breeze_mailbox ADD scopes NVARCHAR(250)
GO
ALTER TABLE breeze_mailbox ADD discoveryurl NVARCHAR(250)
GO
ALTER TABLE breeze_mailbox ADD clientid NVARCHAR(100)
GO
ALTER TABLE breeze_mailbox ADD tenantid NVARCHAR(100)
GO
ALTER TABLE breeze_mailbox ADD clientsecret NVARCHAR(500)
GO
ALTER TABLE breeze_mailbox ADD oauthprovider NVARCHAR(100)
GO
ALTER TABLE breeze_mailbox ADD tokenstore varbinary(max)
GO


/* Only consider processing unread emails */
ALTER TABLE breeze_mailbox ADD onlyprocessunread bit
GO


