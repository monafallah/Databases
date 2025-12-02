SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailPayeSanavatiUpdate] 
    @fldId int,
    @fldPayeSanavatiId int,
    @fldGroh tinyint,
    @fldMablagh int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblDetailPayeSanavati]
	SET    [fldId] = @fldId, [fldPayeSanavatiId] = @fldPayeSanavatiId, [fldGroh] = @fldGroh, [fldMablagh] = @fldMablagh, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
