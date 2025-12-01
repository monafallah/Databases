SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_tblApplicationPartUpdate] 
    @fldID int,
    @fldTitle nvarchar(100),
    @fldPID int,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblApplicationPart]
	SET    [fldID] = @fldID, [fldTitle] = @fldTitle, [fldPID] = @fldPID, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
