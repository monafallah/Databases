SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomi_ValueInsert] 
 
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblParametreOmoomi_Value] 
	INSERT INTO [Drd].[tblParametreOmoomi_Value] ([fldId], [fldParametreOmoomiId], [fldFromDate], [fldEndDate], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldParametreOmoomiId, @fldFromDate, @fldEndDate, @fldValue, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
