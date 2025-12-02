SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblStateInsert] 
  
    @fldName nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldName=Com.fn_TextNormalize(@fldname)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblState] 
	INSERT INTO [Com].[tblState] ([fldId], [fldName], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldName, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
