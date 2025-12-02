SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabsUpdate] 
    @fldId int,
	@fldShobeId int,
    @fldPersonalId int,
    @fldShomareHesab nvarchar(50),
    @fldShomareKart nvarchar(50),
    @fldTypeHesab bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldHesabTypeId tinyint
AS 
	BEGIN TRAN
	declare  @flag bit=0 ,@fldAshkhasId int
	set  @fldShomareHesab=com.fn_TextNormalize( @fldShomareHesab)
	SET  @fldShomareKart=Com.fn_TextNormalize(@fldShomareKart)
	set  @fldDesc=com.fn_TextNormalize( @fldDesc)
	SET @fldAshkhasId=Com.fn_AshkhasIdwithPersonalId(@fldPersonalId)
	UPDATE [com].[tblShomareHesabeOmoomi]
	SET    [fldShobeId] = @fldShobeId, [fldAshkhasId] = @fldAshkhasId, [fldShomareHesab] = @fldShomareHesab, [fldShomareSheba] = null, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] =getdate()

	WHERE  [fldId] = @fldId

		 
 if(@@ERROR<>0)
  Begin
   Set @flag=1
   Rollback
  end

 if(@flag=0)
 Begin 
	UPDATE [Com].[tblShomareHesabOmoomi_Detail]
	SET    [fldShomareHesabId] = @fldId, [fldTypeHesab] = @fldTypeHesab,[fldShomareKart]=@fldShomareKart, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,	fldHesabTypeId=@fldHesabTypeId
	WHERE  [fldShomareHesabId] = @fldId

	if(@@Error<>0)
	begin
	     set @flag=1
		 Rollback
	end
	ENd

 
COMMIT
GO
