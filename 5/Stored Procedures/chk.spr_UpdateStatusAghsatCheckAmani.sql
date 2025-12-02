SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [chk].[spr_UpdateStatusAghsatCheckAmani] 
    @fldId int,
    @fldTarikhPardakht nvarchar(10), 
    @fldVaziat TINYINT,
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [chk].[tblAghsatCheckAmani]
	SET    [fldId] = @fldId,  [fldTarikhPardakht] = @fldTarikhPardakht, [fldVaziat] = @fldVaziat , [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
