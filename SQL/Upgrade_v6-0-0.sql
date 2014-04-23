--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT to Gemini 6.0.0
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.0.0')
GO

IF EXISTS(SELECT *  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS  WHERE CONSTRAINT_NAME ='gemini_navigationcard_originatorid_fk')
BEGIN
	ALTER TABLE gemini_navigationcard DROP CONSTRAINT gemini_navigationcard_originatorid_fk
END
GO

ALTER TABLE gemini_navigationcard ADD filterdata NVARCHAR(MAX)
GO

UPDATE gemini_navigationcard SET cardurl = 'items', filterdata = cardoptions  WHERE cardtype=1
UPDATE gemini_navigationcard SET cardurl = 'calendar' WHERE cardtype=20
UPDATE gemini_navigationcard SET cardurl = 'timeline' WHERE cardtype=19
UPDATE gemini_navigationcard SET cardurl = 'board' WHERE cardtype=2
UPDATE gemini_navigationcard SET cardurl = 'activity' WHERE cardtype=9
UPDATE gemini_navigationcard SET cardurl = 'activity/overdue' WHERE cardtype=12
UPDATE gemini_navigationcard SET cardurl = 'activity/due-today' WHERE cardtype=13
UPDATE gemini_navigationcard SET cardurl = 'activity/due-tomorrow' WHERE cardtype=14
UPDATE gemini_navigationcard SET cardurl = 'activity/opened-recently' WHERE cardtype=15
UPDATE gemini_navigationcard SET cardurl = 'activity/closed-recently' WHERE cardtype=16
UPDATE gemini_navigationcard SET cardurl = 'progress/burndown' WHERE cardtype=5
UPDATE gemini_navigationcard SET cardurl = 'progress/roadmap' WHERE cardtype=3
UPDATE gemini_navigationcard SET cardurl = 'progress/changelog' WHERE cardtype=4
UPDATE gemini_navigationcard SET cardurl = 'documents' WHERE cardtype=8
GO

UPDATE a 
	SET a.filterdata = c.issuesfilter
FROM gemini_navigationcard a JOIN gemini_sharedviews b ON a.cardoptions=b.sharedviewid JOIN gemini_plannerviews c ON b.value = c.plannerviewid
WHERE a.cardtype=2
GO

DELETE FROM  gemini_navigationcard  WHERE cardtype IN (11,21,3,4,7,9,12,13,14,15,16, 0, 8)
GO

CREATE TABLE gemini_chat
(
	chatid INT IDENTITY(1,1) NOT NULL,
	cardid INT NOT NULL CONSTRAINT gemini_chat_cardid_fk FOREIGN KEY REFERENCES gemini_navigationcard(cardid),
	userid NUMERIC(10,0) NULL CONSTRAINT gemini_chat_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	otheruserids VARCHAR(4000) NOT NULL CONSTRAINT gemini_chat_otheruserids_def DEFAULT (''),
	chattext NVARCHAR(MAX),
	created datetime NOT NULL CONSTRAINT gemini_chat_created_def DEFAULT (getutcdate())
)
GO
CREATE INDEX ind_gemini_chat_cardid ON gemini_chat(cardid)
CREATE INDEX ind_gemini_chat_userid ON gemini_chat(userid)
CREATE INDEX ind_gemini_chat_created ON gemini_chat(created)
GO

CREATE TABLE gemini_cardissuesequence
(
	id INT NOT NULL IDENTITY(1, 1),
	cardid INT NOT NULL CONSTRAINT gemini_cardissuesequence_cardid_fk FOREIGN KEY REFERENCES gemini_navigationcard(cardid),
	sequence VARCHAR(MAX) NOT NULL,
	created DATETIME NOT NULL CONSTRAINT gemini_cardissuesequence_created_def DEFAULT (getutcdate()),
	tstamp TIMESTAMP NOT NULL
)
GO
CREATE INDEX ind_gemini_cardissuesequence_projectid ON gemini_cardissuesequence(cardid)
GO

ALTER TABLE gemini_plannerviews DROP COLUMN issuesfilter
GO

ALTER TABLE gemini_users ADD previouspasswords NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_users_previouspasswords_def DEFAULT ('')
ALTER TABLE gemini_users ADD locked BIT CONSTRAINT gemini_users_locked_def DEFAULT ((0))
GO

ALTER TABLE gemini_users ADD userexperience INT CONSTRAINT gemini_users_userexperience_def DEFAULT(0)
GO

UPDATE gemini_users SET userexperience = 0
UPDATE gemini_users SET userexperience = userexperience + 4 WHERE userid in (SELECT reportedby FROM gemini_issues)
UPDATE gemini_users SET userexperience = userexperience + 8 WHERE userid in (SELECT userid FROM gemini_navigationcard)
UPDATE gemini_users SET userexperience = userexperience + 2 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 
GO

CREATE TABLE gemini_optoutemails(
	id int IDENTITY(1,1) NOT NULL,
	userid numeric(10, 0) NOT NULL CONSTRAINT gemini_optoutemails_userid_fk FOREIGN KEY REFERENCES gemini_users(userid),
	cardid int NOT NULL CONSTRAINT gemini_optoutemails_cardid_fk FOREIGN KEY REFERENCES gemini_navigationcard(cardid),
	optouttype tinyint NOT NULL,
	CONSTRAINT gemini_optoutemails_id_pk PRIMARY KEY (id)
)
GO
CREATE INDEX gemini_optoutemails_cardid ON gemini_optoutemails(cardid)
CREATE INDEX gemini_optoutemails_userid ON gemini_optoutemails(userid)
GO

SET IDENTITY_INSERT gemini_users ON
INSERT INTO gemini_users (userid, username, firstname, surname, pwd, emailaddress, roles, resetpwd, comment, apikey, active, created, lastupdated, logindate, previouslogindate, openid, timezoneid, culture, languageid, theme, emailme, emailmemychanges, settings, userexperience, previouspasswords, locked) 
VALUES (-2, N'-2system', N'System', N'Account', 0x0, N'', N'', NULL, N'', '', 1, '2008-01-31T14:38:25.873', '2013-11-21T11:09:18.000', '2013-11-21T11:09:18.000', '2013-11-19T18:08:44.000', N'', 'UTC', '', '', '', 1, 1, N'', 0, N'', 0)
SET IDENTITY_INSERT gemini_users OFF
GO

INSERT INTO gemini_projectgroupmembership (userid, projectid, projectgroupid) VALUES(-2, null, 2)
GO

ALTER TABLE gemini_issuecomments ADD originatortype INT NOT NULL CONSTRAINT gemini_issuecomments_originatortype_def DEFAULT (0)
ALTER TABLE gemini_issuecomments ADD originatordata NVARCHAR(255) NULL
GO
UPDATE gemini_issuecomments SET originatortype = commenttype
GO
ALTER TABLE gemini_issuecomments DROP CONSTRAINT gemini_issuecomments_commenttype_def
ALTER TABLE gemini_issuecomments DROP COLUMN commenttype
GO
