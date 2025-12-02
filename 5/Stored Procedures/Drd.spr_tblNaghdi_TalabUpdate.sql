SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblNaghdi_TalabUpdate] 
    @fldId int,
    @fldMablagh bigint,
    @fldReplyTaghsitId int,
    @fldType tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldShomareHesabId int
AS 
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblNaghdi_Talab]
	SET    [fldId] = @fldId, [fldMablagh] = @fldMablagh, [fldReplyTaghsitId] = @fldReplyTaghsitId, [fldType] = @fldType, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldShomareHesabId=@fldShomareHesabId
	WHERE fldid=@fldId
	COMMIT TRAN
GO
