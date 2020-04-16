--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.10.0

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.10.0')

GO

INSERT INTO gemini_alerttemplates (alerttype, label, alertcontent, projects, created, templatedata) VALUES 
(9, 'Password Reset', '<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
    <tbody>
        <tr>
            <td style="color: #FFFFFF;">Gemini Tracker</td>
        </tr>
    </tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
    <tbody>
        <tr>
            <td style="color: #4c4c4c;">
                <p>Dear @Model.TheRecipient.Fullname,</p>
                <p>
                    A new password has been requested. Please click on the below link to create a new password. If you did
                    not request this new password, please disregard this email - your current password remains unchanged.
                </p>
            </td>
        </tr>
    </tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
    <tbody>
        <tr>
            <td style="color: #4c4c4c;"><a href="@Html.Raw(Model.ResetUrl)">@Model.ResetUrl</a></td>
        </tr>
    </tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
    <tbody>
        <tr>
            <td style="color: #4c4c4c;">Thanks.</td>
        </tr>
    </tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: #ffffff;" cellpadding="5">
    <tbody>
        <tr><td><br /></td></tr>
        <tr>
            <td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
        </tr>
    </tbody>
</table>', '', GETDATE(), '{"Subject":""}')

GO

CREATE TABLE [dbo].[gemini_issueviewings](
	[userid] [int] NOT NULL,
	[issueid] [int] NOT NULL,
	[dateviewed] [datetime] NOT NULL,
 CONSTRAINT [PK_gemini_issueviewings] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[issueid] ASC
))
GO

CREATE INDEX idx_gemini_issueviewings_userid ON [gemini_issueviewings] (userid);
CREATE INDEX idx_gemini_issueviewings_issueid ON [gemini_issueviewings] (issueid);
GO

CREATE TABLE [gemini_systemlocks](
	[referenceid] [int] NOT NULL,
	[entitytype] [int] NOT NULL,
	[variant] [int] NOT NULL,
	[details] [nvarchar](50) NOT NULL,
	[created] [datetime] NOT NULL,
	[expiry] [datetime] NULL,
 CONSTRAINT [PK_gemini_systemlocks] PRIMARY KEY CLUSTERED 
(
	[referenceid] ASC,
	[entitytype] ASC,
	[variant] ASC
) )
GO

ALTER TABLE gemini_testing_run_steps ADD testdate DATETIME NULL
GO

ALTER TABLE gemini_alerttemplates add languageid INT NULL
GO

