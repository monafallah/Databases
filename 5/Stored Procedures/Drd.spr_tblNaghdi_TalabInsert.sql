SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblNaghdi_TalabInsert] 

    @fldMablagh bigint,
    @fldReplyTaghsitId int,
    @fldType tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldShomareHesabId int
AS 
	
	BEGIN TRAN
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblNaghdi_Talab] 
	INSERT INTO [Drd].[tblNaghdi_Talab] ([fldId], [fldMablagh], [fldReplyTaghsitId], [fldType], [fldUserId], [fldDesc], [fldDate],fldFishId,fldShomareHesabId)
	SELECT @fldId, @fldMablagh, @fldReplyTaghsitId, @fldType, @fldUserId, @fldDesc, GETDATE(),NULL,@fldShomareHesabId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
