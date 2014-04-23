IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_customfieldusage') DROP TABLE gemini_customfieldusage
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_fieldvisibilityschemeitemgroups') DROP TABLE gemini_fieldvisibilityschemeitemgroups
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_fieldvisibilityschemeitems') DROP TABLE gemini_fieldvisibilityschemeitems
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_fieldvisibilityschemes') DROP TABLE gemini_fieldvisibilityschemes
GO

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_globalgroupmembership') DROP TABLE gemini_globalgroupmembership
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_globalgroups') DROP TABLE gemini_globalgroups
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuealerts') DROP TABLE gemini_issuealerts
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuehistory') DROP TABLE gemini_issuehistory
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuepriorityschemeitems') DROP TABLE gemini_issuepriorityschemeitems 
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuepriorityschemes') DROP TABLE gemini_issuepriorityschemes 
GO

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueseverityschemeitems') DROP TABLE gemini_issueseverityschemeitems
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueseverityschemes') DROP TABLE gemini_issueseverityschemes
GO

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_converse_mailboxprocessor_string') DROP TABLE gemini_converse_mailboxprocessor_string
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_converse_mailboxprocessor_message') DROP TABLE gemini_converse_mailboxprocessor_message
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_mailboxprocessor') DROP TABLE gemini_mailboxprocessor
GO

IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuetypeschemeitems') DROP TABLE gemini_issuetypeschemeitems 
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issuetypeschemes') DROP TABLE gemini_issuetypeschemes 
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueworkflowitemtransition') DROP TABLE gemini_issueworkflowitemtransition
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueworkflowitemgroup') DROP TABLE gemini_issueworkflowitemgroup
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueworkflowitem') DROP TABLE gemini_issueworkflowitem
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_issueworkflow') DROP TABLE gemini_issueworkflow
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_projectresources') DROP TABLE gemini_projectresources
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_reportsvisibility') DROP TABLE gemini_reportsvisibility
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_savedreports') DROP TABLE gemini_savedreports
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_reports') DROP TABLE gemini_reports
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_usersettings') DROP TABLE gemini_usersettings
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_watchproject') DROP TABLE gemini_watchproject
GO
IF EXISTS(SELECT name FROM sysobjects WHERE name='gemini_personalfilters') DROP TABLE gemini_personalfilters
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_averageissueagebycomponent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_averageissueagebycomponent]
GO

