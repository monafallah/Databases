SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardHokmUpdate] 
    @fldId int,
    @fldKarkardId int,
    @fldHokmId int,
    @fldRoze decimal(4,1),
	@fldGheybat decimal(4,1)
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblKarKardHokm]
	SET    [fldKarkardId] = @fldKarkardId, [fldHokmId] = @fldHokmId, [fldRoze] = @fldRoze, fldGheybat = @fldGheybat
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
