SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [Auto].[spr_SelectSent](@fieldName nvarchar(50),@h int,@start nvarchar(10),@end vARCHAR(10),@boxId int,@organId int,@Value nvarchar(max),@TabagheBandiId int)
as
--declare @fieldName nvarchar(50)='TabagheBandi',@h int=10,@start nvarchar(10)='',@end vARCHAR(10)='',@boxId int=2,@organId int=1,@Value nvarchar(max)='',@TabagheBandiId int=1
set @value=replace(@value,'""','')
set @value=replace(@value,'|','''')
if(@h=0) set @h=2147483647
declare @text1 nvarchar(max)='',@text2 nvarchar(max)='',@text3 nvarchar(max)='',@text4 nvarchar(max)='',@text5 nvarchar(max)='',@text6 nvarchar(max)=''
,@message nvarchar(10)=N'پیام'



if (@fieldName='')
begin
set @text1=';with box as 
(
	select fldid,fldPID from auto.tblbox
	where fldid='+cast(@boxid as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all

	select tblbox.fldid,tblbox.fldPID from auto.tblbox
	inner join box on tblbox.fldPID=box.fldid
)'
set @text2=@text1+ 'select top ('+cast(@h  as varchar(20))+') * from (select distinct  la.fldId as code,  la.fldId as fldLetterId,Null as fldMessageId,cast(fldOrderId as varchar(10))fldOrderId
,la.fldComisionID,fldSubject, tblLetterStatus.fldName AS fldLetterstatus, tblLetterType.fldLetterType
,fldLetterTypeID,isnull(Attachment,0)HaveAttach,tblAssignment.fldAssignmentDate fldAssignmentDate
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,fldSenderComisionID,tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate,
tblImmediacy.fldFileId as  fldImmediacyID,fldLetterDate,fldLetterNumber,isnull(archive,0) as HaveArchiv, tblImmediacy.fldName AS fldImmediacyName,
isnull(fldAssignmentTypeID,0)fldAssignmentTypeID, isnull(tblInternalAssignmentReceiver.fldID,0) as InternalAssignmentReceiverID, la.fldLetterStatusID,isnull( tblInternalAssignmentReceiver.fldAssignmentStatusID,0)fldAssignmentStatusID
,fldCreatedDate,fldSecurityType,la.fldDesc,fldKeywords
from  auto.tblletter la INNER JOIN 
Auto.tblAssignment ON la.fldID = tblAssignment.fldLetterID INNER JOIN
Auto.tblInternalAssignmentSender ON tblAssignment.fldID = tblInternalAssignmentSender.fldAssignmentID INNER JOIN
Auto.tblImmediacy ON la.fldImmediacyID = tblImmediacy.fldID INNER JOIN
Auto.tblLetterStatus ON la.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
Auto.tblLetterType ON la.fldLetterTypeID = tblLetterType.fldID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
box on box.fldid=tblInternalAssignmentsender.fldBoxID left JOIN
Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID '
set @text3=@text2+' outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=la.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=la.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =la.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =la.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =la.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =la.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2'
set @text4=@text3+' cross apply  (SELECT     tblAssignment_1.fldLetterID
FROM  auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
inner join box b1 on b1.fldid=tblInternalAssignmentsender_1.fldboxid
where  tblAssignment_1.fldLetterID=la.fldid)Assignment
--where tblAssignment.fldAssignmentDate between @start and @end
'

set @text5=@text4+' union all

select  distinct m.fldId as code, null as fldLetterId,m.fldid as fldMessageId,cast(''0'' as varchar(10))fldOrderId
,m.fldCommisionId fldComisionID, fldTitle fldSubject, '''' AS fldLetterstatus,N'''+@message+'''fldLetterType
,0 fldLetterTypeID,isnull(Attachment,0)HaveAttach,tblAssignment.fldAssignmentDate fldAssignmentDate
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,fldSenderComisionID,tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate,
0   fldImmediacyID,'''' fldLetterDate,'''' fldLetterNumber,0 as HaveArchiv, ''''AS fldImmediacyName,
isnull(fldAssignmentTypeID,0)fldAssignmentTypeID, isnull(tblInternalAssignmentReceiver.fldID,0)  as InternalAssignmentReceiverID, 0 fldLetterStatusID, isnull( tblInternalAssignmentReceiver.fldAssignmentStatusID,0)fldAssignmentStatusID
,fldTarikhShamsi fldCreatedDate,'''' fldSecurityType,m.fldDesc,'''' fldKeywords
from  auto.tblMessage m INNER JOIN 
Auto.tblAssignment ON m.fldID = tblAssignment.fldMessageId INNER JOIN
Auto.tblInternalAssignmentSender ON tblAssignment.fldID = tblInternalAssignmentSender.fldAssignmentID INNER JOIN
box on box.fldid=tblInternalAssignmentsender.fldBoxID left join 
Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID
outer apply (select 1  Attachment from auto.tblMessageAttachment a where a.fldMessageId=m.fldid) letterattach
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =m.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =m.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2'
set @text6=@text5+' outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
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
cross apply  (SELECT     tblAssignment_1.fldLetterID
FROM  auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
inner join box b1 on b1.fldid=tblInternalAssignmentsender_1.fldboxid
where  tblAssignment_1.fldMessageId=m.fldid)Assignment
--where tblAssignment.fldAssignmentDate between @start and @end
)t where 1=1 '

