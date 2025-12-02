SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMasrafTypeUpdate] 
    @fldId int,
    @fldTitle nvarchar(100),
    @fldOrganId int,
    
    @fldDesc nvarchar(MAX),
    @fldUserId int
AS 
	  
	
	BEGIN TRAN
    SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [BUD].[tblMasrafType]
	SET    [fldTitle] = @fldTitle, [fldOrganId] = @fldOrganId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	


	COMMIT
GO
