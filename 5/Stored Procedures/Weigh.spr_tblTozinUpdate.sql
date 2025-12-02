SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblTozinUpdate] 
    @fldId int,
    @fldWeighbridgeId int,
    @fldMaxW int,
    @fldPlaqueId int,
    @fldHour datetime,
    @fldStartDate datetime,
    @fldEndDate datetime
   
AS 

	BEGIN TRAN

	UPDATE [Weigh].[tblTozin]
	SET    [fldWeighbridgeId] = @fldWeighbridgeId, [fldMaxW] = @fldMaxW, [fldPlaqueId] = @fldPlaqueId, [fldHour] = @fldHour, [fldStartDate] = @fldStartDate, [fldEndDate] = @fldEndDate, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
