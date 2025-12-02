SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[GetDefaultCode_Coding]
@fldHeaderCodId INT,
@PCode varchar(100)

AS 
BEGIN 
--declare @fldHeaderCodId INT=2,@PCode varchar(100)='1'
DECLARE @fldOrganId INT,@fldYear SMALLINT
DECLARE @Argham int=0,@LevelName nvarchar(100)='',@LevelId INT=0,@Code varchar(100)='',@LevelChild int=0
declare @CheckCode table(coding varchar(100),PId hierarchyid,NextCode varchar(100))

select @fldOrganId=fldOrganId,@fldYear=fldYear from Acc.tblCoding_Header where fldId=@fldHeaderCodId
 
IF (@PCode='')
begin
SELECT TOP(1) @Argham=fldArghamNum,@LevelId=ACC.tblAccountingLevel.fldId,@LevelName=fldName
 FROM ACC.tblAccountingLevel 
  WHERE fldOrganId=@fldOrganId and fldYear=@fldYear
ORDER BY ACC.tblAccountingLevel.fldId

IF EXISTS(SELECT * FROM ACC.tblCoding_Details WHERE fldAccountLevelId=@LevelId and fldHeaderCodId=@fldHeaderCodId)
	BEGIN
		INSERT @CheckCode
		SELECT fldCode,fldCodeId,LEAD(fldCode) over (partition by fldCodeId order by fldCode) FROM ACC.tblCoding_Details
		where fldAccountLevelId=@LevelId and fldHeaderCodId=@fldHeaderCodId
		select top(1) @Code=REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') from( SELECT  coding,
							CASE
							WHEN NextCode is NULL THEN coding
							WHEN (coding = NextCode -1 ) THEN coding
							ELSE coding + '*'
							END as CheckNumber
							from @CheckCode
				)t
				where CheckNumber like '%*%'
				ORDER BY coding, CheckNumber
			select case when @Code<>'' then @Code else (select top(1) REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') from @CheckCode
			 order by coding desc) end as fldCode,@LevelId as LevelId ,@LevelName fldLevelName
	END
	else if(@Code='')
		begin
			set @Code='1'
			set @Code=REPLACE(STR(@Code, @Argham), SPACE(1), '0')
			select ISNULL(@Code,'') fldCode,@LevelId as LevelId ,@LevelName fldLevelName
		end
	end
else
begin
	select @LevelId=fldAccountLevelId from Acc.tblCoding_Details where fldPCod=@PCode and fldHeaderCodId=@fldHeaderCodId
	/*اگر فرزندی برای گره پدر تعریف نشذه باشذ*/
	if(@LevelId=0 or @LevelId is null)
	begin
	select @LevelId=fldAccountLevelId from ACC.tblCoding_Details
		where fldCode=@PCode and fldHeaderCodId=@fldHeaderCodId
		select top(1) @Argham=fldArghamNum,@LevelName=fldName,@LevelChild=fldId from ACC.tblAccountingLevel 
		where fldId>@LevelId and  fldOrganId=@fldOrganId and fldYear=@fldYear
		order by fldId
			set @Code='1'
		set @Code=@PCode+REPLACE(STR(@Code, @Argham), SPACE(1), '0')
		select ISNULL(@Code,'') as fldCode,@LevelChild as LevelId ,@LevelName fldLevelName
	end
	/*اولین گپ کدینگ در گره های فرزند*/
	ELSE
	
	begin
		select @LevelName=fldName,@Argham=fldArghamNum from ACC.tblAccountingLevel where fldId=@LevelId and fldOrganId=@fldOrganId and fldYear=@fldYear
		insert @CheckCode
		select fldCode ,fldCodeId,LEAD(fldCode) over (partition by fldCodeId order by fldCode) from Acc.tblCoding_Details 
		where fldAccountLevelId=@LevelId and fldPCod=@PCode and fldHeaderCodId=@fldHeaderCodId
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
end
GO
