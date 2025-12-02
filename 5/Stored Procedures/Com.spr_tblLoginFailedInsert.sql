SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblLoginFailedInsert] 
    @fldUserName nvarchar(100),
    @fldIP nvarchar(15)
AS 
	
	BEGIN TRAN
	
	INSERT INTO [Com].[tblLoginFailed] ([fldUserName], [fldIP], [fldDate])
	SELECT @fldUserName, @fldIP, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
