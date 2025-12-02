SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblDaramadCodeDetails_ACCUpdate] 
    @fldId int,
    @fldCodingAcc_DetailsId int,
    @fldType tinyint,
    @fldTypeID int,
    @fldPercentHazine decimal(4, 2),
    @fldPercentTamallok decimal(4, 2),
    @fldUserId int,
    @fldIp varchar(15)
AS 
	BEGIN TRAN
	UPDATE [BUD].[tblDaramadCodeDetails_ACC]
	SET    [fldCodingAcc_DetailsId] = @fldCodingAcc_DetailsId, [fldType] = @fldType, [fldTypeID] = @fldTypeID,  [fldUserId] = @fldUserId, [fldIp] = @fldIp, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
