SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[CheckValidCode]
@AccountTypeId int,@Code varchar(100),@PCode varchar(100),@fldId int,@TempNameId int
as
--declare @AccountTypeId int=1,@Code varchar(100)='101003',@PCode varchar(100)='101'
declare @Len int=0,@Argham int=0,@LevelId int,@PLen int=0,@PArgham int=0,@LevelChildId int
if exists(select * from ACC.tblTemplateCoding where fldCode=@Code and fldId<>@fldId and fldTempNameId=@TempNameId)
begin
	select 1 as fldValid /*کد تکراری*/
end
else
begin
	set @Len=LEN(@Code)
	if(@PCode='')
	begin
		select top(1) @Argham=fldArghumNum from ACC.tblLevelsAccountingType where fldAccountTypeId=@AccountTypeId
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
		select @LevelId=fldLevelsAccountTypId from ACC.tblTemplateCoding
		where fldCode=@PCode and fldTempNameId=@TempNameId
		select top(1) @Argham=fldArghumNum,@LevelChildId=fldId from ACC.tblLevelsAccountingType 
		where fldId>@LevelId and fldAccountTypeId=@AccountTypeId order by fldId
		select @Argham=sum(fldArghumNum) from ACC.tblLevelsAccountingType 
		where fldId<=@LevelChildId and fldAccountTypeId=@AccountTypeId
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
