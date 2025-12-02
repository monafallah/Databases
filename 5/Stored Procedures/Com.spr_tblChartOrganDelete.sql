SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblChartOrganDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [Com].[tblChartOrgan]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 
	DELETE
	FROM   [Com].[tblChartOrgan]
	WHERE  fldId = @fldId

	COMMIT
GO
