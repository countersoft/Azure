--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.8.5

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.8.5')

GO

CREATE TABLE [gemini_templatedcontent](
	[templatedcontentid] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [gemini_teamplatedcontent_tempaltedcontentid_pk] PRIMARY KEY ,
	[name] [nvarchar](100) NOT NULL,
	[response] [nvarchar](max) NOT NULL,
	[projects] [nvarchar](max) NOT NULL,
	[groups] [nvarchar](max) NOT NULL,
	[associations] [nvarchar](max) NOT NULL,
	[created] [datetime] NOT NULL CONSTRAINT [gemini_templatedcontent_created_def]  DEFAULT (getutcdate()),
	[revised] [datetime] NOT NULL CONSTRAINT [gemini_templatedcontent_revised_def]  DEFAULT (getutcdate()),
)

GO

INSERT INTO gemini_templatedcontent ([name], associations, projects, response, groups)
SELECT [name], '4', projects, response, '2|3|'  FROM [breeze_cannedresponse]

GO

DROP TABLE breeze_cannedresponse

GO

