SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblAghsatCheckAmaniUpdate] 
    @fldId int,
    @fldMablagh bigint,
    @fldTarikh nvarchar(10),
    @fldNobat nvarchar(50),
    @fldIdCheckHayeVarede int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
		@fldOrganId int
AS 
	BEGIN TRAN
	UPDATE [chk].[tblAghsatCheckAmani]
	SET    [fldId] = @fldId, [fldMablagh] = @fldMablagh, [fldTarikh] = @fldTarikh, [fldNobat] = @fldNobat, [fldIdCheckHayeVarede] = @fldIdCheckHayeVarede, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),	fldOrganId =	@fldOrganId 
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
