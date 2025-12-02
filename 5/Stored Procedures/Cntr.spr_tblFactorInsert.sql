SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorInsert] 
   
    @fldTarikh varchar(10),
    @fldShomare nvarchar(50),
    @fldShanaseMoadiyan nvarchar(50),
	@fldSharhSanad nvarchar(max), 
	@fldContractId int,
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
	declare @fldid int,@detailid int,@er int,@Contract_FactorId int,@FactorMostaghelId int,@d nvarchar(50)
	,@Hoghoghiid int
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldSharhSanad=com.fn_TextNormalize(@fldSharhSanad)
	set @fldAddress=com.fn_TextNormalize(@fldAddress)
	--select top(1) @d=(fldSharhArtikl) from @Detail

	select @fldid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblFactor] 
	INSERT INTO [Cntr].[tblFactor] ([fldId], [fldTarikh], [fldShomare], [fldShanaseMoadiyan],fldSharhSanad, [fldStatus], [fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate],fldKasrBime,fldKasrHosnAnjamKar)
	SELECT @fldId, @fldTarikh, @fldShomare, @fldShanaseMoadiyan,@fldSharhSanad, 0, @fldOrganId, @fldUserId, @flddesc, @fldIP, getdate(),@fldKasrBime,@fldKasrHosnAnjamKar
	
	select @detailid=isnull(max(fldId),0)  FROM   [Cntr].[tblFactorDetail] 
	INSERT INTO [Cntr].[tblFactorDetail] ([fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId],fldSharhArtikl,fldTax, [fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate])
	SELECT ROW_NUMBER() over (order by (select 1))+@detailid, @fldId, fldMablagh, fldMablaghMaliyat, fldCodingDetailId,com.fn_TextNormalize( fldSharhArtikl),fldTax, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate()
	from @detail

	if (@fldContractId is not null)
	begin 
	select @Contract_FactorId=isnull(max(fldId),0)+1  FROM   [Cntr].[tblContract_Factor]
	select @fldProjectId=fldBudjeCodingId_Detail  FROM   [Cntr].tblContract_CodingBudje where fldContractId=@fldContractId
	INSERT INTO [Cntr].[tblContract_Factor] ([fldId], [fldContractId], [fldFactorId],[fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate])
	SELECT @Contract_FactorId, @fldContractId, @fldid, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate()
	end 
	if(@fldProjectId is not null or  @fldAshkhasId is not null or @fldTankhahGroupId is not null)
	begin
		select @FactorMostaghelId=isnull(max(fldId),0)+1  FROM   [Cntr].[tblFactorMostaghel]
		INSERT INTO [Cntr].[tblFactorMostaghel] ([fldId],[fldAshkhasId],[fldBudjeCodingId],[fldTankhahGroupId],[fldFactorId],[fldOrganId], [fldUserId], [fldDesc], [fldIP], [fldDate],fldtarikhVariz,fldQrCode)
		SELECT @FactorMostaghelId,@fldAshkhasId,@fldProjectId,@fldTankhahGroupId, @fldid, @fldOrganId, @fldUserId, @fldDesc, @fldIP, getdate(),@fldTarikhVariz,@fldQrCode
	end
	if (@fldShomareSabt is not null and @fldShomareSabt<>'' and @fldCodeEghtesadi  is not null and @fldCodeEghtesadi<>'' and @fldAddress  is not null and @fldAddress<>''  )
	begin 
		select @Hoghoghiid=fldHoghoghiId from com.tblAshkhas where fldid=@fldAshkhasId
		
		declare @H_Detailid int
		select @H_Detailid=isnull(max(fldid),0)+1from com.tblAshkhaseHoghoghi_Detail
		
		update com.tblAshkhaseHoghoghi
		set fldShomareSabt=@fldShomareSabt,fldUserId=@fldUserId,fldDate=getdate()
		where fldid=@Hoghoghiid

		MERGE com.tblAshkhaseHoghoghi_Detail t
			USING (select @Hoghoghiid hoghoghiid,@fldCodeEghtesadi codeEghtesadi,@fldaddress as fldAddress)s
		ON (s.hoghoghiid = t.fldAshkhaseHoghoghiId)
		WHEN MATCHED
			THEN UPDATE SET
				t. fldCodEghtesadi = s. codeEghtesadi,
				t. fldaddress = s. fldAddress
		WHEN NOT MATCHED BY TARGET
			THEN INSERT (    fldId, fldAshkhaseHoghoghiId, fldAddress, fldCodePosti, fldShomareTelephone, fldUserId, fldDesc, fldDate, fldCodEghtesadi)
				 VALUES (@H_Detailid,@Hoghoghiid,s.fldAddress,NULL,NULL,@flduserid,@fldDesc,getdate(),s.codeEghtesadi);
				 

	end
               
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
