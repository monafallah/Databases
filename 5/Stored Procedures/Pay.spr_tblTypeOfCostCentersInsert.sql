SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeOfCostCentersInsert] 
    
    @fldTitle nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblTypeOfCostCenters] 
	INSERT INTO [Pay].[tblTypeOfCostCenters] ([fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldTitle, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
