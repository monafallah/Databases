SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SelectInbox](@fieldName nvarchar(50),@h int,@start nvarchar(10),@End nvarchar(10),@BoxId int,@organId int,@value nvarchar(max),@TabagheBandiId int)
as
--declare @fieldName nvarchar(50)='',@h int=10,@start nvarchar(10)='',@End nvarchar(10)='',@BoxId int=1,@organId int=1,@value nvarchar(max)=''
set @value=replace(@value,'""','')
set @value=replace(@value,'|','''')
if(@h=0) set @h=2147483647
declare @text1 nvarchar(max)='', @text2 nvarchar(max)='',@text3 nvarchar(max)='',@text4 nvarchar(max)='',@text5 nvarchar(max)='',
@Messge nvarchar(10)=N'پیام'

if(@fieldName='')
begin
set @text1=';with box as 
(
	select fldID,fldPID from auto.tblBox
	where fldid='+cast(@BoxId as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblbox.fldID,tblbox.fldPID  from auto.tblbox 
	inner join box on tblbox.fldPID=box.fldid

)'
set @text2 =@text1 +'select top('+cast(@h as varchar(20))+')  * from (select distinct  tblLetter.fldId code,  tblLetter.fldId as fldLetterId,NUll fldMessageId,cast(fldOrderId as nvarchar(10)) fldOrderId
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision ,
tblLetter.fldComisionID, tblLetter.fldSubject,tblLetterStatus.fldName AS fldLetterstatus, 
tblLetterType.fldLetterType, tblLetter.fldLetterTypeID,isnull(archive,0) as HaveArchiv,isnull(Attachment,0)HaveAttach
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,tblAssignment.fldAssignmentDate fldAssignmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
 tblInternalAssignmentReceiver.fldReceiverComisionID, tblInternalAssignmentReceiver.fldAssignmentStatusID, tblImmediacy.fldFileId as  fldImmediacyID,
tblLetter.fldLetterDate AS fldLetterDate, tblLetter.fldLetterNumber,s.fldName as AssimentLetterStatus,
CASE tblInternalAssignmentReceiver.fldAssignmentStatusId WHEN 1 THEN 1 ELSE 2 END AS AssimentLetterStatusId, 
tblImmediacy.fldName AS fldImmediacyName,tblInternalAssignmentReceiver.fldID as InternalAssignmentReceiverID,
fldCreatedDate,fldSecurityType,tblLetter.fldDesc,fldKeywords,fldSenderComisionID
FROM   Auto.tblLetter INNER JOIN
auto.tblAssignment ON tblLetter.fldID = tblAssignment.fldLetterID INNER JOIN
Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
Auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
auto.tblAssignmentStatus s on s.fldID = tblInternalAssignmentReceiver.fldAssignmentStatusID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join 
auto.tblInternalAssignmentSender on  tblInternalAssignmentSender.fldAssignmentID=tblAssignment.fldID  inner join
box on box.fldid=tblInternalAssignmentReceiver.fldBoxId'
set @text3=@text2+' outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=tblLetter.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=tblLetter.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =tblLetter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblLetter.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + auto.tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =tblLetter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM   auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblLetter.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2							
cross apply (SELECT  distinct tblAssignment_1.fldLetterID
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
			auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
			tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
			inner join box on box.fldid=tblInternalAssignmentReceiver_1.fldBoxID
WHERE  /* (tblAssignment_1.fldAssignmentDate BETWEEN @Start1 AND @End1) and*/ tblAssignment_1.fldLetterID=tblLetter.fldID  )ad'
set @text4=@text3+' union all
select distinct tblMessage.fldid code ,NULL as fldLetterId,tblMessage.fldid fldMessageId,cast(''0'' as nvarchar(10)) fldOrderId
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision ,
tblMessage.fldCommisionId fldComisionID, tblMessage.fldTitle fldSubject,'''' AS fldLetterstatus, 
N'''+@Messge+''' fldLetterType, 0fldLetterTypeID,0 as HaveArchiv,isnull(Attachment,0)HaveAttach
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,tblAssignment.fldAssignmentDate fldAssignmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
 tblInternalAssignmentReceiver.fldReceiverComisionID, tblInternalAssignmentReceiver.fldAssignmentStatusID,0fldImmediacyID, 
'''' AS fldLetterDate, ''''fldLetterNumber,s.fldName as AssimentLetterStatus,
CASE tblInternalAssignmentReceiver.fldAssignmentStatusId WHEN 1 THEN 1 ELSE 2 END AS AssimentLetterStatusId, 
'''' AS fldImmediacyName,tblInternalAssignmentReceiver.fldID as InternalAssignmentReceiverID,
fldTarikhShamsi fldCreatedDate,'''' fldSecurityType,tblMessage.fldDesc,''''fldKeywords,fldSenderComisionID
FROM     Auto.tblMessage INNER JOIN
auto.tblAssignment ON tblMessage.fldID = tblAssignment.fldMessageId INNER JOIN
Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblAssignmentStatus s on s.fldID = tblInternalAssignmentReceiver.fldAssignmentStatusID inner join
auto.tblInternalAssignmentSender on  tblInternalAssignmentSender.fldAssignmentID=tblAssignment.fldID  inner join
box on box.fldid=tblInternalAssignmentReceiver.fldBoxId
outer apply (select 1  Attachment from auto.tblMessageAttachment a where a.fldMessageId=tblMessage.fldid) letterattach
outer apply (select stuff((SELECT ''/''+tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =tblMessage.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblMessage.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + auto.tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldMessageId  =tblMessage.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend'
set @text5=@text4+' outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblCommision  on l.fldCommisionId=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblMessage.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2							
cross apply (SELECT  distinct tblAssignment_1.fldMessageId FROM   auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
inner join box on box.fldid=tblInternalAssignmentReceiver_1.fldBoxID
WHERE  /* (tblAssignment_1.fldAssignmentDate BETWEEN @Start1 AND @End1)and*/ tblAssignment_1.fldMessageId=tblMessage.fldID  )ad
)t where 1=1 '

if (@value <>'')
set @text5=@text5+ ' '+@value 

set @text5=@text5+'

 order by fldAssignmentDate desc'

--select @text4

end

if (@fieldName='TabagheBandi')
begin
set @text1=';with TabagheBandi as 
(select fldID,fldPID from auto.tblTabagheBandi
	where fldid='+cast(@TabagheBandiId as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all
	select tblTabagheBandi.fldID,tblTabagheBandi.fldPID  from auto.tblTabagheBandi 
	inner join TabagheBandi on tblTabagheBandi.fldPID=TabagheBandi.fldid )'
set @text2 =@text1 +'select top('+cast(@h as varchar(20))+')  * from (select distinct tblLetter.fldId code,  tblLetter.fldId as fldLetterId,NUll fldMessageId,cast(fldOrderId as nvarchar(10)) fldOrderId
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision ,
tblLetter.fldComisionID, tblLetter.fldSubject,tblLetterStatus.fldName AS fldLetterstatus, 
tblLetterType.fldLetterType, tblLetter.fldLetterTypeID,isnull(archive,0) as HaveArchiv,isnull(Attachment,0)HaveAttach
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,tblAssignment.fldAssignmentDate fldAssignmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
 tblInternalAssignmentReceiver.fldReceiverComisionID, tblInternalAssignmentReceiver.fldAssignmentStatusID, tblImmediacy.fldFileId as  fldImmediacyID,
tblLetter.fldLetterDate AS fldLetterDate, tblLetter.fldLetterNumber,s.fldName as AssimentLetterStatus,
CASE tblInternalAssignmentReceiver.fldAssignmentStatusId WHEN 1 THEN 1 ELSE 2 END AS AssimentLetterStatusId, 
tblImmediacy.fldName AS fldImmediacyName,tblInternalAssignmentReceiver.fldID as InternalAssignmentReceiverID,
fldCreatedDate,fldSecurityType,tblLetter.fldDesc,fldKeywords,fldSenderComisionID
FROM       Auto.tblLetter INNER JOIN
auto.tblAssignment ON tblLetter.fldID = tblAssignment.fldLetterID INNER JOIN
Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
Auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
auto.tblAssignmentStatus s on s.fldID = tblInternalAssignmentReceiver.fldAssignmentStatusID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join 
auto.tblInternalAssignmentSender on  tblInternalAssignmentSender.fldAssignmentID=tblAssignment.fldID  inner join
auto.tblLetterTabagheBandi on tblLetter.fldid=tblLetterTabagheBandi.fldLetterId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@BoxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentReceiver.fldBoxId)box'
set @text3=@text2+' outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=tblLetter.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=tblLetter.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE   (Auto.tblExternalLetterReceiver.fldLetterID  =tblLetter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblLetter.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + auto.tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =tblLetter.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM     auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblLetter.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2							
cross apply (SELECT  distinct tblAssignment_1.fldLetterID
FROM  auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
WHERE  tblAssignment_1.fldLetterID=tblLetter.fldID  and Box.fldid=tblInternalAssignmentReceiver_1.fldBoxID)ad'
set @text4=@text3+' union all
select distinct tblMessage.fldid code ,NULL as fldLetterId,tblMessage.fldid fldMessageId,cast(''0'' as nvarchar(10)) fldOrderId
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision ,
tblMessage.fldCommisionId fldComisionID, tblMessage.fldTitle fldSubject,'''' AS fldLetterstatus, 
N'''+@Messge+''' fldLetterType, 0fldLetterTypeID,0 as HaveArchiv,isnull(Attachment,0)HaveAttach
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,tblAssignment.fldAssignmentDate fldAssignmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
 tblInternalAssignmentReceiver.fldReceiverComisionID, tblInternalAssignmentReceiver.fldAssignmentStatusID,0fldImmediacyID, 
'''' AS fldLetterDate,''''fldLetterNumber,s.fldName as AssimentLetterStatus,
CASE tblInternalAssignmentReceiver.fldAssignmentStatusId WHEN 1 THEN 1 ELSE 2 END AS AssimentLetterStatusId,'''' AS fldImmediacyName,tblInternalAssignmentReceiver.fldID as InternalAssignmentReceiverID,
fldTarikhShamsi fldCreatedDate,'''' fldSecurityType,tblMessage.fldDesc,''''fldKeywords,fldSenderComisionID
FROM     Auto.tblMessage INNER JOIN auto.tblAssignment ON tblMessage.fldID = tblAssignment.fldMessageId INNER JOIN
Auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblAssignmentStatus s on s.fldID = tblInternalAssignmentReceiver.fldAssignmentStatusID inner join
auto.tblInternalAssignmentSender on  tblInternalAssignmentSender.fldAssignmentID=tblAssignment.fldID   inner join
auto.tblLetterTabagheBandi on tblMessage.fldid=tblLetterTabagheBandi.fldMessageId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@BoxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentReceiver.fldBoxid)box
outer apply (select 1 Attachment from auto.tblMessageAttachment a where a.fldMessageId=tblMessage.fldid) letterattach
outer apply (select stuff((SELECT ''/''+tblAshkhaseHoghoghiTitles.fldName FROM   Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =tblMessage.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM       auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =tblMessage.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + auto.tblAshkhaseHoghoghiTitles.fldName
FROM      auto.tblExternalLetterSender INNER JOIN auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId =auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldMessageId  =tblMessage.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM      auto.tblMessage as l INNER JOIN
auto.tblCommision  on l.fldCommisionId=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE  l.fldId  =tblMessage.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2	'						
set @text5=@text4+' cross apply (SELECT  distinct tblAssignment_1.fldMessageId
FROM      auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
WHERE tblAssignment_1.fldMessageId=tblMessage.fldID  and Box.fldid=tblInternalAssignmentReceiver_1.fldBoxID )ad
)t where 1=1 '
if (@value <>'')
set @text5=@text5+ ' '+@value 

set @text5=@text5+' order by fldAssignmentDate desc'

end

--select @text5
execute (@text5)
GO
