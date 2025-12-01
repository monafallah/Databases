SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContactSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@UserId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

create table #users (id int)
;with users as(
select fldId from tblUser where fldUserId=@UserId and fldId<>@UserId
union all
select tblUser.fldId from tblUser
inner join users on users.fldId=tblUser.fldUserId
)
insert #users
select * from users
union
select @userId


	if (@FieldName='fldId')
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE  tblContact.fldId=@Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE  tblContact.fldId=@Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	
	union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE  tblContact.fldId=@Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/

	if (@FieldName='fldValue')
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE  tblContact.fldValue like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE  tblContact.fldValue like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	
	union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE  tblContact.fldValue like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/

if (@FieldName='NameTypeContact')
	SELECT top(@h)* from(select tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE  ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/

	
	/*union all
	
	SELECT tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE   ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/)t
where NameTypeContact like @Value

if (@FieldName='fldTyperName')
	SELECT top(@h)* from(select tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE  ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	union all
	
	SELECT tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE   ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/)t
where fldTyperName like @Value

if (@FieldName='fldname')
	SELECT top(@h)* from(select tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE fldname like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE     ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	
	union all
	
	SELECT tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE   ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/)t
where fldname like @Value

if (@FieldName='fldfamily')
	SELECT top(@h)  tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE fldfamily like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE  tblashkhasHoghooghi.fldName like @value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	
	union all
	
	SELECT tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE  tblMarakezTeb.fldTitle like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/

if (@FieldName='fldCodeMeli')
	SELECT top(@h)  tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE fldCodeMeli like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE  [fldNationalCode] like @Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/


	if (@FieldName='checkUserId')
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE  tblContact.fldUserId = @UserId and fldValue like @value/*and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE tblContact.fldUserId = @UserId and fldValue like @value /*and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/

	
	union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE  tblContact.fldUserId = @UserId and fldValue like @value  /*and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) */)*/

	if (@FieldName='')
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE    ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )
	
	/*union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId],
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName,[fldNationalCode],cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	union all
	
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE    ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/
	



	if (@FieldName='fldAshkhasId')
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldAshkhasId,
	 fldname,fldfamily,fldCodeMeli ,cast(0 as tinyint) fldTypeshakhs
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_Ashkhas  on fldContactId=tblContact.fldid
	inner join tblAshkhas on fldAshkhasId=tblAshkhas.fldid
	WHERE  fldAshkhasId=@Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
	or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )

	/*if (@FieldName='fldMarazekTebId')
		SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,fldMarazekTebId fldAshkhasId ,
	N'مراکز طب'fldname,tblMarakezTeb.fldTitle fldfamily,''fldCodeMeli,cast(2 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_MarakezTeb   on fldContactId=tblContact.fldid
	inner join tblMarakezTeb on fldMarazekTebId=tblMarakezTeb.fldid
	WHERE  fldMarazekTebId=@value and   ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/
	


/*if (@FieldName='fldAshkhasHoghooghiId')
	SELECT top(@h) tblContact.[fldId], [fldTypeContactId], [fldValue], tblContact.[fldType], [fldUserId], cast(tblContact.[fldTimeStamp]as int) fldTimeStamp
	,case when tblContact.fldType=0then N'عمومی'  when tblContact.fldType=1 then N'خصوصی'   when tblContact.fldType=2 then N'عمومی برای کاربران زیر شاخه' end fldTyperName
	,tblContanctType.fldType as NameTypeContact,fldfile,[fldAshkhasHoghooghiId] fldAshkhasId,
	N'اشخاص حقوقی'fldname,tblashkhasHoghooghi.fldName fldfamily,[fldNationalCode] fldCodeMeli,cast(1 as tinyint) fldTypeshakhs 
	FROM   [Cnt].[tblContact] inner join cnt.tblContanctType
	on fldTypeContactId=tblContanctType.fldid Inner join 
	tblFile on fldIconId=tblFile.fldId inner join 
	Cnt.tblContact_ashkhasHoghooghi   on fldContactId=tblContact.fldid
	inner join tblashkhasHoghooghi  on [fldAshkhasHoghooghiId]=tblashkhasHoghooghi.fldid
	WHERE fldAshkhasHoghooghiId=@Value and ((tblContact.fldType=0 )or (tblContact.fldType=1 and fldUserId=@userid)
or (tblContact.fldtype=2 and fldUserId in (select id from #Users)) )*/
COMMIT
GO