/****** Object:  StoredProcedure [gemini_createusersetting]    Script Date: 08/01/2012 13:38:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_createusersetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_createusersetting]
GO

/****** Object:  StoredProcedure [gemini_deleteissuetimetype]    Script Date: 08/01/2012 13:38:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_deleteissuetimetype]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_deleteissuetimetype]
GO

/****** Object:  StoredProcedure [gemini_deletemessages]    Script Date: 08/01/2012 13:38:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_deletemessages]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_deletemessages]
GO

/****** Object:  StoredProcedure [gemini_deleteproject]    Script Date: 08/01/2012 13:38:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_deleteproject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_deleteproject]
GO

/****** Object:  StoredProcedure [gemini_deleteprojectattributes]    Script Date: 08/01/2012 13:38:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_deleteprojectattributes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_deleteprojectattributes]
GO

/****** Object:  StoredProcedure [gemini_getallissuelinks]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallissuelinks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallissuelinks]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummary]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummary]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbypriority]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbypriority]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbypriority]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbypriorityw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbypriorityw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbypriorityw]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbyresolution]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbyresolution]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbyresolution]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbyresolutionw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbyresolutionw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbyresolutionw]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbyresource]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbyresource]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbyresource]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbyresourcew]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbyresourcew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbyresourcew]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbyseverity]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbyseverity]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbyseverity]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbyseverityw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbyseverityw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbyseverityw]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbystatus]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbystatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbystatus]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbystatusw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbystatusw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbystatusw]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbytype]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbytype]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbytype]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryissuesbytypew]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryissuesbytypew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryissuesbytypew]
GO

/****** Object:  StoredProcedure [gemini_getallprojectsummaryw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getallprojectsummaryw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getallprojectsummaryw]
GO

/****** Object:  StoredProcedure [gemini_getcreateissuelookups]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getcreateissuelookups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getcreateissuelookups]
GO

/****** Object:  StoredProcedure [gemini_geteditissuelookups]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_geteditissuelookups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_geteditissuelookups]
GO

/****** Object:  StoredProcedure [gemini_getissuefilterlookups]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getissuefilterlookups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getissuefilterlookups]
GO

/****** Object:  StoredProcedure [gemini_getissuereportersforallprojects]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getissuereportersforallprojects]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getissuereportersforallprojects]
GO

/****** Object:  StoredProcedure [gemini_getissuetimespent]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getissuetimespent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getissuetimespent]
GO

/****** Object:  StoredProcedure [gemini_getissuetimespentasminutes]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getissuetimespentasminutes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getissuetimespentasminutes]
GO

/****** Object:  StoredProcedure [gemini_getissuewatcherusersummary]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getissuewatcherusersummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getissuewatcherusersummary]
GO

/****** Object:  StoredProcedure [gemini_getlatestmessages]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getlatestmessages]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getlatestmessages]
GO

/****** Object:  StoredProcedure [gemini_getmessages]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getmessages]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getmessages]
GO

/****** Object:  StoredProcedure [gemini_getprojectaverageissueagebytype]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectaverageissueagebytype]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectaverageissueagebytype]
GO

/****** Object:  StoredProcedure [gemini_getprojectissueagebycomponent]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectissueagebycomponent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectissueagebycomponent]
GO

/****** Object:  StoredProcedure [gemini_getprojectissuesagebytype]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectissuesagebytype]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectissuesagebytype]
GO

/****** Object:  StoredProcedure [gemini_getprojectissuesagebytypebyweek]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectissuesagebytypebyweek]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectissuesagebytypebyweek]
GO

/****** Object:  StoredProcedure [gemini_getprojectissuesagebytypetwelveweek]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectissuesagebytypetwelveweek]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectissuesagebytypetwelveweek]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummary]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummary]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummarycomponents]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummarycomponents]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummarycomponents]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummarycomponentsreport]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummarycomponentsreport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummarycomponentsreport]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummarycomponentsw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummarycomponentsw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummarycomponentsw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryfutureversions]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryfutureversions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryfutureversions]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryfutureversionsw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryfutureversionsw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryfutureversionsw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbypriority]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbypriority]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbypriority]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbypriorityw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbypriorityw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbypriorityw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyresolution]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyresolution]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyresolution]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyresolutionw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyresolutionw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyresolutionw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyresource]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyresource]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyresource]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyresourcew]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyresourcew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyresourcew]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyrisklevel]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyrisklevel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyrisklevel]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyrisklevelw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyrisklevelw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyrisklevelw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyseverity]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyseverity]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyseverity]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbyseverityw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbyseverityw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbyseverityw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbystatus]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbystatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbystatus]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbystatusw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbystatusw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbystatusw]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbytype]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbytype]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbytype]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryissuesbytypew]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryissuesbytypew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryissuesbytypew]
GO

/****** Object:  StoredProcedure [gemini_getprojectsummaryw]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojectsummaryw]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojectsummaryw]
GO

/****** Object:  StoredProcedure [gemini_getprojecttimespent]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getprojecttimespent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getprojecttimespent]
GO

/****** Object:  StoredProcedure [gemini_getresourceissuetimespent]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getresourceissuetimespent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getresourceissuetimespent]
GO

/****** Object:  StoredProcedure [gemini_getstats]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getstats]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getstats]
GO

/****** Object:  StoredProcedure [gemini_getusersforissuealert]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getusersforissuealert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getusersforissuealert]
GO

/****** Object:  StoredProcedure [gemini_getusertimedata]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_getusertimedata]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_getusertimedata]
GO

/****** Object:  StoredProcedure [gemini_issueagebycomponentbytwelveweek]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_issueagebycomponentbytwelveweek]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_issueagebycomponentbytwelveweek]
GO

/****** Object:  StoredProcedure [gemini_issueagebycomponentbyweek]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_issueagebycomponentbyweek]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_issueagebycomponentbyweek]
GO

/****** Object:  StoredProcedure [gemini_logmessage]    Script Date: 08/01/2012 13:38:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gemini_logmessage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [gemini_logmessage]
GO



/****** Object:  View [gemini_issueresolutionfinal]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[gemini_issueresolutionfinal]'))
DROP VIEW [gemini_issueresolutionfinal]
GO

/****** Object:  View [gemini_issuestatusfinal]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[gemini_issuestatusfinal]'))
DROP VIEW [gemini_issuestatusfinal]
GO

/****** Object:  View [gemini_issuestatusunassigned]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[gemini_issuestatusunassigned]'))
DROP VIEW [gemini_issuestatusunassigned]
GO

/****** Object:  View [issueresolutionfinal]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[issueresolutionfinal]'))
DROP VIEW [issueresolutionfinal]
GO

/****** Object:  View [issuestatusfinal]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[issuestatusfinal]'))
DROP VIEW [issuestatusfinal]
GO

/****** Object:  View [issuestatusunassigned]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[issuestatusunassigned]'))
DROP VIEW [issuestatusunassigned]
GO

/****** Object:  View [issuesview]    Script Date: 08/01/2012 13:39:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[issuesview]'))
DROP VIEW [issuesview]
GO

/*
delete from gemini_testing_history
delete from gemini_testing_customdata
delete from gemini_testing_attachments
delete from gemini_testing_run_steps
delete from gemini_testing_run_cases
delete from gemini_testing_case_issues
delete from gemini_testing_plan_cases
delete from gemini_testing_case_steps
delete from gemini_testing_cases
delete from gemini_testing_runs
delete from gemini_testing_plans
*/


