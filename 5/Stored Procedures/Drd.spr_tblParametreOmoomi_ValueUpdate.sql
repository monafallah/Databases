SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblParametreOmoomi_ValueUpdate] 
    @fldId int,
    @fldParametreOmoomiId int,
    @fldFromDate nvarchar(10),
    @fldEndDate nvarchar(10) ,
    @fldValue nvarchar(250),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	BEGIN TRAN
	set @fldFromDate=com.fn_TextNormalize(@fldFromDate)
	set @fldEndDate=com.fn_TextNormalize(@fldEndDate)
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblParametreOmoomi_Value]
	SET    [fldParametreOmoomiId] = @fldParametreOmoomiId, [fldFromDate] = @fldFromDate, [fldEndDate] = @fldEndDate, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
