SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblOperationInsert] 

    @fldTitle nvarchar(250),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblOperation] 
	INSERT INTO [Pay].[tblOperation] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
