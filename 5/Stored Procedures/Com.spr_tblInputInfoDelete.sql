SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblInputInfoDelete] 
	@fldID int,
	@fldUserID INT

AS 
	BEGIN TRAN
	DELETE
	FROM   [dbo].[tblInputInfo]
	WHERE  fldId = @fldId

	COMMIT
GO
