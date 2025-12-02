SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartablInsert] 
  
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblKartabl] 

	INSERT INTO [Dead].[tblKartabl] ([fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId,fldOrderId,fldHaveEtmam,fldHaveEbtal )
	SELECT @fldId, @fldTitleKartabl, @fldUserId, @fldIP, @fldDesc, getdate(),@fldorganId,@fldID,@fldHaveEtmam,@fldHaveEbtal
	if(@@Error<>0)
        rollback       
	COMMIT
GO
