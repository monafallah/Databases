SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCharacterPersianPlaqueInsert] 

    @fldName nvarchar(1),
    @fldUserId int,
    @fldDesc nvarchar(50),
   
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblCharacterPersianPlaque] 

	INSERT INTO [Com].[tblCharacterPersianPlaque] ([fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldName, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
