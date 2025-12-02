SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSafteInsert] 
 
    @fldTarikhSarResid nvarchar(10),
    @fldReplyTaghsitId INT,
    @fldShomareSanad nvarchar(50),
    @fldMablaghSanad bigint,
    @fldStatus tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set  @fldTarikhSarResid=com.fn_TextNormalize(@fldTarikhSarResid)
	set  @fldShomareSanad=com.fn_TextNormalize(@fldShomareSanad)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblSafte] 
	INSERT INTO [Drd].[tblSafte] ([fldId], [fldTarikhSarResid], [fldShomareSanad],fldReplyTaghsitId ,[fldMablaghSanad], [fldStatus], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTarikhSarResid, @fldShomareSanad,@fldReplyTaghsitId ,@fldMablaghSanad, @fldStatus, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
