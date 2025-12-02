SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblInsuranceWorkshopUpdate] 
    @fldId int,
    @fldWorkShopName nvarchar(100),
    @fldEmployerName nvarchar(100),
    @fldWorkShopNum nvarchar(10),
    @fldPersent decimal(8, 4),
    @fldAddress nvarchar(MAX),
    @fldPeyman nvarchar(3),
    @fldOrganId INT,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldWorkShopName=Com.fn_TextNormalize(@fldWorkShopName)
	SET @fldEmployerName=Com.fn_TextNormalize(@fldEmployerName)
	SET @fldWorkShopNum=Com.fn_TextNormalize(@fldWorkShopNum)
	SET @fldAddress=Com.fn_TextNormalize(@fldAddress)
	UPDATE [Pay].[tblInsuranceWorkshop]
	SET    [fldId] = @fldId, [fldWorkShopName] = @fldWorkShopName, [fldEmployerName] = @fldEmployerName, [fldWorkShopNum] = @fldWorkShopNum, [fldPersent] = @fldPersent, [fldAddress] = @fldAddress, [fldPeyman] = @fldPeyman, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,fldOrganId=@fldOrganId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
