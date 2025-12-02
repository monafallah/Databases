SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblMahiyatInsert] 
    
    @fldTitle nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblMahiyat] 
	INSERT INTO [ACC].[tblMahiyat] ([fldId], [fldTitle], [fldDesc], [fldDate], [fldIp], [fldUserId])
	SELECT @fldId, @fldTitle, @fldDesc, GETDATE(), @fldIp, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
