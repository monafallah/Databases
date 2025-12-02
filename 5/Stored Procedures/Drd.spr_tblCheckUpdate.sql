SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheckUpdate] 
    @fldId int,
    @fldShomareHesabId int,
    @fldShomareSanad nvarchar(50),
    @fldReplyTaghsitId INT,
    @fldTarikhSarResid nvarchar(10),
    @fldMablaghSanad bigint,
    @fldStatus tinyint,
    @fldTypeSanad bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldShomareHesabIdOrgan INT,
	@fldDateStatus nvarchar(10)
AS 
	BEGIN TRAN
	set  @fldShomareSanad=com.fn_TextNormalize(@fldShomareSanad)
	set  @fldTarikhSarResid=com.fn_TextNormalize(@fldTarikhSarResid)
	set  @fldDesc=com.fn_TextNormalize(@fldDesc)
	if (select top(1) fldvaziat from chk.tblCheckStatus where fldCheckVaredeId=@fldid order by fldid desc)=@fldStatus
	begin	
		update top(1)  c
		set fldtarikh=isnull(@fldDateStatus,dbo.Fn_AssembelyMiladiToShamsi(getdate()))
		from chk.tblCheckStatus c
		where fldCheckVaredeId=@fldid
		if (@@error<>0)
			rollback

	end 
	else if (select top(1) fldvaziat from chk.tblCheckStatus where fldCheckVaredeId=@fldid order by fldid desc)<>@fldStatus
	begin 
		declare @id int 
		select @id =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
		INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
		SELECT @id, NULL, @fldid, NULL, @fldStatus, isnull(@fldDateStatus,dbo.Fn_AssembelyMiladiToShamsi(getdate())),  @fldUserId,  N'درآمد', GETDATE()
		if (@@ERROR<>0)
			ROLLBACK

	end 
	declare @ashkhasid int,@idshobe int, @sal smallint,@salmaliid int,@fldip varchar(15)='',@IdError int ,@fldOrganId int
	select @ashkhasid=fldAshkhasId,@idshobe=fldShobeId from com.tblShomareHesabeOmoomi where fldid=@fldShomareHesabId

	UPDATE [Drd].[tblCheck]
	SET    [fldId] = @fldId, [fldShomareHesabId] = @fldShomareHesabId,fldReplyTaghsitId=@fldReplyTaghsitId ,[fldShomareSanad] = @fldShomareSanad, [fldTarikhSarResid] = @fldTarikhSarResid, [fldMablaghSanad] = @fldMablaghSanad, [fldStatus] = @fldStatus, [fldTypeSanad] = @fldTypeSanad, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),fldShomareHesabIdOrgan=@fldShomareHesabIdOrgan,fldDateStatus=@fldDateStatus
	,fldashkhasId=@ashkhasid,fldShobeId=@idshobe
	WHERE  [fldId] = @fldId
	if (@@ERROR<>0)
		ROLLBACK




	COMMIT TRAN
GO
