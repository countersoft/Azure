--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT from Gemini 5.1 to Gemini 5.1.2
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.1.2')
GO

ALTER TABLE breeze_mailbox ADD options NVARCHAR(MAX) NOT NULL CONSTRAINT breeze_mailbox_options_def DEFAULT ('')
GO

ALTER TABLE gemini_issuetimetype ADD seq INT NOT NULL CONSTRAINT gemini_issuetimetype_seq_def DEFAULT(0)
GO

UPDATE gemini_alerttemplates SET alertcontent = REPLACE(alertcontent,'@(Model.LinkViewItem)','@Html.Raw(Model.LinkViewItem)')
GO
