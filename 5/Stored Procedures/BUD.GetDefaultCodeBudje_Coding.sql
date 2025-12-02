SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[GetDefaultCodeBudje_Coding]
@fldHeaderId INT,
@PCode varchar(100)

AS 
BEGIN 
--declare @fldHeaderId INT=2,@PCode varchar(100)='20103'
DECLARE @fldOrganId INT,@fldYear SMALLINT
DECLARE @Argham int=0,@LevelName nvarchar(100)='',@LevelId INT=0,@Code varchar(100)='',@LevelChild int=0,@NodLevel int=0
declare @CheckCode table(coding varchar(100),PId hierarchyid,NextCode varchar(100),LevelId int,NodLevel tinyint)
declare @level table (id int,nod tinyint)
select @fldOrganId=h.fldOrganId,@fldYear=fldYear from bud.tblCodingBudje_Header as h
where h.fldHedaerId=@fldHeaderId

--insert into @level
--select c.fldid,ROW_NUMBER()over(order by fldYear,fldOrganId)  from bud.tblCodingLevel as c
-- inner join Acc.tblFiscalYear as f on f.fldId=c.fldFiscalBudjeId
--  WHERE c.fldOrganId=@fldOrganId and fldYear=@fldYear
 
IF (@PCode='')
begin
SELECT TOP(1) @Argham=fldArghamNum,@LevelId=c.fldId,@LevelName=fldName
 FROM bud.tblCodingLevel as c
 inner join Acc.tblFiscalYear as f on f.fldId=c.fldFiscalBudjeId
  WHERE c.fldOrganId=@fldOrganId and fldYear=@fldYear
ORDER BY c.fldId

IF EXISTS(SELECT * FROM bud.tblCodingBudje_Details WHERE fldCodeingLevelId=@LevelId and fldHeaderId=@fldHeaderId)
	BEGIN
	--SELECT * FROM bud.tblCodingBudje_Details WHERE fldCodeingLevelId=@LevelId and fldHeaderId=@fldHeaderId

		INSERT @CheckCode
		SELECT fldCode,fldhierarchyidId,LEAD(fldCode) over (partition by fldhierarchyidId order by fldCode),fldCodeingLevelId,fldLevelId FROM bud.tblCodingBudje_Details
		where fldCodeingLevelId=@LevelId and fldHeaderId=@fldHeaderId
		select top(1) @Code=REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') ,@NodLevel=Nodlevel from( SELECT  coding,
							CASE
							WHEN NextCode is NULL THEN coding
							WHEN (coding = NextCode -1 ) THEN coding
							ELSE coding + '*'
							END as CheckNumber
							,LevelId,NodLevel
							from @CheckCode
				)t
				where CheckNumber like '%*%'
				ORDER BY coding, CheckNumber
				--select * from @CheckCode
			select case when @Code<>'' then @Code else (select top(1) REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') 
			from @CheckCode	order by coding desc) end as fldCode
			,case when @NodLevel<>'' then @NodLevel else (select top(1) NodLevel from @CheckCode order by coding desc) end as NodLevel
			,@LevelId as LevelId ,@LevelName fldLevelName
	END
	else if(@Code='')
		begin
			set @Code='1'
			set @Code=REPLACE(STR(@Code, @Argham), SPACE(1), '0')
			select ISNULL(@Code,'') fldCode,@NodLevel+1 as NodLevel,@LevelId+1 as LevelId ,@LevelName fldLevelName
		end
	end
else
begin
	select @LevelId=c.fldCodeingLevelId,@NodLevel=c.fldLevelId from bud.tblCodingBudje_Details p
	inner join bud.tblCodingBudje_Details c on c.fldhierarchyidId.GetAncestor(1)=p.fldhierarchyidId and c.fldHeaderId=p.fldHeaderId
	where p.fldBudCode=@PCode and p.fldHeaderId=@fldHeaderId

	--select @LevelId as l,@NodLevel
	/*اگر فرزندی برای گره پدر تعریف نشذه باشذ*/
	if(@LevelId=0 or @LevelId is null)
	begin
	select @LevelId=fldCodeingLevelId,@NodLevel=fldLevelId from bud.tblCodingBudje_Details
		where fldBudCode=@PCode and fldHeaderId=@fldHeaderId


		select top(1) @Argham=fldArghamNum,@LevelName=fldName,@LevelChild=c.fldId 
		from bud.tblCodingLevel  as c
		inner join Acc.tblFiscalYear as f on f.fldId=c.fldFiscalBudjeId
		where c.fldId>@LevelId and  c.fldOrganId=@fldOrganId and f.fldYear=@fldYear
		order by c.fldId

		

		set @Code='1'
		set @Code=@PCode+REPLACE(STR(@Code, @Argham), SPACE(1), '0')
		select ISNULL(@Code,'') as fldCode,@NodLevel+1 as NodLevel,@LevelChild as LevelId ,@LevelName fldLevelName
	end
	/*اولین گپ کدینگ در گره های فرزند*/
	ELSE
	
	begin
	--select @LevelId
		select @LevelName=fldName,@Argham=fldArghamNum from bud.tblCodingLevel  as c
		inner join Acc.tblFiscalYear as f on f.fldId=c.fldFiscalBudjeId
		where c.fldId=@LevelId and c.fldOrganId=@fldOrganId and f.fldYear=@fldYear
		insert @CheckCode
		select ss.fldBudCode ,ss.fldhierarchyidId,LEAD(ss.fldCode) over (partition by ss.fldhierarchyidId order by ss.fldCode),ss.fldCodeingLevelId ,ss.fldLevelId
		from bud.tblCodingBudje_Details   p
		inner join bud.tblCodingBudje_Details ss on ss.fldhierarchyidId.GetAncestor(1)=p.fldhierarchyidId and ss.fldHeaderId=p.fldHeaderId
		where /*fldCodeingLevelId=@LevelId+1 and fldBudCode like @PCode+'%'*/
		p.fldBudCode=@PCode
		and p.fldHeaderId=@fldHeaderId
		--select * from @CheckCode

		set @Code='1'
		set @Code=@PCode+ REPLACE(STR(@Code, @Argham), SPACE(1), '0')

		--select @Code,@Argham as ar
		if not exists(select * from @CheckCode where coding=@Code)
		begin 
			--select @Code
			--select @NodLevel=fldLevelId from bud.tblCodingBudje_Details 
			--where fldCodeingLevelId=@LevelId and fldBudCode=@PCode and fldHeaderId=@fldHeaderId
			select @Code as fldCode,@NodLevel as NodLevel,@LevelId as LevelId ,(select fldName from bud.tblCodingLevel where fldid=@LevelId) fldLevelName 

		end
		else
		begin

			set @Code=''
			select top(1) @Code=REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0'),@NodLevel=NodLevel from( SELECT  coding,
						CASE
						WHEN NextCode is NULL THEN coding
						WHEN (coding = NextCode - 1) THEN coding
						ELSE coding + '*'
						END as CheckNumber
						,LevelId,NodLevel
						from @CheckCode
			)t
			where CheckNumber like '%*%'
			ORDER BY coding, CheckNumber

			select case when @Code<>'' then @Code else (select top(1) REPLACE(STR(cast(coding as bigint)+1, LEN(coding)), SPACE(1), '0') 
			from @CheckCode order by coding desc) end as fldCode
			,case when @NodLevel<>'' then @NodLevel else (select top(1) NodLevel	from @CheckCode order by coding desc) end as NodLevel
			,@LevelId as LevelId ,(select fldName from bud.tblCodingLevel where fldid=@LevelId) fldLevelName 
		end
	end
end
end
GO
