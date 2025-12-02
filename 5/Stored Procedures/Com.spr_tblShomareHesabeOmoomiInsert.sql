SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblShomareHesabeOmoomiInsert] 
  
    @fldShobeId int,
    @fldAshkhasId int,
    @fldShomareHesab varchar(50),
    @fldShomareSheba nvarchar(27) ,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
    
AS 
	
	BEGIN TRAN
	--set  @fldShomareHesab=com.fn_TextNormalize( @fldShomareHesab)
	--set  @fldShomareSheba=com.fn_TextNormalize(@fldShomareSheba)
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblShomareHesabeOmoomi] 
	INSERT INTO [com].[tblShomareHesabeOmoomi] ([fldId], [fldShobeId], [fldAshkhasId], [fldShomareHesab], [fldShomareSheba], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldShobeId, @fldAshkhasId, @fldShomareHesab, @fldShomareSheba, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
