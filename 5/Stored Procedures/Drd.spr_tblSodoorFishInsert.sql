SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSodoorFishInsert]
 
    @fldId  int output,
    @fldElamAvarezId int,
    @fldShomareHesabId int,
    @fldMablaghAvarezGerdShode bigint,
    @fldShorooShenaseGhabz tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldJamKol bigint
AS 
	
	BEGIN TRAN

	set  @fldDesc=com.fn_TextNormalize(@fldDesc)

	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblSodoorFish] 
	INSERT INTO [Drd].[tblSodoorFish] ([fldId], [fldElamAvarezId], [fldShomareHesabId], [fldShenaseGhabz],fldShenasePardakht ,[fldMablaghAvarezGerdShode], [fldShorooShenaseGhabz] , [fldUserId], [fldDesc], [fldDate],fldJamKol,fldBarcode,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent)
	SELECT @fldId, @fldElamAvarezId, @fldShomareHesabId, '','' ,@fldMablaghAvarezGerdShode, @fldShorooShenaseGhabz,   @fldUserId, @fldDesc, GETDATE(),@fldJamKol,'',0,0,NULL,NULL
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
