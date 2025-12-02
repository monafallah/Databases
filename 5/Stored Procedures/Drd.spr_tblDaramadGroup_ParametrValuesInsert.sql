SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrValuesInsert] 
  
    @fldElamAvarezId int,
    @fldParametrGroupDaramadId int,
    @fldValue nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblDaramadGroup_ParametrValues] 
	INSERT INTO [Drd].[tblDaramadGroup_ParametrValues] ([fldId], [fldElamAvarezId], [fldParametrGroupDaramadId], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldElamAvarezId, @fldParametrGroupDaramadId, @fldValue, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
