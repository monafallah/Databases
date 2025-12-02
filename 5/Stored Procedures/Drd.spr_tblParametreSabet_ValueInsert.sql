SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_ValueInsert] 
    @fldElamAvarezId int,
    @fldValue nvarchar(300),
    @fldParametreSabetId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldCodeDaramadElamAvarezId int
    
AS 
	
	BEGIN TRAN
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblParametreSabet_Value] 
	INSERT INTO [Drd].[tblParametreSabet_Value] ([fldID], [fldElamAvarezId], [fldValue], [fldParametreSabetId], [fldUserId], [fldDesc], [fldDate],fldCodeDaramadElamAvarezId)
	SELECT @fldID, @fldElamAvarezId, @fldValue, @fldParametreSabetId, @fldUserId, @fldDesc, getdate(),@fldCodeDaramadElamAvarezId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
