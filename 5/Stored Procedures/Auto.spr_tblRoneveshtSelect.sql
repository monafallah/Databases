SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblRoneveshtSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldid], [fldLetterId], /*[fldAshkhasHoghoghiId], */ fldAshkhasHoghoghiTitlesId ,[fldCommisionId], cast([fldAssignmentTypeId] as varchar(10))fldAssignmentTypeId, [fldText], [fldDate], [fldUserId], [fldOrganId], [fldDesc], [fldIP] 
	,isnull(com.fldName,titlesHoghoghi.fldName)fldName
	,case when fldCommisionId is not null then cast(fldCommisionId as varchar(10))+'|1'
	--when fldAshkhasHoghoghiId is not null then cast(fldAshkhasHoghoghiId as varchar(10))+'|2' 
	when fldAshkhasHoghoghiTitlesId is not null then  cast(fldAshkhasHoghoghiTitlesId as varchar(10))+'|2'
	end as fldId_Type

	FROM   [Auto].[tblRonevesht] 
	outer apply (select tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle +')' as fldName from auto. tblCommision 
	inner join   com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					  where fldCommisionId=tblCommision.fldid)com
					 /* outer apply (select fldName from com.tblAshkhaseHoghoghi
					  where tblAshkhaseHoghoghi.fldid=fldAshkhasHoghoghiId)hoghoghi*/
					  outer apply (select t.fldName from auto.tblAshkhaseHoghoghiTitles t
										where t.fldid=fldAshkhasHoghoghiTitlesId
								)titlesHoghoghi
	WHERE  fldid=@Value AND fldOrganId=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldid], [fldLetterId], /*[fldAshkhasHoghoghiId], */ fldAshkhasHoghoghiTitlesId ,[fldCommisionId], cast([fldAssignmentTypeId] as varchar(10))fldAssignmentTypeId, [fldText], [fldDate], [fldUserId], [fldOrganId], [fldDesc], [fldIP] 
	,isnull(com.fldName,titlesHoghoghi.fldName)fldName
	,case when fldCommisionId is not null then cast(fldCommisionId as varchar(10))+'|1'
	--when fldAshkhasHoghoghiId is not null then cast(fldAshkhasHoghoghiId as varchar(10))+'|2' 
	when fldAshkhasHoghoghiTitlesId is not null then  cast(fldAshkhasHoghoghiTitlesId as varchar(10))+'|2'
	end as fldId_Type

	FROM   [Auto].[tblRonevesht] 
	outer apply (select tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle +')' as fldName from auto. tblCommision 
	inner join   com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					  where fldCommisionId=tblCommision.fldid)com
					 /* outer apply (select fldName from com.tblAshkhaseHoghoghi
					  where tblAshkhaseHoghoghi.fldid=fldAshkhasHoghoghiId)hoghoghi*/
					  outer apply (select t.fldName from auto.tblAshkhaseHoghoghiTitles t
										where t.fldid=fldAshkhasHoghoghiTitlesId
								)titlesHoghoghi

	WHERE  fldDesc like @Value  AND fldOrganId=@organId

	if (@FieldName='fldLetterId')
	SELECT top(@h) [fldid], [fldLetterId], /*[fldAshkhasHoghoghiId], */ fldAshkhasHoghoghiTitlesId ,[fldCommisionId], cast([fldAssignmentTypeId] as varchar(10))fldAssignmentTypeId, [fldText], [fldDate], [fldUserId], [fldOrganId], [fldDesc], [fldIP] 
	,isnull(com.fldName,titlesHoghoghi.fldName)fldName
	,case when fldCommisionId is not null then cast(fldCommisionId as varchar(10))+'|1'
	--when fldAshkhasHoghoghiId is not null then cast(fldAshkhasHoghoghiId as varchar(10))+'|2' 
	when fldAshkhasHoghoghiTitlesId is not null then  cast(fldAshkhasHoghoghiTitlesId as varchar(10))+'|2'
	end as fldId_Type

	FROM   [Auto].[tblRonevesht] 
	outer apply (select tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle +')' as fldName from auto. tblCommision 
	inner join   com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					  where fldCommisionId=tblCommision.fldid)com
					 /* outer apply (select fldName from com.tblAshkhaseHoghoghi
					  where tblAshkhaseHoghoghi.fldid=fldAshkhasHoghoghiId)hoghoghi*/
					  outer apply (select t.fldName from auto.tblAshkhaseHoghoghiTitles t
										where t.fldid=fldAshkhasHoghoghiTitlesId
								)titlesHoghoghi
	WHERE  fldLetterId like @Value  AND fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) [fldid], [fldLetterId], /*[fldAshkhasHoghoghiId], */ fldAshkhasHoghoghiTitlesId ,[fldCommisionId], cast([fldAssignmentTypeId] as varchar(10))fldAssignmentTypeId, [fldText], [fldDate], [fldUserId], [fldOrganId], [fldDesc], [fldIP] 
	,isnull(com.fldName,titlesHoghoghi.fldName)fldName
	,case when fldCommisionId is not null then cast(fldCommisionId as varchar(10))+'|1'
	--when fldAshkhasHoghoghiId is not null then cast(fldAshkhasHoghoghiId as varchar(10))+'|2' 
	when fldAshkhasHoghoghiTitlesId is not null then  cast(fldAshkhasHoghoghiTitlesId as varchar(10))+'|2'
	end as fldId_Type

	FROM   [Auto].[tblRonevesht] 
	outer apply (select tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle +')' as fldName from auto. tblCommision 
	inner join   com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					  where fldCommisionId=tblCommision.fldid)com
					 /* outer apply (select fldName from com.tblAshkhaseHoghoghi
					  where tblAshkhaseHoghoghi.fldid=fldAshkhasHoghoghiId)hoghoghi*/
					  outer apply (select t.fldName from auto.tblAshkhaseHoghoghiTitles t
										where t.fldid=fldAshkhasHoghoghiTitlesId
								)titlesHoghoghi
	where   fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldid], [fldLetterId], /*[fldAshkhasHoghoghiId], */ fldAshkhasHoghoghiTitlesId ,[fldCommisionId], cast([fldAssignmentTypeId] as varchar(10))fldAssignmentTypeId, [fldText], [fldDate], [fldUserId], [fldOrganId], [fldDesc], [fldIP] 
	,isnull(com.fldName,titlesHoghoghi.fldName)fldName
	,case when fldCommisionId is not null then cast(fldCommisionId as varchar(10))+'|1'
	--when fldAshkhasHoghoghiId is not null then cast(fldAshkhasHoghoghiId as varchar(10))+'|2' 
	when fldAshkhasHoghoghiTitlesId is not null then  cast(fldAshkhasHoghoghiTitlesId as varchar(10))+'|2'
	end as fldId_Type

	FROM   [Auto].[tblRonevesht] 
	outer apply (select tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle +')' as fldName from auto. tblCommision 
	inner join   com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					  where fldCommisionId=tblCommision.fldid)com
					 /* outer apply (select fldName from com.tblAshkhaseHoghoghi
					  where tblAshkhaseHoghoghi.fldid=fldAshkhasHoghoghiId)hoghoghi*/
					  outer apply (select t.fldName from auto.tblAshkhaseHoghoghiTitles t
										where t.fldid=fldAshkhasHoghoghiTitlesId
								)titlesHoghoghi
	where   fldOrganId=@organId


	COMMIT
GO
