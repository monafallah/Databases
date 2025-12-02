SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghi_DetailInsert] 

    @fldMoteghayerhayeHoghoghiId int,
    @fldItemEstekhdamId int,
	@fldMazayaMashmool bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMoteghayerhayeHoghoghi_Detail] 
	INSERT INTO [Pay].[tblMoteghayerhayeHoghoghi_Detail] ([fldId], [fldMoteghayerhayeHoghoghiId], [fldItemEstekhdamId],fldMazayaMashmool,[fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldMoteghayerhayeHoghoghiId, @fldItemEstekhdamId,@fldMazayaMashmool, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
