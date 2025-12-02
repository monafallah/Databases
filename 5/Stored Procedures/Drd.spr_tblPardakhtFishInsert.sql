SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFishInsert] 
  
    @fldFishId int,
    @fldDatePardakht datetime,
    @fldNahvePardakhtId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldPardakhtFiles_DetailId int,
	@fldDateVariz datetime
    
AS 
	
	begin try
	BEGIN TRAN
	declare @IdError int
	declare @organid int,@sal smallint,@salmaliid int,@fldip varchar(15)=''
	select @organid=fldOrganId from drd.tblSodoorFish s inner join drd.tblElamAvarez e on 
	e.fldid=s.fldElamAvarezId
	where s.fldid=@fldFishId
	----------------------------------------

	select top(1)@fldip=fldIP from  com.tblInputInfo where fldUserID=@fldUserId
	order by fldid desc

	-----------------------------------------

	set @sal=substring(dbo.Fn_AssembelyMiladiToShamsi(@fldDateVariz),1,4)
	select @salmaliid=fldid from acc.tblFiscalYear where fldOrganId=@organid and fldYear=@sal

	-------------------------------------------
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPardakhtFish] 
	INSERT INTO [Drd].[tblPardakhtFish] ([fldId], [fldFishId], [fldDatePardakht], [fldNahvePardakhtId], [fldUserId], [fldDesc], [fldDate],fldPardakhtFiles_DetailId,fldDateVariz)
	SELECT @fldId, @fldFishId, @fldDatePardakht, @fldNahvePardakhtId, @fldUserId, @fldDesc, getdate(),@fldPardakhtFiles_DetailId,@fldDateVariz
	
	/*************************************/
	if exists (	select * from com.tblModule_Organ where fldOrganId=@organid and fldModuleId=10)

	exec [ACC].[spr_DocumentInsert_DaramadFish] @salmaliid,@fldFishId,@organid,@fldDesc,@fldip,@fldUserId,10,5
	
	COMMIT

	end try
	begin catch
		
	rollback

	select @IdError=isnull( max(fldid),0)+1 from com.tblError
	INSERT INTO [Com].[tblError] ([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	select @IdError,fldUserName,ERROR_MESSAGE(),cast(getdate()as date),@fldip,@fldUserId,'tblPardakhtFishInsert',getdate() from com.tblUser where fldid=@fldUserId
	--select ERROR_NUMBER()  as ErrorCode,ERROR_MESSAGE() as ErrorMessage
	end catch
GO
