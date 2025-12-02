SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghJebhe_PersonalUpdate] 
    @fldId int,
    @fldItemId int,
    @fldPrsPersonalId int,
    @fldAzTarikh nvarchar(10),
    @fldTaTarikh nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Prs].[tblSavabeghJebhe_Personal]
	SET    [fldItemId] = @fldItemId, [fldPrsPersonalId] = @fldPrsPersonalId, [fldAzTarikh] = @fldAzTarikh, [fldTaTarikh] = @fldTaTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
