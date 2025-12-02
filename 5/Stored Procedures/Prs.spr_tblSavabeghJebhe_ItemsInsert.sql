SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghJebhe_ItemsInsert] 

    @fldTitle nvarchar(250),
    @fldDarsad_Sal decimal(5, 2),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblSavabeghJebhe_Items] 
	INSERT INTO [Prs].[tblSavabeghJebhe_Items] ([fldId], [fldTitle], [fldDarsad_Sal], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldDarsad_Sal, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
