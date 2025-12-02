SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolinDelete] 
	@fldID int,
	@fldUserID int
AS 

	--BEGIN TRY
	BEGIN TRANSACTION
		UPDATE   [Com].[tblMasuolin_Detail]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldid=@fldID
		DELETE
		FROM   [Com].[tblMasuolin_Detail]
		WHERE  fldMasuolinId = @fldId
		
		UPDATE   [Com].[tblMasuolin]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldid=@fldID
		DELETE
		FROM   [Com].[tblMasuolin]
		WHERE  fldId = @fldId

	COMMIT
	--	END TRY
	--BEGIN CATCH
	--IF @@TRANCOUNT>0
	--BEGIN
	--ROLLBACK
	--PRINT('ROLLBACK')
	--END 
	--END CATCH
GO
