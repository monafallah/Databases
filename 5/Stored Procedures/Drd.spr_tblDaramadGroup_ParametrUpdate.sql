SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrUpdate] 
    @fldId int,
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
	UPDATE [Drd].[tblDaramadGroup_Parametr]
	SET    [fldId] = @fldId, [fldDaramadGroupId] = @fldDaramadGroupId, [fldEnName] = @fldEnName, [fldFnName] = @fldFnName, [fldStatus] = @fldStatus, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldNoeField=@fldNoeField,fldComboBoxId=@fldComboBoxId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
