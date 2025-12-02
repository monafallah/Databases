SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorDetailUpdate] 
    @fldId int,
    @fldHeaderId int,
    @fldMablagh bigint,
    @fldMablaghMaliyat bigint,
    @fldCodingDetailId int,
	@fldSharhArtikl nvarchar(max),
	@fldTax bit,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldIP varchar(16)
AS 
	 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldSharhArtikl=com.fn_TextNormalize(@fldSharhArtikl)
	UPDATE [Cntr].[tblFactorDetail]
	SET    [fldHeaderId] = @fldHeaderId, [fldMablagh] = @fldMablagh,fldTax=@fldTax, [fldMablaghMaliyat] = @fldMablaghMaliyat, [fldCodingDetailId] = @fldCodingDetailId, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	,fldSharhArtikl=@fldSharhArtikl
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
