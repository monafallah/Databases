SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReferralRulesSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldId=@Value AND r.fldOrganId =@organId

	if (@FieldName='fldDesc')
	
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldDesc like @Value AND r.fldOrganId =@organId

	if (@FieldName='')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId

	if (@FieldName='fldOrganId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	where  r.fldOrganId =@organId
	

	if (@FieldName='fldPostErjaDahandeId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldPostErjaDahandeId like @Value AND r.fldOrganId =@organId


	
	if (@FieldName='fldPostErjaGirandeId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldPostErjaGirandeId like @Value AND r.fldOrganId =@organId

	
	
	if (@FieldName='fldChartEjraeeGirandeId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldChartEjraeeGirandeId like @Value AND r.fldOrganId =@organId

	if (@FieldName='checkPostErjaDahandeId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldPostErjaDahandeId like @Value-- AND r.fldOrganId =@organId


	
	if (@FieldName='checkPostErjaGirandeId')
	SELECT top(@h) r.[fldId], [fldPostErjaDahandeId], [fldPostErjaGirandeId],fldChartEjraeeGirandeId, r.[fldUserId], r.[fldOrganId], r.[fldIP], r.[fldDate], r.[fldDesc] 
	,o1.fldTitle as fldTitleErjaDahande,o2.fldTitle as fldTitleErjaGirande
	FROM   [Auto].[tblReferralRules] r
	inner join com.tblOrganizationalPostsEjraee o1 on o1.fldid=fldPostErjaDahandeId
	left outer join com.tblOrganizationalPostsEjraee o2 on o2.fldid=fldPostErjaGirandeId
	WHERE  r.fldPostErjaGirandeId like @Value --AND r.fldOrganId =@organId

	COMMIT
GO
