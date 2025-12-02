SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblDigitalArchiveTreeStructureUpdate] 
    @fldId int,
    @fldTitle nvarchar(400),
    @fldPID int,
    @fldModuleId int,
    @fldAttachFile bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblDigitalArchiveTreeStructure]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldPID] = @fldPID, [fldModuleId] = @fldModuleId, [fldAttachFile] = @fldAttachFile, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
