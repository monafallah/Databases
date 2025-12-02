SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblItemsHoghughiUpdate] 
    @fldId int,
    @fldTypeHesabId tinyint,
	@fldMostamar tinyint,
    @fldUserId int

AS 
	BEGIN TRAN
	UPDATE  [Com].[tblItemsHoghughi]
	SET    fldTypeHesabId = @fldTypeHesabId,fldMostamar=@fldMostamar,fldUserId=@fldUserId,fldDate=GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
