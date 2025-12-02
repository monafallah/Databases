SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblModuleInsert] 
 
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblModule] 
	INSERT INTO [Com].[tblModule] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
