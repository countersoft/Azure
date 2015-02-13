--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.4.2

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.4.2')
GO
ALTER TABLE gemini_chat ADD CONSTRAINT [gemini_chat_chatid_pk] PRIMARY KEY CLUSTERED  (chatid)
GO
ALTER TABLE gemini_cardissuesequence ADD CONSTRAINT [gemini_cardissuesequence_id_pk] PRIMARY KEY CLUSTERED  (id)
GO

