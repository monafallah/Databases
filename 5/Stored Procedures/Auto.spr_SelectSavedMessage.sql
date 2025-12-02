SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SelectSavedMessage](@fieldName nvarchar(50),@h int,@start nvarchar(10),@end nvarchar(10),@BoxId nvarchar(10),@Value nvarchar(max),@organId int,@TabagheBandiId int)
as
--declare @fieldName nvarchar(50)='',@h int=10,@start nvarchar(10)='',@end nvarchar(10)='',@BoxId nvarchar(10)=z,@Value nvarchar(max)='',@organId int=1
set @value=replace(@value,'""','')
set @value=replace(@value,'|','''')
if(@h=0) set @h=2147483647
declare @text1 nvarchar(max)='' ,@text2 nvarchar(max)=''

if (@fieldName='')
begin
set @text1='
;with box as
(	select fldID,fldPID from auto.tblBox
		where fldid='+@BoxId+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblbox.fldID,tblbox.fldPID  from auto.tblbox 
	inner join box on tblbox.fldPID=box.fldid
)
select top('+cast(@h as varchar(20))+')  * from (select distinct fldTitle as fldTitleMessge ,m.fldid as fldMessageId,NULL as fldLetterId,m.fldMatn,d.fldtarikh,m.fldDesc
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,isnull(fldattach,0) as HaveAttach
from auto.tblMessage m
inner join com.tblDateDim d on d.flddate=cast(m.flddate as date)
inner join auto.tblletterbox on fldMessageId=m.fldid
inner join box on box.fldID=tblletterbox.fldBoxID
outer apply(select 1 fldattach from auto.tblMessageAttachment as a1 where a1.fldMessageId=m.fldID ) as tblattach
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =m.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1'
set @text2=@text1+' outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =m.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldMessageId  =m.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblCommision  on l.fldCommisionId=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =m.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
--where d.fldTarikh between @start and @end
where not exists (select * from auto.tblAssignment
where fldMessageId=m.fldId)
)t
where 1=1'
if (@value<>'')
set @text2= @text2 +' '+@value 

set @text2=@text2+' order by fldmessageid Desc'
--select @text2
end

if (@fieldName='TabagheBandi')
begin
set @text1='
;with TabagheBandi as 
(	select fldID,fldPID from auto.tblTabagheBandi
	where fldid='+cast(@BoxId as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblTabagheBandi.fldID,tblTabagheBandi.fldPID  from auto.tblTabagheBandi 
	inner join TabagheBandi on tblTabagheBandi.fldPID=TabagheBandi.fldid 
)
select top('+cast(@h as varchar(20))+')  * from (select fldTitle as fldTitleMessge ,m.fldid as fldMessageId,NULL as fldLetterId,m.fldMatn,d.fldtarikh,m.fldDesc
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,isnull(fldattach,0) as HaveAttach
from auto.tblMessage m
inner join com.tblDateDim d on d.flddate=cast(m.flddate as date)
inner join auto.tblletterbox on fldMessageId=m.fldid inner join
auto.tblLetterTabagheBandi on m.fldid=tblLetterTabagheBandi.fldMessageId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
outer apply(select 1 fldattach from auto.tblMessageAttachment as a1 where a1.fldMessageId=m.fldID ) as tblattach
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =m.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1'
set @text2=@text1+' outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =m.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldMessageId  =m.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblCommision  on l.fldCommisionId=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =m.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
--where d.fldTarikh between @start and @end
where not exists (select * from auto.tblAssignment
where fldMessageId=m.fldId)
)t
where 1=1'
if (@value<>'')
set @text2= @text2 +' '+@value 

set @text2=@text2+' order by fldmessageid Desc'
--select @text2
end


execute (@text2)
GO
