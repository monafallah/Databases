SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblShomareHesabeOmoomiUpdate] 
    @fldId int,
    @fldShobeId int,
    @fldAshkhasId int,
    @fldShomareHesab varchar(50),
    @fldShomareSheba nvarchar(27) ,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	set  @fldShomareHesab=com.fn_TextNormalize( @fldShomareHesab)
	set  @fldShomareSheba=com.fn_TextNormalize(@fldShomareSheba)
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	UPDATE [com].[tblShomareHesabeOmoomi]
	SET    [fldShobeId] = @fldShobeId, [fldAshkhasId] = @fldAshkhasId, [fldShomareHesab] = @fldShomareHesab, [fldShomareSheba] = @fldShomareSheba, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
