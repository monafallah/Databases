SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblAghsatCheckAmaniInsert] 

    @fldMablagh bigint,
    @fldTarikh nvarchar(10),
    @fldNobat nvarchar(50),
    @fldIdCheckHayeVarede int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [chk].[tblAghsatCheckAmani] 
	INSERT INTO [chk].[tblAghsatCheckAmani] ([fldId], [fldMablagh], [fldTarikh], [fldNobat], [fldIdCheckHayeVarede], [fldUserId], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldMablagh, @fldTarikh, @fldNobat, @fldIdCheckHayeVarede, @fldUserId, @fldDesc, GETDATE(),@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
