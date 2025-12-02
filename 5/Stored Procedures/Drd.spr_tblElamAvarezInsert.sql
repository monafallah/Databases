SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblElamAvarezInsert] 
    @fldId  int output,
    @fldAshakhasID int,
    @fldType bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldOrganId INT,
	@fldIsExternal BIT,
	@fldDaramadGroupId INT,
	@fldCodeSystemMabda NVARCHAR(50)
    
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblElamAvarez] 
	INSERT INTO [Drd].[tblElamAvarez] ([fldId], [fldAshakhasID], [fldType], [fldUserId], [fldDesc], [fldDate],fldOrganId,fldIsExternal,fldDaramadGroupId,fldCodeSystemMabda)
	SELECT @fldId, @fldAshakhasID, @fldType, @fldUserId, @fldDesc, getdate(),@fldOrganId,@fldIsExternal,@fldDaramadGroupId,@fldCodeSystemMabda
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
