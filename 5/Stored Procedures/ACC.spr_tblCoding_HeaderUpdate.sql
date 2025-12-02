SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_HeaderUpdate] 
    @fldId int,
    @fldYear smallint,
    @fldOrganId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [ACC].[tblCoding_Header]
	SET    [fldId] = @fldId, [fldYear] = @fldYear, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
