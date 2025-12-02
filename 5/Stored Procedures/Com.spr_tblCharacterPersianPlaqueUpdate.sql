SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCharacterPersianPlaqueUpdate]
    @fldId int,
    @fldName nvarchar(1),
    @fldUserId int,
    @fldDesc nvarchar(50),

    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Com].[tblCharacterPersianPlaque]
	SET    [fldName] = @fldName, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
