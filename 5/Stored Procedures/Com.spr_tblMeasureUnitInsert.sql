SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMeasureUnitInsert] 
  
    @fldNameVahed nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	
	BEGIN TRAN
	set @fldNameVahed=com.fn_TextNormalize(@fldNameVahed)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblMeasureUnit] 
	INSERT INTO [com].[tblMeasureUnit] ([fldId], [fldNameVahed], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldNameVahed, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
