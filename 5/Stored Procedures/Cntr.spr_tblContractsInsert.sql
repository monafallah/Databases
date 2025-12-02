SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContractsInsert] 
 
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

	
	BEGIN TRAN
	set @fldSubject=com.fn_TextNormalize(@fldSubject)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@flag bit=0,@Cid int
	select @fldID =ISNULL(max(fldId),0)+1 from [cntr].[tblContracts] 

	INSERT INTO [cntr].[tblContracts] ([fldId], [fldContractTypeId], [fldNaghshOrgan], [fldTarikh], [fldShomare], [fldSubject], [fldTarikhEblagh], [fldShomareEblagh], [fldAshkhasId], [fldMablagh],fldSuplyMaterialsType, [fldStartDate], [fldEndDate], [fldMandePardakhtNashode], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate])
	SELECT @fldId, @fldContractTypeId, @fldNaghshOrgan, @fldTarikh, @fldShomare, @fldSubject, @fldTarikhEblagh, @fldShomareEblagh, @fldAshkhasId, @fldMablagh,@fldSuplyMaterialsType, @fldStartDate, @fldEndDate, @fldMandePardakhtNashode, @fldUserId, @fldOrganId, @fldIP, @fldDesc, getdate()
	if(@@Error<>0)
	begin
        rollback  
		set @flag=1   
	end	 
	if (@flag=0) and @fldBudjeCodingId_Detail is not null
	begin
		select @Cid =ISNULL(max(fldId),0)+1 from [cntr].tblContract_CodingBudje
		insert into [cntr].tblContract_CodingBudje 
		select @Cid,@fldBudjeCodingId_Detail,@fldId
		if(@@Error<>0)
	 	begin
			rollback     
		end	
	end
	COMMIT
GO
