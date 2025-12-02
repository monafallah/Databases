SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartablUpdate] 
    @fldId int,
    @fldTitleKartabl nvarchar(300),
    @fldUserId int,
	@fldOrganId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100),
	@fldHaveEtmam bit,
	@fldHaveEbtal bit
AS 

	BEGIN TRAN
	set @fldTitleKartabl=com.fn_TextNormalize(@fldTitleKartabl)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblKartabl]
	SET    [fldTitleKartabl] = @fldTitleKartabl, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldOrganId=@fldOrganId,fldHaveEbtal=@fldHaveEbtal,fldHaveEtmam=@fldHaveEtmam
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
