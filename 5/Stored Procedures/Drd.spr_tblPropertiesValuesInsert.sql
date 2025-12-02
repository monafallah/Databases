SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPropertiesValuesInsert] 
  
    @fldPropertiesId int,
    @fldElamAvarezId int,
    @fldValue nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPropertiesValues] 
	INSERT INTO [Drd].[tblPropertiesValues] ([fldId], [fldPropertiesId], [fldElamAvarezId], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldPropertiesId, @fldElamAvarezId, @fldValue, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
