SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWarrantyTypeUpdate] 
    @fldId int,
    @fldName nvarchar(100),
  
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	
	UPDATE [Com].[tblWarrantyType]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
