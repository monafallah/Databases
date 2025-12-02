SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSafteUpdate] 
    @fldId int,
    @fldTarikhSarResid nvarchar(10),
    @fldShomareSanad nvarchar(50),
    @fldReplyTaghsitId INT,
    @fldMablaghSanad bigint,
    @fldStatus tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldDateStatus nvarchar(10)
AS 
	BEGIN TRAN
	set  @fldTarikhSarResid=com.fn_TextNormalize(@fldTarikhSarResid)
	set  @fldShomareSanad=com.fn_TextNormalize(@fldShomareSanad)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblSafte]
	SET    [fldId] = @fldId, [fldTarikhSarResid] = @fldTarikhSarResid, [fldShomareSanad] = @fldShomareSanad,fldReplyTaghsitId=@fldReplyTaghsitId ,[fldMablaghSanad] = @fldMablaghSanad, [fldStatus] = @fldStatus, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldDateStatus=@fldDateStatus
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
