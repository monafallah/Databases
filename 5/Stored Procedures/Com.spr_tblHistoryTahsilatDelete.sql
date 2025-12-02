SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblHistoryTahsilatDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	update    [Com].[tblHistoryTahsilat] set fldUserId = @fldUserId,  [fldDate] =  GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Com].[tblHistoryTahsilat]
	WHERE  fldId = @fldId

	COMMIT
GO
