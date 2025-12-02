SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWarrantyTypeInsert] 
   
    @fldName nvarchar(100),
   
    @fldDesc nvarchar(MAX),
   
    @fldIp varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblWarrantyType] 
	INSERT INTO [Com].[tblWarrantyType] ([fldId], [fldName], [fldDesc], [fldDate], [fldIp], [fldUserId])
	SELECT @fldId, @fldName, @fldDesc, GETDATE(), @fldIp, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
