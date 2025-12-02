SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomiInsert] 

    @fldNameParametreFa nvarchar(100),
    @fldNameParametreEn varchar(100),
    @fldNoeField tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set @fldNameParametreFa=com.fn_TextNormalize( @fldNameParametreFa)
	set @fldNameParametreEn=com.fn_TextNormalize(@fldNameParametreEn)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblParametreOmoomi] 
	INSERT INTO [Drd].[tblParametreOmoomi] ([fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldNameParametreFa, @fldNameParametreEn, @fldNoeField,null, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
