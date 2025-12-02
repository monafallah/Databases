SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblTozinSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@Value2 nvarchar(50),
@Aztarikh varchar(20),
@Tatarikh varchar(20),
@h int
as
begin tran
--declare  @FieldName nvarchar(50)='fldNameBaskool',
--@Value nvarchar(50)=N'%حج%',
--@organId int=1,
--@Aztarikh varchar(20)='1401/01/01',
--@Tatarikh varchar(20)='1401/01/01',
--@h int=0
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	declare  @h1 varchar(15)=cast(@h as varchar(15))
	set @value=N''+@value+''


declare @Query nvarchar(max)=''
/*SELECT top(@h) tblTozin.[fldId], [fldWeighbridgeId], [fldMaxW], [fldPlaqueId], [fldHour], [fldStartDate], [fldEndDate], 
	 tblTozin.[fldDate],
	isnull(tblPlaque.fldPlaque,'')fldPlaque,w.fldName as fldNameBaskool,d.fldTarikh+' '+cast(cast(fldStartDate as time(0)) as varchar(8))as fldTarikhShoroo
	,d1.fldTarikh+' '+cast(cast(fldEndDate as time(0))as varchar(8))as fldTarikhPayan,d2.fldTarikh+' '+cast(cast(fldHour as time(0))as varchar(8))fldSaat
	FROM   [Weigh].[tblTozin] 
	inner join com.tblPlaque on tblPlaque.fldid=fldPlaqueId
	inner join Weigh.tblWeighbridge w on w.fldid=fldWeighbridgeId
	inner join com.tblDateDim d on d.fldDate=cast(fldStartDate as date)
	inner join com.tblDateDim d1 on d1.fldDate=cast(fldEndDate as date)
	inner join com.tblDateDim d2 on d2.fldDate=cast(fldHour as date)
	*/

set @Query='SELECT  tblTozin.[fldId], [fldWeighbridgeId], [fldMaxW], [fldPlaqueId], [fldHour], [fldStartDate], [fldEndDate], 
	tblTozin.[fldDate], 
	isnull(cast(fldSerialPlaque as varchar(10)),'''')+'' ''+isnull(tblPlaque.fldPlaque,'''')fldPlaque,w.fldName as fldNameBaskool,d.fldTarikh+'' ''+cast(cast(fldStartDate as time(0)) as varchar(8))as fldTarikhShoroo
	,d1.fldTarikh+'' ''+cast(cast(fldEndDate as time(0))as varchar(8))as fldTarikhPayan,d2.fldTarikh+'' ''+cast(cast(fldHour as time(0))as varchar(8))fldSaat
	FROM   [Weigh].[tblTozin] 
	
	inner join Weigh.tblWeighbridge w on w.fldid=fldWeighbridgeId
	inner join com.tblDateDim d on d.fldDate=cast(fldStartDate as date)
	inner join com.tblDateDim d1 on d1.fldDate=cast(fldEndDate as date)
	inner join com.tblDateDim d2 on d2.fldDate=cast(fldHour as date)
	left join com.tblPlaque on tblPlaque.fldid=fldPlaqueId
	where 1=1'

if (@Aztarikh<>'' and @Tatarikh<>'')
set @Query=@Query+ ' and d2.fldTarikh between '''+@Aztarikh+''' and '''+@Tatarikh+''''

else if (@Aztarikh<>'' and @Tatarikh='')
set @Query=@Query+ ' and d2.fldTarikh >='''+@Aztarikh+''''

else if (@Aztarikh='' and @Tatarikh<>'')
set @Query=@Query+ ' and d2.fldTarikh <='''+@Tatarikh+''''

set @Query=' select top('+@h1+') * from ('+@Query +')t where 1=1'


if (@FieldName='fldId')
set @Query=@Query+' and [Weigh].[tblTozin].fldId like '+@value 

if (@FieldName='WeighbridgeId_PlaqueId')
set @Query=@Query+' and fldWeighbridgeId ='+@value + ' and  fldPlaqueId= '+ @Value2+ ' order by fldHour desc'


if (@FieldName='fldDesc')

set @Query=@Query+' and [Weigh].[tblTozin].fldDesc like N'''+@value+'''' 

if (@FieldName='fldWeighbridgeId')

set @Query=@Query+' and fldWeighbridgeId like '+@value 

 if (@FieldName='fldPlaqueId')

set @Query=@Query+' and fldPlaqueId like '+@value 

if (@FieldName='fldPlaque')

set @Query=@Query+' and fldPlaque like N'''+@value+'''' 

if (@FieldName='fldNameBaskool')

set @Query=@Query+' and fldNameBaskool like N'''+@value+''''

if (@FieldName='fldTarikhShoroo')

set @Query=@Query+' and fldTarikhShoroo like N'''+@value+''''


if (@FieldName='fldTarikhPayan')

set @Query=@Query+' and fldTarikhPayan like N'''+@value+''''
	
 if (@FieldName='fldMaxW')

set @Query=@Query+' and fldMaxW like '''+@value +''''

	
if (@FieldName='fldSaat')

set @Query=@Query+' and fldSaat like N'''+@value+''''

if (@FieldName='')

set @Query=@Query
	
if (@FieldName='fldOrganId')

set @Query=@Query

set @Query=@Query+' order by fldId desc'
--set @Query=@Query
--select @Query
execute (@Query)
commit

GO
