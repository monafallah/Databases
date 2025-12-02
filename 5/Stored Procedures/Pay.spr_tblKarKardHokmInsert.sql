SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardHokmInsert] 

    @fldKarkardId int,
    @fldHokmId int,
    @fldRoze decimal(4,1),
	@fldGheybat decimal(4,1)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblKarKardHokm] 
	INSERT INTO [Pay].[tblKarKardHokm] ([fldId], [fldKarkardId], [fldHokmId], [fldRoze],fldGheybat)
	SELECT @fldId, @fldKarkardId, @fldHokmId, @fldRoze,@fldGheybat
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
