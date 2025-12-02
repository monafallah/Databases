SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationDelete] 
	@fldID int,
	@fldUserID int
AS 
	--BEGIN TRy
	DECLARE @fileid INT
	BEGIN TRANSACTION
	SELECT @fileId=fldFileId FROM tblOrganization WHERE fldid=@fldId
	
	UPDATE   [Com].[tblOrganization]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM   [Com].[tblOrganization]
	WHERE  fldId = @fldId
	
	UPDATE    [Com].[tblFile]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM   [Com].[tblFile]
	WHERE  fldId = @fileId
	
	COMMIT
--	END TRY
--		BEGIN CATCH

--    IF @@TRANCOUNT > 0
--	BEGIN
--	PRINT('rollback')
--        ROLLBACK
--	end
--END CATCH
GO
