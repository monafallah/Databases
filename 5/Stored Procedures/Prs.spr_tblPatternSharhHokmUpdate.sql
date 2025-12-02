SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPatternSharhHokmUpdate] 
    @fldId int,
    @fldPatternText nvarchar(MAX),
    @fldHokmType nvarchar(100),
    @fldUserId int,
     @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblPatternSharhHokm]
	SET    [fldId] = @fldId, [fldPatternText] = @fldPatternText, [fldHokmType] = @fldHokmType, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
