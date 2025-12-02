SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblInsuranceWorkshopInsert] 
    
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
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldWorkShopName=Com.fn_TextNormalize(@fldWorkShopName)
	SET @fldEmployerName=Com.fn_TextNormalize(@fldEmployerName)
	SET @fldWorkShopNum=Com.fn_TextNormalize(@fldWorkShopNum)
	SET @fldAddress=Com.fn_TextNormalize(@fldAddress)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblInsuranceWorkshop] 
	INSERT INTO [Pay].[tblInsuranceWorkshop] ([fldId], [fldWorkShopName], [fldEmployerName], [fldWorkShopNum], [fldPersent], [fldAddress], [fldPeyman], [fldUserId], [fldDate], [fldDesc],fldOrganId)
	SELECT @fldId, @fldWorkShopName, @fldEmployerName, @fldWorkShopNum, @fldPersent, @fldAddress, @fldPeyman, @fldUserId, GETDATE(), @fldDesc,@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
