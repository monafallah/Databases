SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblApplicationPartUpdate] 
    @fldId int,
    @fldTitle nvarchar(50),
    @fldPID int,
    @fldModuleId INT,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblApplicationPart]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldPID] = @fldPID, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldModuleId=@fldModuleId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
