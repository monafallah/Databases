SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblZirListHaDelete] 
	@fieldName NVARCHAR(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	IF(@fieldName='fldId')
	BEGIN
		UPDATE  [Com].[tblZirListHa]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		DELETE
		FROM   [Com].[tblZirListHa]
		WHERE  fldId = @fldId
	end
	IF(@fieldName='fldMasuolinId')
	BEGIN
	UPDATE  [Com].[tblZirListHa]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldMasuolin_DetailId = @fldId
	DELETE
	FROM   [Com].[tblZirListHa]
	WHERE  fldMasuolin_DetailId = @fldId
	END 
	COMMIT
GO
