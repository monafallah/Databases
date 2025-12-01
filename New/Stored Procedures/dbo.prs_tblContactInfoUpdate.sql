SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContactInfoUpdate] 
    @fldId int,
    @fldType tinyint,
    @fldMatn nvarchar(MAX),
    @fldInputId int
AS 
	 
	
	BEGIN TRAN
	set @fldMatn=[dbo].[fn_TextNormalize](@fldMatn)
	UPDATE [dbo].[tblContactInfo]
	SET    [fldType] = @fldType, [fldMatn] = @fldMatn, [fldInputId] = @fldInputId, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
