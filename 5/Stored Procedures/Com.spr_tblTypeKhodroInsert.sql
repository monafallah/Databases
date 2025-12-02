SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblTypeKhodroInsert] 
    
    @fldName nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(50),
  
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblTypeKhodro] 

	INSERT INTO [Com].[tblTypeKhodro] ([fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP],fldOrder)
	SELECT @fldId, @fldName, @fldUserId, @fldDesc, getdate(), @fldIP,@fldId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
