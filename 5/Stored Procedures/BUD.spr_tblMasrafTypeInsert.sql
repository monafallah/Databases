SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMasrafTypeInsert] 
    
    @fldTitle nvarchar(100),
    @fldOrganId int,
   
    @fldDesc nvarchar(MAX),
    @fldUserId int
AS 
	
	BEGIN TRAN
	
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	DECLARE @fldId INT
	SELECT @fldId=ISNULL(MAX(fldId),0)+1 FROM BUD.tblMasrafType
	INSERT INTO [BUD].[tblMasrafType] ([fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId])
	SELECT @fldId, @fldTitle, @fldOrganId, GETDATE(), @fldDesc, @fldUserId
	

	
               
	COMMIT
GO
