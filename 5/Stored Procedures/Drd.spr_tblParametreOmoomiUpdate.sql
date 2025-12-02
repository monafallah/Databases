SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomiUpdate] 
    @fldId int,
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
	UPDATE [Drd].[tblParametreOmoomi]
	SET    [fldNameParametreFa] = @fldNameParametreFa, [fldNameParametreEn] = @fldNameParametreEn, [fldNoeField] = @fldNoeField, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
