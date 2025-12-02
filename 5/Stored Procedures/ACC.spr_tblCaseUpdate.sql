SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCaseUpdate] 
    @fldId int,
    @fldCaseTypeId int,
    @fldSourceId int,
    @fldDesc nvarchar(MAX),
   
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblCase]
	SET    [fldId] = @fldId, [fldCaseTypeId] = @fldCaseTypeId, [fldSourceId] = @fldSourceId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
