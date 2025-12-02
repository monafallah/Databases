SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMohdoodiyatMohasebat_UserInsert] 
    
    @fldIdUser int,
    @fldMahdoodiyatMohasebatId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblMohdoodiyatMohasebat_User] 
	INSERT INTO [Drd].[tblMohdoodiyatMohasebat_User] ([fldId], [fldIdUser], [fldMahdoodiyatMohasebatId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldIdUser, @fldMahdoodiyatMohasebatId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
