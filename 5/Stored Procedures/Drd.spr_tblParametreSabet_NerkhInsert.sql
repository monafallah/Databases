SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_NerkhInsert] 
   
    @fldParametreSabetId int,
    @fldTarikhFaalSazi nvarchar(10),
    @fldValue NVARCHAR(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	
	BEGIN TRAN
	set @fldTarikhFaalSazi=com.fn_TextNormalize(@fldTarikhFaalSazi)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblParametreSabet_Nerkh] 
	INSERT INTO [Drd].[tblParametreSabet_Nerkh] ([fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldParametreSabetId, @fldTarikhFaalSazi, @fldValue, @fldUserId, @fldDesc, getDate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
