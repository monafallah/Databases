SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRadifInsert] 
   
    @fldGheteId int,
    @fldNameRadif nvarchar(250),
	@fldOrganId int,
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldNameRadif=com.fn_TextNormalize(@fldNameRadif)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblRadif] 

	INSERT INTO [Dead].[tblRadif] ([fldId], [fldGheteId], [fldNameRadif], [fldUserId], [fldIP], [fldDesc], [fldDate],fldOrganId)
	SELECT @fldId, @fldGheteId, @fldNameRadif, @fldUserId, @fldIP, @fldDesc, getdate(),@fldOrganId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
