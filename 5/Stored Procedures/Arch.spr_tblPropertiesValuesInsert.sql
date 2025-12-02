SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblPropertiesValuesInsert] 
   
    @fldParticularId int,
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldValue=Com.fn_TextNormalize(@fldValue)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Arch].[tblPropertiesValues] 
	INSERT INTO [Arch].[tblPropertiesValues] ([fldId], [fldParticularId], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldParticularId, @fldValue, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
