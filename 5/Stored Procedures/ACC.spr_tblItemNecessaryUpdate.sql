SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblItemNecessaryUpdate] 
    @fldId int,
    
    @fldNameItem nvarchar(100),
    @fldMahiyatId int,
		@fldTypeHesabId tinyint,
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int,
	@fldMahiyat_GardeshId int
AS 
	BEGIN TRAN
	SET @fldNameItem=Com.fn_TextNormalize(@fldNameItem)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblItemNecessary]
	SET    [fldId] = @fldId,  [fldNameItem] = @fldNameItem,fldTypeHesabId=@fldTypeHesabId, [fldMahiyatId] = @fldMahiyatId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId
	,fldMahiyat_GardeshId =@fldMahiyat_GardeshId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
