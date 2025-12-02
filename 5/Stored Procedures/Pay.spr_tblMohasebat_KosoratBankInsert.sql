SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_KosoratBankInsert] 
    @fldMohasebatId int,
    @fldKosoratBankId int,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMohasebat_KosoratBank] 
	INSERT INTO [Pay].[tblMohasebat_KosoratBank] ([fldId], [fldMohasebatId], [fldKosoratBankId], [fldMablagh], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldMohasebatId, @fldKosoratBankId, @fldMablagh, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
