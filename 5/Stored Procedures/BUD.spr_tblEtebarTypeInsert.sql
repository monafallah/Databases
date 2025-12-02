SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblEtebarTypeInsert] 
   
    @fldTitle nvarchar(100),
    @fldOrganId int,
    
    @fldDesc nvarchar(MAX),
    @fldUserId int
AS 
	 
	
	BEGIN TRAN
	
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	DECLARE @fldId INT 
	select @fldID =ISNULL(max(fldId),0)+1 from [BUD].[tblEtebarType]
	INSERT INTO [BUD].[tblEtebarType] ([fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId])
	SELECT @fldId, @fldTitle, @fldOrganId, GETDATE(), @fldDesc, @fldUserId
	
	if (@@ERROR<>0)
		ROLLBACK

               
	COMMIT
GO
