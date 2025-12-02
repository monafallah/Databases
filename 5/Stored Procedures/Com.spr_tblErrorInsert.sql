SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblErrorInsert] 
	@fldID INT OUT,
    @fldUserName nvarchar(50),
    @fldMatn nvarchar(MAX),
    @fldTarikh date,
    @fldIP nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblError] 
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldUserName, @fldMatn, @fldTarikh, @fldIP, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
