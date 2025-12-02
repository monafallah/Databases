SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolin_DetailDelete] 
	@fieldname nvarchar(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	IF(@fieldname=N'Header')
	BEGIN
		UPDATE   Com.tblZirListHa
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldMasuolin_DetailId IN (SELECT fldId FROM Com.tblMasuolin_Detail WHERE fldMasuolinId=@fldID)
		DELETE FROM Com.tblZirListHa
		WHERE fldMasuolin_DetailId IN (SELECT fldId FROM Com.tblMasuolin_Detail WHERE fldMasuolinId=@fldID)
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK 
			SET @flag=1
		END
		IF(@flag=0)
		BEGIN
			UPDATE   [Com].[tblMasuolin_Detail]
			SET fldUserId=@fldUserId , flddate=GETDATE()
			WHERE  fldMasuolinId = @fldId
			DELETE FROM   [Com].[tblMasuolin_Detail]
			WHERE  fldMasuolinId = @fldId
		END								
	end
	IF(@fieldname=N'Detail')
	BEGIN
			UPDATE   Com.tblZirListHa
			SET fldUserId=@fldUserId , flddate=GETDATE()
			WHERE fldMasuolin_DetailId=@fldID
			DELETE FROM Com.tblZirListHa
			WHERE fldMasuolin_DetailId=@fldID
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK 
			SET @flag=1
		END
		IF(@flag=0)
		BEGIN
			UPDATE   [Com].[tblMasuolin_Detail]
			SET fldUserId=@fldUserId , flddate=GETDATE()
			WHERE  fldId = @fldId
			DELETE FROM   [Com].[tblMasuolin_Detail]
			WHERE  fldId = @fldId
		end
	end
	COMMIT
GO
