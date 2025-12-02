SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPatternSharhHokmInsert] 

    @fldPatternText nvarchar(MAX),
    @fldHokmType nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET  @fldPatternText=Com.fn_TextNormalize(@fldPatternText)
	SET  @fldHokmType=Com.fn_TextNormalize(@fldHokmType)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblPatternSharhHokm] 
	INSERT INTO [Prs].[tblPatternSharhHokm] ([fldId], [fldPatternText], [fldHokmType], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldPatternText, @fldHokmType, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
