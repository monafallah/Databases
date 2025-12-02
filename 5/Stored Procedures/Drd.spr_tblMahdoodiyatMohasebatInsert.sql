SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebatInsert] 
    @fldId int out,
	@fldTitle nvarchar(200),
    @fldAzTarikh nvarchar(10),
    @fldTatarikh nvarchar(10),
    @fldNoeKarbar bit,
    @fldNoeCodeDaramad bit,
    @fldNoeAshkhas bit,
    @fldStatus bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc) 
	--declare @fldID int 
	select @fldId =ISNULL(max(fldId),0)+1 from [Drd].[tblMahdoodiyatMohasebat] 
	INSERT INTO [Drd].[tblMahdoodiyatMohasebat] ([fldId],[fldTitle], [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId,@fldTitle, @fldAzTarikh, @fldTatarikh, @fldNoeKarbar, @fldNoeCodeDaramad, @fldNoeAshkhas, @fldStatus, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
