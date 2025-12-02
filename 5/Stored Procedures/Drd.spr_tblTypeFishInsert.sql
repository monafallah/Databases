SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTypeFishInsert] 

    @fldTypeFish nvarchar(400),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblTypeFish] 
	INSERT INTO [Drd].[tblTypeFish] ([fldId], [fldTypeFish], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTypeFish, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
