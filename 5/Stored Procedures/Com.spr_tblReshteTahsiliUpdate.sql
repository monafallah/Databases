SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblReshteTahsiliUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
		SET @fldTitle=com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblReshteTahsili]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
