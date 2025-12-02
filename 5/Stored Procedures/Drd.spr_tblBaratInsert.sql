SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblBaratInsert] 

    @fldTarikhSarResid nvarchar(10),
    @fldReplyTaghsitId INT,
    @fldShomareSanad nvarchar(50),
    @fldMablaghSanad bigint,
    @fldStatus tinyint,
    @fldBaratDarId int,
    @fldMakanPardakht nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN

	set  @fldShomareSanad=com.fn_TextNormalize(@fldShomareSanad)
	set  @fldMakanPardakht=com.fn_TextNormalize(@fldMakanPardakht)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblBarat] 
	INSERT INTO [Drd].[tblBarat] ([fldId], [fldTarikhSarResid], [fldShomareSanad],fldReplyTaghsitId, [fldMablaghSanad], [fldStatus], [fldBaratDarId], [fldMakanPardakht], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTarikhSarResid, @fldShomareSanad,@fldReplyTaghsitId, @fldMablaghSanad, @fldStatus, @fldBaratDarId, @fldMakanPardakht, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
