SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblComboBoxValueInsert] 
  
    @fldComboBoxId int,
    @fldTitle nvarchar(100),
    @fldValue nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblComboBoxValue] 
	INSERT INTO [Drd].[tblComboBoxValue] ([fldId], [fldComboBoxId], [fldTitle], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldComboBoxId, @fldTitle, @fldValue, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
