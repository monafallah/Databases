SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghJebhe_PersonalInsert] 
   
    @fldItemId int,
    @fldPrsPersonalId int,
    @fldAzTarikh nvarchar(10),
    @fldTaTarikh nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblSavabeghJebhe_Personal] 
	INSERT INTO [Prs].[tblSavabeghJebhe_Personal] ([fldId], [fldItemId], [fldPrsPersonalId], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldItemId, @fldPrsPersonalId, @fldAzTarikh, @fldTaTarikh, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
