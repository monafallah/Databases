SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrInsert] 
 
    @fldDaramadGroupId int,
    @fldEnName nvarchar(50),
    @fldFnName nvarchar(50),
    @fldStatus bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldNoeField	tinyint	,
	@fldComboBoxId	int	
	
AS 
	
	BEGIN TRAN
	SET @fldEnName=com.fn_TextNormalize(@fldEnName)
	SET @fldFnName=com.fn_TextNormalize(@fldFnName)
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblDaramadGroup_Parametr] 
	INSERT INTO [Drd].[tblDaramadGroup_Parametr] ([fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate],fldNoeField,fldComboBoxId,fldFormuleId)
	SELECT @fldId, @fldDaramadGroupId, @fldEnName, @fldFnName, @fldStatus, @fldUserId, @fldDesc, GETDATE(),@fldNoeField,@fldComboBoxId,NULL
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
