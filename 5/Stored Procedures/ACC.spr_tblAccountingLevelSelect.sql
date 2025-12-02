SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblAccountingLevelSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
	WHERE  a.fldId = @Value AND fldOrganId=@fldOrganId and a.fldId=l.fldid 

	if (@fieldname=N'fldDesc')
	SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
	WHERE fldDesc like  @Value AND fldOrganId=@fldOrganId and a.fldId=l.fldid 

	if (@fieldname=N'fldYear')
	SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
	WHERE fldYear like  @Value AND fldOrganId=@fldOrganId and a.fldId=l.fldid 

	if (@fieldname=N'fldYear_AccountLevel')
	SELECT top(@h) * FROM (SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
	WHERE fldYear like  @Value AND fldOrganId=@fldOrganId and a.fldId=l.fldid 
	)t WHERE  fldLevelId>=@value1


	if (@fieldname=N'fldYear_CodingId')
	BEGIN
		IF (@value1='0')
		SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
		--CROSS APPLY (SELECT fldAccountLevelId FROM acc.tblCoding_Details WHERE fldid=@value1)coding
		WHERE fldYear like  @Value AND fldOrganId=@fldOrganId and a.fldId=l.fldid  --AND fldid>=coding.fldAccountLevelId
		ELSE
		SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
		CROSS APPLY (SELECT fldAccountLevelId FROM acc.tblCoding_Details WHERE fldid=@value1)coding
		WHERE fldYear like  @Value AND fldOrganId=@fldOrganId AND a.fldid>=coding.fldAccountLevelId and a.fldId=l.fldid 
	END
  

	if (@fieldname=N'')
	SELECT  a.[fldId],[fldName], [fldOrganId], [fldYear], [fldArghamNum], [fldDesc], [fldDate], [fldIP], [fldUserId] 
,l.fldLevelId
	FROM   [ACC].[tblAccountingLevel] as a
	cross apply(select fldId,ROW_NUMBER() over (partition by [fldOrganId], [fldYear] order by fldid) fldLevelId from [ACC].[tblAccountingLevel] as l )l
	where fldOrganId=@fldOrganId and a.fldId=l.fldid 

	COMMIT
GO
