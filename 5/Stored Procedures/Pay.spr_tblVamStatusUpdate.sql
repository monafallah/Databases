SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblVamStatusUpdate] 
    @fldId int,
    @fldStatus bit,
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblVam]
	SET     [fldStatus] = @fldStatus
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
