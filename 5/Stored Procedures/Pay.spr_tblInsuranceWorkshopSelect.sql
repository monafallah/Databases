SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblInsuranceWorkshopSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@organId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] as i
	WHERE  fldOrganId = @Value 

if (@fieldname=N'DisketBime')
	SELECT [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop]  as i
	WHERE (exists (select * from pay.tblKarkardMahane_Detail as d inner join pay.tblKarKardeMahane as k on k.fldId=d.fldKarkardMahaneId where d.fldKargahBimeId=i.fldId and k.fldYear=@Value and k.fldMah=@h  )  
	or exists (select * from pay.tblMohasebat_PersonalInfo as d 
inner join pay.tblMohasebat as k on k.fldId=d.fldMohasebatId  where d.fldInsuranceWorkShopId=i.fldId and k.fldYear=@Value and k.fldMonth=@h  )  
	 )
	AND fldOrganId=@organId

	if (@fieldname=N'fldWorkShopName')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldWorkShopName LIKE @Value AND fldOrganId=@organId

	if (@fieldname=N'fldEmployerName')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldEmployerName LIKE @Value AND fldOrganId=@organId

	if (@fieldname=N'fldWorkShopNum')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldWorkShopNum LIKE @Value AND fldOrganId=@organId
	
	if (@fieldname=N'fldPersent')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldPersent LIKE @Value AND fldOrganId=@organId
	
	if (@fieldname=N'fldAddress')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldAddress LIKE @Value AND fldOrganId=@organId

	if (@fieldname=N'fldPeyman')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldPeyman LIKE @Value AND fldOrganId=@organId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldDesc LIKE @Value AND fldOrganId=@organId

	
	if (@fieldname=N'CheckWorkShopNum')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE  fldWorkShopNum LIKE @Value
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 
	WHERE fldOrganId=@organId
	
		if (@fieldname=N'ALL')
	SELECT top(@h) [fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc] ,fldOrganId
	,fldWorkShopName+'_'+fldPeyman  AS fldName
	FROM   [Pay].[tblInsuranceWorkshop] 

	COMMIT

GO
