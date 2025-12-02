SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhasSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	   ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
	
		FROM   [com].[tblAshkhas] 
	WHERE  Com.tblAshkhas.fldId = @Value
	  
	if (@fieldname=N'fldHaghighiId')
SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
	WHERE  fldHaghighiId = @Value

	if (@fieldname=N'fldHoghoghiId')
SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
	WHERE  fldHoghoghiId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
	WHERE  Com.tblAshkhas.fldDesc like @Value

	if (@fieldname=N'fldName')
	BEGIN 
		IF(@Value1=0)
		SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  Name like @Value AND t.fldHaghighiId IS NOT NULL
		
IF(@Value1=1)
		SELECT top(@h) * from(SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  Name like @Value AND t.fldHoghoghiId IS NOT NULL
ELSE
	SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  Name like @Value
		
	END 

if (@fieldname=N'fldFamily')
	BEGIN 
		IF(@Value1=0)
		SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  fldFamily like @Value AND t.fldHaghighiId IS NOT NULL
		
IF(@Value1=1)
		SELECT top(@h) * from(SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  fldFamily like @Value AND t.fldHoghoghiId IS NOT NULL
ELSE
	SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  fldFamily like @Value
		
	END 

	if (@fieldname=N'fldName')
	BEGIN 
		IF(@Value1=0)
		SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	   ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  fldName like @Value AND t.fldHaghighiId IS NOT NULL
		
IF(@Value1=1)
		SELECT top(@h) * from(SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	   ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  fldName like @Value AND t.fldHoghoghiId IS NOT NULL
ELSE
	SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  fldName like @Value
		
	END 


	
		if (@fieldname=N'fldShenase_CodeMeli')
	BEGIN 
		IF(@Value1='0')
		begin
		SELECT top(@h) * from(SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  fldShenase_CodeMeli like @Value AND t.fldHaghighiId IS NOT NULL
		end
else IF(@Value1='1')
begin
		SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  fldShenase_CodeMeli like @Value	AND t.fldHoghoghiId IS NOT NULL	
		end
ELSE
begin
	SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  fldShenase_CodeMeli like @Value		
		
	END 
end

	if (@fieldname=N'shomareshabt_father')
	BEGIN 
		IF(@Value1='0')
		begin
		SELECT top(@h) * from(SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	   ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  shomareshabt_father like @Value AND t.fldHaghighiId IS NOT NULL
		end
else IF(@Value1='1')
begin
		SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	   ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
) as t
		WHERE  shomareshabt_father like @Value	AND t.fldHoghoghiId IS NOT NULL	
		end
ELSE
begin
	SELECT top(@h) * from(	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	   ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
 ) as t
		WHERE  shomareshabt_father like @Value		
		
	END 
end
	
	if (@fieldname=N'fldNoeShakhs')
begin
		IF(@Value1='0')
		begin
		SELECT top(@h) * from (	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] )as t
		WHERE  NoeShakhs like @Value AND t.fldHaghighiId IS NOT NULL
		end
		IF(@Value1='1')
		begin
		SELECT top(@h) * from (	SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] )as t
		WHERE  NoeShakhs like @Value AND t.fldHoghoghiId IS NOT NULL
		end		
ELSE
begin
SELECT top(@h) * from (SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] )as t
		WHERE  NoeShakhs like @Value		
end	
	END	

	
if (@fieldname=N'Haghighi_Hoghoghi')
	BEGIN 
	IF(@Value1=0)
	BEGIN
	SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 

		WHERE fldHaghighiId IS NOT NULL
		end
	IF(@Value1=1)
	BEGIN
SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 

		WHERE  fldHoghoghiId IS NOT NULL
		end
	ELSE
SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 

		
	END 




	if (@fieldname=N'')
SELECT top(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when  fldHoghoghiId is not null  then  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) when fldHoghoghiId is not null  then com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) end ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) as Name,case when fldHaghighiId is not null then N'حقیقی' when fldHoghoghiId is not null then N'حقوقی' end as NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,case when  fldHoghoghiId is not null then (select fldShomareSabt from com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId ) when fldHaghighiId is not null then (select fldFatherName from com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId) end as shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (select fldName from Com.tblAshkhaseHoghoghi where Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL then (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress
		 
		FROM   [com].[tblAshkhas] 
		
		
	
		
	IF (@fieldname=N'haghighi_khososi')
	
SELECT TOP(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN  fldHoghoghiId IS NOT NULL  THEN  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN fldHoghoghiId IS NOT NULL  THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) END ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) AS Name,CASE WHEN fldHaghighiId IS NOT NULL THEN N'حقیقی' WHEN fldHoghoghiId IS NOT NULL THEN N'حقوقی' END AS NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,CASE WHEN  fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId ) WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) END AS shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress,
		 ( CASE WHEN Com.tblEmployee.fldStatus=1 THEN N'خصوصی' END)AS fldHaghighi_khososi
	
		FROM   [com].[tblAshkhas] INNER JOIN Com.tblEmployee
		ON tblEmployee.fldId = tblAshkhas.fldHaghighiId 	
	WHERE Com.tblEmployee.fldStatus=1  	
    

		
	
		
	IF (@fieldname=N'fldName_haghighi_khososi')
