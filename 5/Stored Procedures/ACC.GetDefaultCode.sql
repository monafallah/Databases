SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[GetDefaultCode]
@AccountTypeId int,
@PCode varchar(100),
@TempNameId int
as
--declare @AccountTypeId int=1,@PCode varchar(100)='103001'
declare @Code varchar(100)='',@Len int=0,@Argham int=0,@LevelId int=0,@LevelName nvarchar(100)='',@PLen int=0,@PArgham int=0,@LevelChild int=0
declare @CheckCode table(coding varchar(100),PId hierarchyid,NextCode varchar(100))
/*تعریف گروه*/
if(@PCode='')
begin
	/**/
	select top(1) @Argham=fldArghumNum,@LevelId=fldId,@LevelName=fldName from ACC.tblLevelsAccountingType where fldAccountTypeId=@AccountTypeId
	order by fldId
	/*اگر چندین گروه تعریف شده باشد*/
	if exists( select * from Acc.tblTemplateCoding where fldLevelsAccountTypId=@LevelId and fldTempNameId=@TempNameId) 
	begin 
		insert @CheckCode
		select fldCode ,fldTempCodeId,LEAD(fldCode) over (partition by fldTempCodeId order by fldCode) from Acc.tblTemplateCoding 
		where fldLevelsAccountTypId=@LevelId and fldTempNameId=@TempNameId
		select top(1) @Code=REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') from( SELECT  coding,
					CASE
					WHEN NextCode is NULL THEN coding
					WHEN (coding = NextCode - 1) THEN coding
					ELSE coding + '*'
					END as CheckNumber
					from @CheckCode
		)t
		where CheckNumber like '%*%'
		ORDER BY coding, CheckNumber
		select case when @Code<>'' then @Code else (select top(1) REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') from @CheckCode order by coding desc) end as fldCode,@LevelId as LevelId ,@LevelName fldLevelName
	end
	/*اگر هیچ گروهی تعریف نشده باشد*/
	else if(@Code='')
	begin
		set @Code='1'
		set @Code=REPLACE(STR(@Code, @Argham), SPACE(1), '0')
		select ISNULL(@Code,'') fldCode,@LevelId as LevelId ,@LevelName fldLevelName
	end
end
else
begin
	select @LevelId=fldLevelsAccountTypId from Acc.tblTemplateCoding where fldPCod=@PCode and fldTempNameId=@TempNameId
	/*اگر فرزندی برای گره پدر تعریف نشذه باشذ*/
	if(@LevelId=0 or @LevelId is null)
	begin
		select @LevelId=fldLevelsAccountTypId from ACC.tblTemplateCoding
		where fldCode=@PCode and fldTempNameId=@TempNameId
		select top(1) @Argham=fldArghumNum,@LevelName=fldName,@LevelChild=fldId from ACC.tblLevelsAccountingType 
		where fldAccountTypeId=@AccountTypeId and fldId>@LevelId order by fldId
		set @Code='1'
		set @Code=@PCode+REPLACE(STR(@Code, @Argham), SPACE(1), '0')
		select ISNULL(@Code,'') as fldCode,@LevelChild as LevelId ,@LevelName fldLevelName
	end
	/*اولین گپ کدینگ در گره های فرزند*/
	else
	begin
		select @LevelName=fldName,@Argham=fldArghumNum from ACC.tblLevelsAccountingType where fldId=@LevelId
		insert @CheckCode
		select fldCode ,fldTempCodeId,LEAD(fldCode) over (partition by fldTempCodeId order by fldCode) from Acc.tblTemplateCoding 
		where fldLevelsAccountTypId=@LevelId and fldPCod=@PCode and fldTempNameId=@TempNameId
		set @Code='1'
		set @Code=@PCode+ REPLACE(STR(@Code, @Argham), SPACE(1), '0')
		if not exists(select * from @CheckCode where coding=@Code)
		begin 
			select @Code as fldCode,@LevelId as LevelId ,@LevelName fldLevelName 
		end
		else
		begin
			set @Code=''
			select top(1) @Code=REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') from( SELECT  coding,
						CASE
						WHEN NextCode is NULL THEN coding
						WHEN (coding = NextCode - 1) THEN coding
						ELSE coding + '*'
						END as CheckNumber
						from @CheckCode
			)t
			where CheckNumber like '%*%'
			ORDER BY coding, CheckNumber
			select case when @Code<>'' then @Code else (select top(1) REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') from @CheckCode order by coding desc) end as fldCode,@LevelId as LevelId ,@LevelName fldLevelName
		end
	end
end
GO
