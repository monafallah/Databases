SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghJebhe_ItemsUpdate] 
    @fldId int,
    @fldTitle nvarchar(250),
    @fldDarsad_Sal decimal(5, 2),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Prs].[tblSavabeghJebhe_Items]
	SET    [fldTitle] = @fldTitle, [fldDarsad_Sal] = @fldDarsad_Sal, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
