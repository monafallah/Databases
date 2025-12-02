SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_ShomareHesabDaramadInsert] 

    @fldMahdodiyatMohasebatId int,
    @fldShomarehesabDarmadId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] 
	INSERT INTO [Drd].[tblMahdoodiyatMohasebat_ShomareHesabDaramad] ([fldId], [fldMahdodiyatMohasebatId], [fldShomarehesabDarmadId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldMahdodiyatMohasebatId, @fldShomarehesabDarmadId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
