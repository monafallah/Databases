SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractsUpdate] 
    @fldId int,
    @fldContractTypeId int,
    @fldNaghshOrgan bit,
    @fldTarikh varchar(10),
    @fldShomare nvarchar(20),
    @fldSubject nvarchar(150),
    @fldTarikhEblagh varchar(10),
    @fldShomareEblagh nvarchar(20),
    @fldAshkhasId int,
    @fldMablagh bigint,
	@fldSuplyMaterialsType tinyint,
    @fldStartDate varchar(10),
    @fldEndDate varchar(10),
    @fldMandePardakhtNashode bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100),
	@fldBudjeCodingId_Detail int
AS 
begin try
	BEGIN TRAN
	declare @Cid int,@ErrorId int

	set @fldSubject=com.fn_TextNormalize(@fldSubject)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)

	if @fldBudjeCodingId_Detail is null
	begin
	delete from  [cntr].tblContract_CodingBudje 
	where fldcontractId=@fldid
	
	end
	if @fldBudjeCodingId_Detail is not  null and @fldBudjeCodingId_Detail <>0
	 and exists (select * from [cntr].tblContract_CodingBudje where fldcontractId=@fldid)
	begin
	update [cntr].tblContract_CodingBudje 
	set fldBudjeCodingId_Detail=@fldBudjeCodingId_Detail
	where fldcontractId=@fldid
		
	end
	if @fldBudjeCodingId_Detail is not  null and @fldBudjeCodingId_Detail <>0
	 and not exists (select * from [cntr].tblContract_CodingBudje where fldcontractId=@fldid)
	 begin
	select @Cid =ISNULL(max(fldId),0)+1 from [cntr].tblContract_CodingBudje
		insert into [cntr].tblContract_CodingBudje 
		select @Cid,@fldBudjeCodingId_Detail,@fldId
		   
			  
	end
	UPDATE [cntr].[tblContracts]
	SET    [fldContractTypeId] = @fldContractTypeId, [fldNaghshOrgan] = @fldNaghshOrgan, [fldTarikh] = @fldTarikh, [fldShomare] = @fldShomare, [fldSubject] = @fldSubject, [fldTarikhEblagh] = @fldTarikhEblagh, [fldShomareEblagh] = @fldShomareEblagh, [fldAshkhasId] = @fldAshkhasId,
	 [fldMablagh] = @fldMablagh,fldSuplyMaterialsType=@fldSuplyMaterialsType, [fldStartDate] = @fldStartDate, [fldEndDate] = @fldEndDate, [fldMandePardakhtNashode] = @fldMandePardakhtNashode, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId

	COMMIT
end try
begin catch
 rollback 
 select @ErrorId= max(fldid)+1 from com.tblError
 insert into com.tblError(fldid,fldMatn,fldTarikh,fldUserName,fldUserId,fldIP,fldDesc,fldDate)
 select @ErrorId,ERROR_MESSAGE(),cast(getdate() as date ) ,fldUserName,@fldUserId,@fldIP,@fldDesc,getdate() from com.tblUser where fldid=@fldUserId
end catch
GO
