SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPropertiesInsert] 

    @fldEnName nvarchar(300),
    @fldFaName nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblProperties] 
	INSERT INTO [Drd].[tblProperties] ([fldId], [fldEnName], [fldFaName], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldEnName, @fldFaName, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
