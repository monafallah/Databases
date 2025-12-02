SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[CheckValidCode_CodingDetail]
@HeaderId int,@Code varchar(100),@PCode varchar(100),@fldId int
as
--declare @AccountTypeId int=1,@Code varchar(100)='101003',@PCode varchar(100)='101'
declare @Len int=0,@Argham int=0,@LevelId int,@PLen int=0,@PArgham int=0,@LevelChildId int
,@OrganId int=0,@Year smallint=0
select @OrganId=fldOrganId,@Year=fldYear from acc.tblCoding_Header where fldId=@HeaderId
if exists(select * from ACC.tblCoding_Details where fldCode=@Code and fldId<>@fldId and fldHeaderCodId=@HeaderId)
begin
	select 1 as fldValid /*کد تکراری*/
end
else
begin
	set @Len=LEN(@Code)
	if(@PCode='')
	begin
		select top(1) @Argham=fldArghamNum from ACC.tblAccountingLevel where fldOrganId=@OrganId and fldYear=@Year
		order by fldId
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
		select @LevelId=fldAccountLevelId from ACC.tblCoding_Details
		where fldCode=@PCode and fldHeaderCodId=@HeaderId
		select top(1) @Argham=fldArghamNum,@LevelChildId=fldId from ACC.tblAccountingLevel 
		where fldId>@LevelId and fldOrganId=@OrganId and fldYear=@Year order by fldId
		select @Argham=sum(fldArghamNum) from ACC.tblAccountingLevel 
		where fldId<=@LevelChildId and fldOrganId=@OrganId and fldYear=@Year
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
