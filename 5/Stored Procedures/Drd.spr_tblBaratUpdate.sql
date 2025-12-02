SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblBaratUpdate] 
    @fldId int,
    @fldTarikhSarResid nvarchar(10),
    @fldReplyTaghsitId INT,
    @fldShomareSanad nvarchar(50),
    @fldMablaghSanad bigint,
    @fldStatus tinyint,
    @fldBaratDarId int,
    @fldMakanPardakht nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldDateStatus nvarchar(10)
AS 
	BEGIN TRAN
	set  @fldTarikhSarResid=com.fn_TextNormalize(@fldTarikhSarResid)
	set  @fldShomareSanad=com.fn_TextNormalize(@fldShomareSanad)
	set  @fldMakanPardakht=com.fn_TextNormalize(@fldMakanPardakht)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblBarat]
	SET    [fldId] = @fldId, [fldTarikhSarResid] = @fldTarikhSarResid,fldReplyTaghsitId=@fldReplyTaghsitId ,[fldShomareSanad] = @fldShomareSanad, [fldMablaghSanad] = @fldMablaghSanad, [fldStatus] = @fldStatus, [fldBaratDarId] = @fldBaratDarId, [fldMakanPardakht] = @fldMakanPardakht, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldDateStatus=@fldDateStatus
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
