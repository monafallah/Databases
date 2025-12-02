SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMahalFotInsert] 
 
    @fldNameMahal nvarchar(250),
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldNameMahal=com.fn_TextNormalize(@fldNameMahal)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblMahalFot] 

	INSERT INTO [Dead].[tblMahalFot] ([fldId], [fldNameMahal], [fldUserId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldNameMahal, @fldUserId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
