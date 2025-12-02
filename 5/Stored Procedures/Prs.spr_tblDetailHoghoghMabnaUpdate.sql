SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailHoghoghMabnaUpdate] 
    @fldId int,
    @fldHoghoghMabnaId int,
    @fldGroh tinyint,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblDetailHoghoghMabna]
	SET    [fldId] = @fldId, [fldHoghoghMabnaId] = @fldHoghoghMabnaId, [fldGroh] = @fldGroh, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
