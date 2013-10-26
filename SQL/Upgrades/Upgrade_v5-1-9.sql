--*********************************************************************************
--*********************************************************************************
--
-- (c) Countersoft Gemini
--
-- DATA MIGRATION SCRIPT from Gemini 5.1.6 to Gemini 5.1.9
---
--*********************************************************************************
--*********************************************************************************
DELETE FROM gemini_install WHERE attribute_key = N'VERSION'
INSERT INTO gemini_install (attribute_key,attribute_value) VALUES (N'VERSION',N'5.1.9')
GO

ALTER TABLE gemini_alerttemplates ADD templatedata NVARCHAR(MAX) NOT NULL CONSTRAINT gemini_alerttemplates_templatedata_def DEFAULT('')
GO

CREATE TABLE gemini_info
(
	infotype NVARCHAR(50),
	infodata NVARCHAR(MAX),
	created DATETIME DEFAULT(getutcdate())
)
GO

INSERT INTO gemini_info(infotype, infodata) VALUES('INSTALL', 'ZIP')
GO

ALTER TABLE breeze_enquiry ALTER COLUMN [issuekey] [nvarchar] (100) 
GO
UPDATE gemini_alerttemplates SET alerttype = 7
GO
INSERT INTO gemini_alerttemplates ([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (4, N'When something in the AppNav Card changes', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know that there are <strong>@(Model.ChangeCount) changes </strong> to your <strong>@(Model.CardTitle)</strong> AppNav card.</td>
</tr>
</tbody>
</table>
<br/>
@if (Model.AllItems.Count > 0)
{
	@foreach(var item in Model.AllItems)
	{
		<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: whitesmoke; border-collapse: collapse;" cellpadding="10">
		<tbody>
		<tr>
			<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;"><span style="font-size:10px;color:#808080;">@(Model.IsNew(item) ? "NEW" : "")</span> <a href="@Html.Raw(Model.ItemUrl(item))">@item.IssueKey - @item.Title</a></td>
		</tr>
		</tbody>
		</table>
		<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
		<tbody>
			@foreach(var change in item.ChangeLog)
			{
		<tr>
			<td><strong>@change.Field</strong> @change.Change</td>
		</tr>
			}
			<tr><td>&nbsp;</td></tr>
		</tbody>
		</table>
	}
}
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks.</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: #ffffff;" cellpadding="5">
<tbody>
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2012-08-01T19:32:32.027', N'{"Subject":""}')
INSERT INTO gemini_alerttemplates ([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (2, N'When watched items change', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know that there are <strong>@(Model.ChangeCount) changes </strong> to your watched items.</td>
</tr>
</tbody>
</table>
<br/>
@if (Model.TheItemsUpdated.Count > 0)
{
	@foreach(var item in Model.TheItemsUpdated)
	{
		<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: whitesmoke; border-collapse: collapse;" cellpadding="10">
		<tbody>
		<tr>
		<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;"><a href="@Html.Raw(Model.ItemUrl(item))">@item.IssueKey - @item.Title</a></td>
		</tr>
		</tbody>
		</table>
		<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
		<tbody>
			@foreach(var change in item.ChangeLog)
			{
		<tr>
			<td><strong>@change.Field</strong> @change.Change</td>
		</tr>
			}
			<tr><td>&nbsp;</td></tr>
		</tbody>
		</table>
	}
}

<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks.</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: #ffffff;" cellpadding="5">
<tbody>
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2012-08-01T19:32:32.027', N'{"Subject":""}')
INSERT INTO gemini_alerttemplates ([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (1, N'When new things are added', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">New item has been created by @Model.TheItem.Reporter @Model.TheItem.CreatedRelative.</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
<tbody>
<tr>
	<td style="color: #4c4c4c;"><a href="@Html.Raw(Model.ItemUrl(Model.TheItem))">@Model.TheItem.IssueKey - @Model.TheItem.Title</a></td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Type</strong></td>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;">@(Model.TheItem.Type)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Status</strong></td>
<td style="border: 1px solid #E2E2E2;">@(Model.TheItem.Status)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Priority</strong></td>
<td style="border: 1px solid #E2E2E2;">@(Model.TheItem.Priority)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Component</strong></td>
<td style="border: 1px solid #E2E2E2;">@(Model.TheItem.ComponentNames)</td>
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
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2012-08-01T19:32:32.030', N'{"Subject":""}')
INSERT INTO gemini_alerttemplates([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (3, N'When someone is resourced', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Just to let you know the following <strong>@(Model.TheItem.Type)</strong> in <strong>@(Model.TheItem.ProjectName)</strong> has been assigned to you.</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
<tbody>
<tr>
	<td style="color: #4c4c4c;"><a href="@Html.Raw(Model.ItemUrl(Model.TheItem))">@Model.TheItem.IssueKey - @Model.TheItem.Title</a></td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Type</strong></td>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;">@(Model.TheItem.Type)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Status</strong></td>
<td style="border: 1px solid #E2E2E2;">@(Model.TheItem.Status)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Priority</strong></td>
<td style="border: 1px solid #E2E2E2;">@(Model.TheItem.Priority)</td>
</tr>
<tr>
<td style="color: #4c4c4c; border: 1px solid #E2E2E2;background-color:#f5f5f5;"><strong>Component</strong></td>
<td style="border: 1px solid #E2E2E2;">@(Model.TheItem.ComponentNames)</td>
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
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2012-08-01T19:32:32.030', N'{"Subject":""}')
INSERT INTO gemini_alerttemplates([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (5, N'Confirmation to customer that email has been logged as ticket', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;">Thanks for your email which has been received and a ticket has been opened for you <strong>(@(Model.TheItem.IssueKey)).</strong></td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
<tbody>
<tr>
<td style="color: #4c4c4c;">@Html.Raw(Model.LinkViewItem)</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: whitesmoke; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;"><strong>@(Model.TheItem.Title)</strong></td>
</tr>
		
<tr>
<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;">@Html.Raw(Model.TheItem.Description)</td>
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
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2012-11-05T14:49:32.710', N'{"Subject":""}')
INSERT INTO gemini_alerttemplates([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (6, N'When ticket changes customer is sent an email with details', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c;font-weight:bold;">You have a response to your ticket <a href="@Html.Raw(Model.ItemUrl(Model.TheItem))">@Model.TheItem.IssueKey</a>:</td>
</tr>
<tr>
<td style="color: #4c4c4c;">@Html.Raw(Model.TheItem.LastComment)</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: whitesmoke; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;"><strong>@(Model.TheItem.Title)</strong></td>
</tr>
		
<tr>
<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;">@Html.Raw(Model.ResponseTo)</td>
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
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2012-11-20T14:04:46.710', N'{"Subject":""}')
INSERT INTO gemini_alerttemplates([alerttype], [label], [alertcontent], [projects], [created], [templatedata]) VALUES (8, N'When something is updated', N'<table style="width: 100%; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
   	<tbody>
		<tr>
			<td style="color: #808080;" align="center">--- please reply above this line ---</td>
		</tr>
	</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 16px; font-weight: bold; border: none; background-color: #005682;" cellpadding="20">
<tbody>
<tr>
	<td style="color: #FFFFFF;">Gemini Tracker</td>
</tr>
</tbody>
</table>
<table style="width: 100%; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: white;" cellpadding="10">
<tbody>
<tr>
	<td style="color: #4c4c4c;">Just to let you know the following <strong>@Model.TheItem.Type</strong> has been updated.</td>
</tr>
</tbody>
</table>
<table style="margin-left: 20px; font-family: arial; font-size: 14px; font-weight: normal; border: none; background-color: whitesmoke; border-collapse: collapse;" cellpadding="10">
<tbody>
<tr>
<td style="color: #4c4c4c; border-left: 3px solid #ebebeb;"><a href="@Html.Raw(Model.ItemUrl(Model.TheItem))">@Model.TheItem.IssueKey - @Model.TheItem.Title</a></td>
</tr>
</tbody>
</table>
<table style="margin-left: 40px; font-family: arial; font-size: 13px; font-weight: normal; border: none; background-color: white; border-collapse: collapse;" cellpadding="5">
<tbody>
	@foreach(var change in Model.TheItem.ChangeLog)
	{
<tr>
	<td><strong>@change.Field</strong> @change.Change</td>
</tr>
	}
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
<tr><td><br/></td></tr>
<tr>
	<td style="color: #005682;" align="center"><a style="text-decoration:none;" href="http://www.countersoft.com">Powered by Countersoft Gemini</a></td>
</tr>
</tbody>
</table>', N'', '2013-05-02T16:13:20.310', N'{"Subject":""}')
GO
