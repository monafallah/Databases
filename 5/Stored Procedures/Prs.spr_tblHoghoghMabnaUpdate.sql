SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHoghoghMabnaUpdate] 
    @fldId int,
    @fldYear int,
    @fldType bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldDesc=Com.fn_TextNormalize(@fldDesc)

	UPDATE [Prs].[tblHoghoghMabna]
	SET    [fldId] = @fldId, [fldYear] = @fldYear, [fldType] = @fldType, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
