SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrBaskoolValueInsert] 
    
    @fldParametrBaskoolId int,
    @fldBaskoolId int,
    @fldValue nvarchar(200),
    @fldUserId int,

    @fldDesc nvarchar(100),

    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblParametrBaskoolValue] 

	INSERT INTO [Weigh].[tblParametrBaskoolValue] ([fldId], [fldParametrBaskoolId], [fldBaskoolId], [fldValue], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldParametrBaskoolId, @fldBaskoolId, @fldValue, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
