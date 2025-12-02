SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_AshkhasInsert] 
    
    @fldMahdoodiyatMohasebatId int,
    @fldAshkhasId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblMahdoodiyatMohasebat_Ashkhas] 
	INSERT INTO [Drd].[tblMahdoodiyatMohasebat_Ashkhas] ([fldId], [fldMahdoodiyatMohasebatId], [fldAshkhasId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldMahdoodiyatMohasebatId, @fldAshkhasId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
