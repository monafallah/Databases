SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFileSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldBankId], [fldFileName], [fldDateSendFile], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPardakhtFile] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldFileName')
	SELECT top(@h) [fldId], [fldBankId], [fldFileName], [fldDateSendFile], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPardakhtFile] 
	WHERE  fldFileName like @Value

	if (@fieldname=N'fldBankId')
	SELECT top(@h) [fldId], [fldBankId], [fldFileName], [fldDateSendFile], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPardakhtFile] 
	WHERE  fldBankId = @Value

    if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldBankId], [fldFileName], [fldDateSendFile], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPardakhtFile] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldBankId], [fldFileName], [fldDateSendFile], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPardakhtFile] 


	/*if (@fieldname=N'NotMapArtikl')
	SELECT top(@h) [tblPardakhtFile].[fldId], [fldBankId], [fldFileName], [fldDateSendFile], [tblPardakhtFile].[fldUserId], [tblPardakhtFile].[fldDesc], [tblPardakhtFile].[fldDate] 
	FROM   [Drd].[tblPardakhtFile] 
	inner join tblPardakhtFiles_Detail p on p.fldPardakhtFileId=[tblPardakhtFile].fldid
	inner join tblPardakhtfish f on f.fldPardakhtFiles_DetailId=p.fldid
	inner join tblSodoorFish s on s.fldid=fldFishId
	where  not exists (select * from acc.tblArtiklMap where fldPardakhFileId=[tblPardakhtFile].fldid)
	and fldShomareHesabId=@value 
	group by  [tblPardakhtFile].[fldId], [fldBankId], [fldFileName], [fldDateSendFile], [tblPardakhtFile].[fldUserId], [tblPardakhtFile].[fldDesc], [tblPardakhtFile].[fldDate] 
	*/
	COMMIT
GO
