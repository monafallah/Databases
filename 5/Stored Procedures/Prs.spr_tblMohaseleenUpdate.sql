SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMohaseleenUpdate] 
    @fldId int,
    @fldAfradTahtePoosheshId int,
    @fldTarikh int,
    @fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Prs].[tblMohaseleen]
	SET    [fldAfradTahtePoosheshId] = @fldAfradTahtePoosheshId, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
