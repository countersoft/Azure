--*********************************************************************************

--*********************************************************************************
--

-- (c) Countersoft Gemini

--

-- DATA MIGRATION SCRIPT to Gemini 6.2.1

---

--*********************************************************************************

--*********************************************************************************

DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'6.2.1')
GO

DECLARE @templateCount INT

DECLARE @values NVARCHAR(MAX)

SELECT @templateCount = COUNT(*) FROM gemini_projecttemplate


SELECT @values=ISNULL('' + (SELECT '{"TemplateId":' + convert(varchar,templateid) + ',"Items":[{"Id":'+ convert(VARCHAR,(ROW_NUMBER() OVER(ORDER BY templateid DESC)-1)*5+1) +',"Title":"Code Committed"},{"Id":'+convert(VARCHAR,(ROW_NUMBER() OVER(ORDER BY templateid DESC)-1)*5+2)+',"Title":"Documentation Updated"},{"Id":'+convert(VARCHAR,(ROW_NUMBER() OVER(ORDER BY templateid DESC)-1)*5+3)+',"Title":"Release Notes Compiled"},{"Id":'+convert(VARCHAR,(ROW_NUMBER() OVER(ORDER BY templateid DESC)-1)*5+4)+',"Title":"PDF Generated"},{"Id":'+convert(VARCHAR,(ROW_NUMBER() OVER(ORDER BY templateid DESC)-1)*5+5)+',"Title":"Paperwork Submitted"}]},'
FROM gemini_projecttemplate FOR XML PATH('')), '')



INSERT INTO gemini_globalconfigurationwidgetdata (appid,value,created) VALUES ('8FAC8849-04C0-418B-BC3B-E30A815A3E7A','{"CurrentSequence":' + CAST(@templateCount*5 AS VARCHAR) +',"Data":['+ substring(@values,1, len(@values)-1) + ']}',GETDATE())

GO

ALTER TABLE gemini_users ALTER COLUMN apikey varchar(50) COLLATE Latin1_General_CI_AS NOT NULL

GO
