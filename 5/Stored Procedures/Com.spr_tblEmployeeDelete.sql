SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployeeDelete] 
	@fldID int,
	@fldUserID int
AS 
	--BEGIN TRy
	DECLARE @fileid INT,@flag BIT=0
	BEGIN TRANSACTION

	
	SELECT @fileId=fldFileId FROM com.tblEmployee_Detail WHERE fldEmployeeId=@fldId
	DELETE FROM Com.tblEmployee_Detail
	WHERE fldEmployeeId=@fldID
	if (@@error<>0)
	begin
	rollback
	set @flag=1
	end
	if (@flag=0)
	begin
	DELETE FROM Com.tblAshkhas 
	WHERE fldHaghighiId=@fldID
		if (@@error<>0)
		begin
		rollback
		set @flag=1
		end
	end
	if (@flag=0)
	begin
	UPDATE [Com].[tblEmployee]
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE  fldId = @fldId
		if (@@error<>0)
		begin
		rollback
		set @flag=1
		end
	end
	if (@flag=0)
	begin
	DELETE
	FROM   [Com].[tblEmployee]
	WHERE  fldId = @fldId
		if (@@error<>0)
		begin
		rollback
		set @flag=1
		end
	end
	if (@flag=0)
	begin
	UPDATE    [Com].[tblFile]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fileId
	if (@@error<>0)
		begin
		rollback
		set @flag=1
		end
	end
	if (@flag=0)
	begin
	DELETE
	FROM   [Com].[tblFile]
	WHERE  fldId = @fileId
	if (@@error<>0)
		begin
		rollback
		set @flag=1
		end
	end
	COMMIT
--	END TRY
	
--	BEGIN CATCH

--    IF @@TRANCOUNT > 0
--	BEGIN
--	PRINT('rollback')
--        ROLLBACK
--	end
--END CATCH
GO
