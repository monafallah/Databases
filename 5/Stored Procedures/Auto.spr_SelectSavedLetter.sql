SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SelectSavedLetter](@fieldname nvarchar(50),@h int,@start nvarchar(10),@end nvarchar(10),@BoxId nvarchar(10),@value nvarchar(max),@organId int,@TabagheBandiId int)
as 
----declare @fieldname nvarchar(50)='',@h int=10,@start nvarchar(10)='',@end nvarchar(10)='',@BoxId nvarchar(10)=1,@value nvarchar(max)='',@organId int=1
set @value=replace(@value,'""','')
set @value=replace(@value,'|','''')
if(@h=0) set @h=2147483647
declare @text1 nvarchar(max)='' ,@text2 nvarchar(max)='',@text3 nvarchar(max)=''

if (@fieldname='')
begin
set @text1='
;with box as 
(	select fldID,fldPID from auto.tblBox
	where fldid='+@BoxId+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblbox.fldID,tblbox.fldPID  from auto.tblbox 
	inner join box on tblbox.fldPID=box.fldid
)
select top('+cast(@h as varchar(20))+')  * from (select  letter.fldid as fldLetterId,NULL as fldMessageId,fldSubject,fldLetterNumber,fldLetterDate,
fldCreatedDate,tblLetterStatus.fldName as fldLetterStatus,tblImmediacy.fldName  as fldImmediacyName,
fldLetterType,fldLetterTypeID,isnull(archive,0) as HaveArchiv,cast(fldOrderId as varchar(10))fldOrderId
,isnull(Attachment,0)HaveAttach,Auto.tblSecurityType.fldSecurityType,fldKeywords,letter.fldDesc
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
  ,tblImmediacy.fldFileId as  fldImmediacyID
 from auto.tblLetter letter'
set @text2=@text1+' inner join auto.tblLetterBox on fldLetterID=letter.fldid
inner join auto.tblLetterStatus on fldLetterStatusID=tblLetterStatus.fldid
inner join Auto.tblImmediacy on fldImmediacyID=tblImmediacy.fldID
inner join Auto.tblLetterType on fldLetterTypeID=tblLetterType.fldID
inner join auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid
inner join box x on x.fldid=fldBoxID
outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=letter.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=letter.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = Auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =letter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =letter.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2'
set @text3=@text2+' outer apply (select stuff((SELECT ''/'' + auto.tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =letter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =letter.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
where not exists (select * from auto.tblAssignment
where fldLetterId=letter.fldId)
)t
where 1=1'

if (@value<>'')
set @text3=@text3 +' '+@value 

set @text3=@text3 +' 
group by fldLetterId,fldMessageId,fldSubject,fldLetterNumber,fldLetterDate,fldCreatedDate,fldLetterStatus,fldImmediacyName,fldLetterType
,HaveArchiv,HaveAttach,fldOrderId,fldSecurityType,fldKeywords,fldCommision,LetterRecievers,  fldImmediacyID ,fldLetterTypeID,fldDesc
order by fldletterid desc'
--select @text3
end
if (@fieldname='TabagheBandi')
begin
set @text1='
;with TabagheBandi as 
(	select fldID,fldPID from auto.tblTabagheBandi
	where fldid='+cast(@TabagheBandiId as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblTabagheBandi.fldID,tblTabagheBandi.fldPID  from auto.tblTabagheBandi 
	inner join TabagheBandi on tblTabagheBandi.fldPID=TabagheBandi.fldid 
)
select top('+cast(@h as varchar(20))+')  * from (select  letter.fldid as fldLetterId,NULL as fldMessageId,fldSubject,fldLetterNumber,fldLetterDate,
fldCreatedDate,tblLetterStatus.fldName as fldLetterStatus,tblImmediacy.fldName  as fldImmediacyName,
fldLetterType,fldLetterTypeID,isnull(archive,0) as HaveArchiv,cast(fldOrderId as varchar(10))fldOrderId
,isnull(Attachment,0)HaveAttach,Auto.tblSecurityType.fldSecurityType,fldKeywords,letter.fldDesc
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
  ,tblImmediacy.fldFileId as  fldImmediacyID
 from auto.tblLetter letter'
set @text2=@text1+' inner join auto.tblLetterBox on fldLetterID=letter.fldid
inner join auto.tblLetterStatus on fldLetterStatusID=tblLetterStatus.fldid
inner join Auto.tblImmediacy on fldImmediacyID=tblImmediacy.fldID
inner join Auto.tblLetterType on fldLetterTypeID=tblLetterType.fldID
inner join auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
auto.tblLetterTabagheBandi on letter.fldid=tblLetterTabagheBandi.fldLetterId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblLetterBox.fldBoxId=tblBox.fldid)box
outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=letter.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=letter.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = Auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =letter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =letter.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2'
set @text3=@text2+' outer apply (select stuff((SELECT ''/'' + auto.tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =letter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =letter.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
where not exists (select * from auto.tblAssignment
where fldLetterId=letter.fldId)
)t
where 1=1'

if (@value<>'')
set @text3=@text3 +' '+@value 

set @text3=@text3 +' 
group by fldLetterId,fldMessageId,fldSubject,fldLetterNumber,fldLetterDate,fldCreatedDate,fldLetterStatus,fldImmediacyName,fldLetterType
,HaveArchiv,HaveAttach,fldOrderId,fldSecurityType,fldKeywords,fldCommision,LetterRecievers,  fldImmediacyID ,fldLetterTypeID,fldDesc
order by fldletterid desc'
--select @text3
end
execute (@text3)
GO