if (@value<>'')
set @text6=@text6+ '  '+ @Value

set @text6=@text6 + ' order by fldAssignmentDate desc'
end

if (@fieldName='TabagheBandi')
begin
set @text1=
';with TabagheBandi as 
(	select fldID,fldPID from auto.tblTabagheBandi
	where fldid='+cast(@TabagheBandiId as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblTabagheBandi.fldID,tblTabagheBandi.fldPID  from auto.tblTabagheBandi 
	inner join TabagheBandi on tblTabagheBandi.fldPID=TabagheBandi.fldid 
)'
set @text2=@text1+ 'select top ('+cast(@h  as varchar(20))+') * from (select distinct  la.fldId as code,  la.fldId as fldLetterId,Null as fldMessageId,cast(fldOrderId as varchar(10))fldOrderId
,la.fldComisionID,fldSubject, tblLetterStatus.fldName AS fldLetterstatus, tblLetterType.fldLetterType
,fldLetterTypeID,isnull(Attachment,0)HaveAttach,tblAssignment.fldAssignmentDate fldAssignmentDate
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,fldSenderComisionID,tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate,
tblImmediacy.fldFileId as  fldImmediacyID,fldLetterDate,fldLetterNumber,isnull(archive,0) as HaveArchiv, tblImmediacy.fldName AS fldImmediacyName,
isnull(fldAssignmentTypeID,0)fldAssignmentTypeID, isnull(tblInternalAssignmentReceiver.fldID,0) as InternalAssignmentReceiverID, la.fldLetterStatusID,isnull( tblInternalAssignmentReceiver.fldAssignmentStatusID,0)fldAssignmentStatusID
,fldCreatedDate,fldSecurityType,la.fldDesc,fldKeywords
from  auto.tblletter la INNER JOIN 
Auto.tblAssignment ON la.fldID = tblAssignment.fldLetterID INNER JOIN
Auto.tblInternalAssignmentSender ON tblAssignment.fldID = tblInternalAssignmentSender.fldAssignmentID INNER JOIN
Auto.tblImmediacy ON la.fldImmediacyID = tblImmediacy.fldID INNER JOIN
Auto.tblLetterStatus ON la.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
Auto.tblLetterType ON la.fldLetterTypeID = tblLetterType.fldID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
auto.tblLetterTabagheBandi on la.fldid=tblLetterTabagheBandi.fldLetterId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentSender.fldBoxid)box
left JOIN Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID '
set @text3=@text2+' outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=la.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=la.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =la.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =la.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =la.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =la.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2'
set @text4=@text3+' cross apply  (SELECT     tblAssignment_1.fldLetterID
FROM  auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
where  tblAssignment_1.fldLetterID=la.fldid and tblInternalAssignmentsender_1.fldboxid=box.fldid)Assignment
--where tblAssignment.fldAssignmentDate between @start and @end
'

set @text5=@text4+' union all

select distinct  m.fldId as code, null as fldLetterId,m.fldid as fldMessageId,cast(''0'' as varchar(10))fldOrderId
,m.fldCommisionId fldComisionID, fldTitle fldSubject, '''' AS fldLetterstatus,N'''+@message+'''fldLetterType
,0 fldLetterTypeID,isnull(Attachment,0)HaveAttach,tblAssignment.fldAssignmentDate fldAssignmentDate
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,fldSenderComisionID,tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate,
0   fldImmediacyID,'''' fldLetterDate,'''' fldLetterNumber,0 as HaveArchiv, ''''AS fldImmediacyName,
isnull(fldAssignmentTypeID,0)fldAssignmentTypeID, isnull(tblInternalAssignmentReceiver.fldID,0)  as InternalAssignmentReceiverID, 0 fldLetterStatusID, isnull( tblInternalAssignmentReceiver.fldAssignmentStatusID,0)fldAssignmentStatusID
,fldTarikhShamsi fldCreatedDate,'''' fldSecurityType,m.fldDesc,'''' fldKeywords
from  auto.tblMessage m INNER JOIN 
Auto.tblAssignment ON m.fldID = tblAssignment.fldMessageId INNER JOIN
Auto.tblInternalAssignmentSender ON tblAssignment.fldID = tblInternalAssignmentSender.fldAssignmentID inner join
auto.tblLetterTabagheBandi on m.fldid=tblLetterTabagheBandi.fldMessageId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentSender.fldBoxid)box
left join  Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID
outer apply (select 1  Attachment from auto.tblMessageAttachment a where a.fldMessageId=m.fldid) letterattach
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =m.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =m.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2'
set @text6=@text5+' outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
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
cross apply  (SELECT     tblAssignment_1.fldLetterID
FROM  auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
where  tblAssignment_1.fldMessageId=m.fldid and  tblInternalAssignmentsender_1.fldboxid=box.fldid)Assignment
--where tblAssignment.fldAssignmentDate between @start and @end
)t where 1=1 '

if (@value<>'')
set @text6=@text6+ '  '+ @Value

set @text6=@text6 + ' order by fldAssignmentDate desc'
end

--select @text6
execute (@text6)
GO
