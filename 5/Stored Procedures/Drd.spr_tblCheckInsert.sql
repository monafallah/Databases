SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheckInsert] 
	@fldID int out,
    @fldShomareHesabId int,
    @fldShomareSanad nvarchar(50),
    @fldReplyTaghsitId INT,
    @fldTarikhSarResid nvarchar(10),
    @fldMablaghSanad bigint,
    @fldStatus tinyint,
    @fldTypeSanad bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldShomareHesabIdOrgan INT
AS 
	begin try
	BEGIN TRAN
	declare @sal smallint,@salmaliid int,@fldip varchar(15)='',@IdError int ,@idshobe int
	set  @fldShomareSanad=com.fn_TextNormalize(@fldShomareSanad)
	set  @fldTarikhSarResid=com.fn_TextNormalize(@fldTarikhSarResid)
	set  @fldDesc=com.fn_TextNormalize( @fldDesc) 
	


	declare @ashkhasid int,@fldOrganId int
	select @ashkhasid=fldAshkhasId from com.tblShomareHesabeOmoomi where fldid=@fldShomareHesabId
	select @idshobe=fldShobeId from com.tblShomareHesabeOmoomi where fldid=@fldShomareHesabId
	select @fldOrganId=e.fldOrganId from drd.tblReplyTaghsit r inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
	 where r.fldid=@fldReplyTaghsitId



	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblCheck] 
	INSERT INTO [Drd].[tblCheck] ([fldId], [fldShomareHesabId], [fldShomareSanad],fldReplyTaghsitId ,[fldTarikhSarResid], [fldMablaghSanad], [fldStatus], [fldTypeSanad], [fldUserId], [fldDesc], [fldDate],fldShomareHesabIdOrgan,fldTarikhAkhz,fldAshkhasId,fldBabat,fldOrganId,fldshobeId,fldReceive)
	SELECT @fldId, @fldShomareHesabId, @fldShomareSanad,@fldReplyTaghsitId ,@fldTarikhSarResid, @fldMablaghSanad, @fldStatus, @fldTypeSanad, @fldUserId, @fldDesc, GETDATE(),@fldShomareHesabIdOrgan,dbo.Fn_AssembelyMiladiToShamsi(GETDATE()),@ashkhasid,N'چک تقسیط اعلام عوارض',@fldOrganId,@idshobe,0

	

declare @id int 
		select @id =ISNULL(max(fldId),0)+1 from [chk].tblCheckStatus 
		INSERT INTO [chk].tblCheckStatus ([fldId], fldSodorCheckId,fldCheckVaredeId,fldAghsatId,fldVaziat,fldTarikh, [fldUserId], [fldDesc], [fldDate])
		SELECT @id, NULL, @fldid, NULL, @fldStatus,dbo.Fn_AssembelyMiladiToShamsi(getdate()),  @fldUserId, N'درآمد', GETDATE()
		
/******************************************************/
	
	
	COMMIT

	end try
	begin catch
	
	rollback

	select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@fldip,@fldUserId,'Check',getdate() from com.tblUser where fldid=@fldUserId
	--select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
	end catch
GO
