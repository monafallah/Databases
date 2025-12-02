SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroupUpdate] 
    @fldId int,
    @fldTitle nvarchar(100),
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblUserGroup]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
