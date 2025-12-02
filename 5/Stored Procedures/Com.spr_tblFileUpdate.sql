SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblFileUpdate] 
    @fldId int,
    @fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblFile]
	SET    [fldId] = @fldId, [fldImage] = @fldImage, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldPasvand=@fldPasvand
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