SELECT TOP(@h) * FROM (SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN  fldHoghoghiId IS NOT NULL  THEN  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN fldHoghoghiId IS NOT NULL  THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) END ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) AS Name,CASE WHEN fldHaghighiId IS NOT NULL THEN N'حقیقی' WHEN fldHoghoghiId IS NOT NULL THEN N'حقوقی' END AS NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,CASE WHEN  fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId ) WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) END AS shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	  ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress,
		 ( CASE WHEN Com.tblEmployee.fldStatus=1 THEN N'خصوصی' END)AS fldHaghighi_khososi
	
		FROM   [com].[tblAshkhas] INNER JOIN Com.tblEmployee
		ON tblEmployee.fldId = tblAshkhas.fldHaghighiId 	
	WHERE Com.tblEmployee.fldStatus=1)t
	where    t.fldName LIKE @value



		
	IF (@fieldname=N'fldFamily_haghighi_khososi')
SELECT TOP(@h) [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN  fldHoghoghiId IS NOT NULL  THEN  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN fldHoghoghiId IS NOT NULL  THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) END ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) AS Name,CASE WHEN fldHaghighiId IS NOT NULL THEN N'حقیقی' WHEN fldHoghoghiId IS NOT NULL THEN N'حقوقی' END AS NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,CASE WHEN  fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId ) WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) END AS shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress,
		 ( CASE WHEN Com.tblEmployee.fldStatus=1 THEN N'خصوصی' END)AS fldHaghighi_khososi
	
		FROM   [com].[tblAshkhas] INNER JOIN Com.tblEmployee
		ON tblEmployee.fldId = tblAshkhas.fldHaghighiId 	
	WHERE Com.tblEmployee.fldStatus=1 AND fldFamily LIKE @value  

		
	IF (@fieldname=N'fldShenase_CodeMeli_haghighi_khososi')
	
SELECT TOP(@h)* FROM (SELECT  [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN  fldHoghoghiId IS NOT NULL  THEN  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN fldHoghoghiId IS NOT NULL  THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) END ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) AS Name,CASE WHEN fldHaghighiId IS NOT NULL THEN N'حقیقی' WHEN fldHoghoghiId IS NOT NULL THEN N'حقوقی' END AS NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,CASE WHEN  fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId ) WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) END AS shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress,
		 ( CASE WHEN Com.tblEmployee.fldStatus=1 THEN N'خصوصی' END)AS fldHaghighi_khososi
	
		FROM   [com].[tblAshkhas] INNER JOIN Com.tblEmployee
		ON tblEmployee.fldId = tblAshkhas.fldHaghighiId 	
	WHERE Com.tblEmployee.fldStatus=1  )t
	WHERE t.fldShenase_CodeMeli LIKE @Value


	IF (@fieldname=N'shomareshabt_father_haghighi_khososi')
SELECT TOP(@h) * FROM (SELECT [com].[tblAshkhas].[fldId], [com].[tblAshkhas].[fldHaghighiId], [fldHoghoghiId], [com].[tblAshkhas].[fldUserId], [com].[tblAshkhas].[fldDesc], [com].[tblAshkhas].[fldDate]
,ISNULL(CASE WHEN fldHaghighiId IS NOT NULL THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN  fldHoghoghiId IS NOT NULL  THEN  com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) WHEN fldHoghoghiId IS NOT NULL  THEN com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId) END ,com.fn_NameAshkhasHaghighi_Hoghoghi([com].[tblAshkhas].fldId)) AS Name,CASE WHEN fldHaghighiId IS NOT NULL THEN N'حقیقی' WHEN fldHoghoghiId IS NOT NULL THEN N'حقوقی' END AS NoeShakhs  
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldid=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) END AS fldShenase_CodeMeli
		,CASE WHEN  fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId ) WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) END AS shomareshabt_father
		,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId)  
		 ELSE (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE Com.tblAshkhaseHoghoghi.fldId=fldHoghoghiId) END fldName
	 ,ISNULL((CASE WHEN fldHaghighiId IS NOT NULL then (SELECT ISNULL(fldSh_Shenasname,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) when fldHoghoghiId is not null  THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail WHERE fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldSh_Shenasname
	  ,CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldHaghighiId) ELSE N'_' END fldFamily, 
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldCodePosti,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldCodePosti,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN N'_' ELSE (SELECT ISNULL(fldShomareTelephone,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldShomareTelephone,
		ISNULL((CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT ISNULL(fldAddress,N'_') FROM Com.tblEmployee_Detail WHERE Com.tblEmployee_Detail.fldEmployeeId=fldHaghighiId) ELSE (SELECT ISNULL(fldAddress,N'_') FROM Com.tblAshkhaseHoghoghi_Detail WHERE Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId=fldHoghoghiId) END),N'_') AS fldAddress,
		 ( CASE WHEN Com.tblEmployee.fldStatus=1 THEN N'خصوصی' END)AS fldHaghighi_khososi
	
		FROM   [com].[tblAshkhas] INNER JOIN Com.tblEmployee
		ON tblEmployee.fldId = tblAshkhas.fldHaghighiId 	
	WHERE Com.tblEmployee.fldStatus=1 )t
	WHERE t.shomareshabt_father LIKE @Value


	COMMIT
GO
