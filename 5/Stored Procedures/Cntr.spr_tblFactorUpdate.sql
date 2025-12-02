SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorUpdate] 
    @fldId int,
    @fldTarikh varchar(10),
    @fldShomare nvarchar(50),
    @fldShanaseMoadiyan nvarchar(50),
	@fldSharhSanad nvarchar(max),
 	@fldProjectId int=null,
	@fldAshkhasId int=null,
	@fldTankhahGroupId int=null,
	@fldKasrBime	decimal(4, 2),
	@fldKasrHosnAnjamKar	decimal(4, 2)	,
	@fldShomareSabt nvarchar(20),
	@fldCodeEghtesadi nvarchar(20),
	@fldAddress nvarchar(max),
	@fldTarikhVariz varchar(10),
	@fldQrCode nvarchar(100),
	@Detail   cntr.InserDetailFactor readOnly,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(200),
    @fldIP varchar(16)
AS 
	 
begin try	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldSharhSanad=com.fn_TextNormalize(@fldSharhSanad)
	set @fldAddress=com.fn_TextNormalize(@fldAddress)

	declare @detailid int,@er int,@Hoghoghiid int
	select @detailid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblFactorDetail]
/*************************************************/
--delete 
	 DELETE  f from cntr.tblFactorDetail f
	 left join @Detail d on d.fldid=f.fldid
	 where d.fldid is null and f.fldHeaderId=@fldid

/*************************************************/
--update
	 update f  
	 SET    [fldMablagh] = d.fldMablagh,fldTax=d.fldTax,[fldCodingDetailId] =d.fldCodingDetailId, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	,fldSharhArtikl=com.fn_TextNormalize( d.fldSharhArtikl),fldMablaghMaliyat=d.fldMablaghMaliyat
	 from  cntr.tblFactorDetail f
	 inner  join @Detail d on d.fldid=f.fldid
	 where  f.fldHeaderId=@fldid
/************************************************/
--insert
	select @detailid=isnull(max(fldId),0)  FROM   [Cntr].[tblFactorDetail] 
	INSERT INTO [Cntr].[tblFactorDetail] ([fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId],fldSharhArtikl,fldTax, [fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate])
	SELECT ROW_NUMBER() over (order by (select 1))+@detailid, @fldId, d.fldMablagh, d.fldMablaghMaliyat, d.fldCodingDetailId,com.fn_TextNormalize( d.fldSharhArtikl),f.fldTax, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate()
	from  cntr.tblFactorDetail f
	 right join @Detail d on d.fldid=f.fldid
	 where f.fldid is null 
/************************************************/
	UPDATE [Cntr].[tblFactor]
	SET    [fldTarikh] = @fldTarikh,fldSharhSanad=@fldSharhSanad, [fldShomare] = @fldShomare, [fldShanaseMoadiyan] = @fldShanaseMoadiyan, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	,fldKasrBime=@fldKasrBime,fldKasrHosnAnjamKar=@fldKasrHosnAnjamKar
	WHERE  [fldId] = @fldId
	 
	if(@fldProjectId is not null or  @fldAshkhasId is not null or @fldTankhahGroupId is not null)
	UPDATE [Cntr].[tblFactorMostaghel]
	SET    [fldAshkhasId] = @fldAshkhasId, [fldBudjeCodingId] = @fldProjectId, [fldTankhahGroupId] = @fldTankhahGroupId, [fldUserId] = @fldUserId, [fldOrganID] = @fldOrganID, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	,fldtarikhvariz =@fldTarikhVariz,fldQrCode=@fldQrCode
	WHERE   [fldFactorId] = @fldId
	
	if (@fldShomareSabt is not null and @fldShomareSabt<>'' and @fldCodeEghtesadi  is not null and @fldCodeEghtesadi<>'' and @fldAddress  is not null and @fldAddress<>''  )
	begin 
		select @Hoghoghiid=fldHoghoghiId from com.tblAshkhas where fldid=@fldAshkhasId

		update com.tblAshkhaseHoghoghi
		set fldShomareSabt=@fldShomareSabt,fldUserId=@fldUserId,fldDate=getdate()
		where fldid=@Hoghoghiid


		update com.tblAshkhaseHoghoghi_Detail
		set fldCodEghtesadi=@fldCodeEghtesadi,fldAddress=@fldAddress,fldUserId=@fldUserId,fldDate=getdate()
		where fldAshkhaseHoghoghiId=@Hoghoghiid

	end
	/*اگر فاکتور ، قرارداد داشته باشد این سه فیلد در جدول فاکتور مستقل نال هستند*/
	delete from  [Cntr].[tblFactorMostaghel]
	where   [fldFactorId] = @fldId and fldBudjeCodingId is null and fldAshkhasId is null and fldTankhahGroupId is null



	COMMIT
end try

begin catch
 rollback
select @er=max(fldid)+1 from com.tblError
insert into com. tblError([fldId], [fldUserName], [fldMatn], [fldTarikh], [fldIP], [fldUserId], [fldDesc], [fldDate])
	SELECT @er, fldUserName, ERROR_MESSAGE(), cast(GETDATE() as date), @fldIP, @fldUserId, @fldDesc, GETDATE()
	from com.tblUser where fldid=@fldUserId

end catch
GO
