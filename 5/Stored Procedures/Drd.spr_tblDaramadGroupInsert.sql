SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblDaramadGroupInsert] 
   
    @fldTitle nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldOrganId	int	
AS 
	
	BEGIN TRAN
	SET @fldTitle=com.fn_TextNormalize(@fldTitle)
		SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblDaramadGroup] 
	INSERT INTO [Drd].[tblDaramadGroup] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, GETDATE(),@fldOrganId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
