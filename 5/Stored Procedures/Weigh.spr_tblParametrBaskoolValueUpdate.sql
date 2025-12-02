SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrBaskoolValueUpdate] 
    @fldId int,
    @fldParametrBaskoolId int,
    @fldBaskoolId int,
    @fldValue nvarchar(200),
    @fldUserId int,

    @fldDesc nvarchar(100),
  
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Weigh].[tblParametrBaskoolValue]
	SET    [fldParametrBaskoolId] = @fldParametrBaskoolId, [fldBaskoolId] = @fldBaskoolId, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
