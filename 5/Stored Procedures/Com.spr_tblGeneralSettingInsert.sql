SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblGeneralSettingInsert] 
  @fldID tinyint out,
    @fldName nvarchar(200),
    @fldValue nvarchar(200),
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldOrganId int,
	@fldModuleId int
AS 

	
	BEGIN TRAN
	
	--declare 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].tblGeneralSetting 
	SET @fldName=com.fn_TextNormalize(@fldName)
	SET @fldValue=com.fn_TextNormalize(@fldValue)
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	INSERT INTO [Com].tblGeneralSetting ([fldId], [fldName], [fldValue], [fldUserId], [fldDesc], [fldDate],fldModuleId)
	SELECT @fldId, @fldName, @fldValue, @fldUserId, @fldDesc, getdate(),@fldModuleId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
