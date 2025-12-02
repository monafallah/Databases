SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabsInsert] 

    @fldPersonalId int,
    @fldShobeId int,
    @fldShomareHesab nvarchar(50),
    @fldShomareKart nvarchar(50),
    @fldTypeHesab bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldHesabTypeId tinyint
AS 
	
	BEGIN TRAN
	declare @fldID int ,@fldAshkhasId int ,@fldshomarehesabOmoomiID int ,@flag bit=0
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldShomareHesab=Com.fn_TextNormalize(@fldShomareHesab)
	SET @fldShomareKart=Com.fn_TextNormalize(@fldShomareKart)
	SET @fldAshkhasId=Com.fn_AshkhasIdwithPersonalId(@fldPersonalId)
	
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblShomareHesabeOmoomi] 
	INSERT INTO [com].[tblShomareHesabeOmoomi] ([fldId], [fldShobeId], [fldAshkhasId], [fldShomareHesab], [fldShomareSheba], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldShobeId, @fldAshkhasId, @fldShomareHesab,null, @fldUserId, @fldDesc, getdate()
	 
 if(@@ERROR<>0)
  Begin
   Set @flag=1
   Rollback
  end

 if(@flag=0)
 Begin 
	select @fldshomarehesabOmoomiID =ISNULL(max(fldId),0)+1 from [Com].[tblShomareHesabOmoomi_Detail] 
	INSERT INTO [Com].[tblShomareHesabOmoomi_Detail] ([fldId], [fldShomareHesabId], [fldTypeHesab],[fldShomareKart], [fldUserId], [fldDesc], [fldDate],fldHesabTypeId)
	SELECT @fldshomarehesabOmoomiID, @fldID, @fldTypeHesab,@fldShomareKart, @fldUserId, @fldDesc, getdate(),@fldHesabTypeId

	if(@@Error<>0)
	begin
	     set @flag=1
		 Rollback
	end
	ENd


	COMMIT
GO
