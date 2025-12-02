SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabPasAndazInsert] 
    @fldShomareHesabPersonalId int,
    @fldShomareHesabKarfarmaId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblShomareHesabPasAndaz] 
	INSERT INTO [Pay].[tblShomareHesabPasAndaz] ([fldId], [fldShomareHesabPersonalId], [fldShomareHesabKarfarmaId], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldShomareHesabPersonalId, @fldShomareHesabKarfarmaId, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
