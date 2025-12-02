SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblExternalFishInsert] 

    @fldNameCompany nvarchar(350),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblExternalFish] 
	INSERT INTO [Drd].[tblExternalFish] ([fldId], [fldNameCompany], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldNameCompany, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
