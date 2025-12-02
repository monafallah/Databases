SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[CheckValidCode_CodingDetailBudje]
@HeaderId int,@Code varchar(100),@PCode varchar(100),@fldId int
as
--select 1 as fldValid 
--declare @AccountTypeId int=1,@Code varchar(100)='10403',@PCode varchar(100)='104',@fldId int=0,@HeaderId int=2
declare @Len int=0,@Argham int=0,@LevelId int,@PLen int=0,@PArgham int=0,@LevelChildId int
,@OrganId int=0,@Year smallint=0
select @OrganId=tblCodingBudje_Header.fldOrganId,@Year=fldYear from bud.tblCodingBudje_Header  where tblCodingBudje_Header.fldHedaerId=@HeaderId
if exists(select * from bud.tblCodingBudje_Details where fldBudCode=@Code and fldCodeingBudjeId<>@fldId and fldHeaderId=@HeaderId)
begin
	select 1 as fldValid /*کد تکراری*/
end
else
begin
	set @Len=LEN(@Code)
	if(@PCode='')
	begin
		select top(1) @Argham=fldArghamNum from bud.tblCodingLevel l inner join Acc.tblFiscalYear f
		on f.fldid=fldfiscalBudjeid
		 where l.fldOrganId=@OrganId and fldYear=@Year
		order by l.fldId
		if(@Len=@Argham)
		begin
			select 4 as fldValid /*کد معتبر*/
		end
		else
		begin
			select 2 as fldValid /*کد نامعتبر*/
		end
	end
	else if(@PCode<>'')
	begin
		select @LevelId=fldCodeingLevelId from bud.tblCodingBudje_Details
		where fldBudCode=@PCode and fldHeaderId=@HeaderId

		

		select top(1) @Argham=fldArghamNum,@LevelChildId=tblCodingLevel.fldId from bud.tblCodingLevel  inner join Acc.tblFiscalYear f
		on f.fldid=fldfiscalBudjeid
		where tblCodingLevel.fldId>@LevelId and tblCodingLevel.fldOrganId=@OrganId and fldYear=@Year
		 order by tblCodingLevel.fldId

		 
		select @Argham=sum(fldArghamNum) from bud.tblCodingLevel  inner join Acc.tblFiscalYear f
		on f.fldid=fldfiscalBudjeid
		where tblCodingLevel.fldId<=@LevelChildId and tblCodingLevel.fldOrganId=@OrganId and fldYear=@Year

	

		set @PLen=len(@PCode) 
		

		if(@Argham<>0)
		begin
			if(@Len=@Argham and SUBSTRING(@Code,1,@PLen)=@PCode)
			begin
				select 4 as fldValid /*کد معتبر*/
			end
			else
			begin
				select 2 as fldValid /*کد نامعتبر*/
			end
		end
		else
		begin
			select 3 as fldValid /*برای گره پدر فرزندی نمیتوان تعریف کرد*/
		end
	end
end
GO
