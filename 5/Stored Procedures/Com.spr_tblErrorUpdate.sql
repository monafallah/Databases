SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblErrorUpdate] 
    @fldId int,
    @fldUserName nvarchar(50),
    @fldMatn nvarchar(MAX),
    @fldTarikh date,
    @fldIP nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblError]
	SET    [fldId] = @fldId, [fldUserName] = @fldUserName, [fldMatn] = @fldMatn, [fldTarikh] = @fldTarikh, [fldIP] = @fldIP, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
