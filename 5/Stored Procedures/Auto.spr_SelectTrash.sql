SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SelectTrash](@fieldName nvarchar(50),@h int,@start nvarchar(10),@end nvarchar(10),@BoxId int,@organId int,@value nvarchar(max),@TabagheBandiId int)
as
--declare @fieldName nvarchar(50)='tabaghebandi',@h int=10,@start nvarchar(10)='',@end nvarchar(10)='',@BoxId int=1,@organId int=1,@value nvarchar(max)='',@TabagheBandiId int=1
set @value=replace(@value,'""','')
set @value=replace(@value,'|','''')
if(@h=0) set @h=2147483647
declare @text1 nvarchar(max)='',@text2 nvarchar(max)='',@text3 nvarchar(max)='',@text4 nvarchar(max)='',@text5 nvarchar(max)=''
,@text6 nvarchar(max)='',@text7 nvarchar(max)='',@text8 nvarchar(max)='',@text9 nvarchar(max)=''
,@message nvarchar(10)=N'پیام'

if (@fieldName='')
begin
set @text1=
';with box as 
(
	select fldid,fldPID from auto.tblbox
	where fldid='+cast(@boxid as varchar(10))+' and fldOrganID='+cast(@organId as varchar(10))+'
	union all

	select tblbox.fldid,tblbox.fldPID from auto.tblbox
	inner join box on tblbox.fldPID=box.fldid
)'
set @text2=@text1+'select   top ('+cast(@h  as varchar(20))+') * from ( select * from (select distinct fldId as code,  fldId as fldLetterId,Null as fldMessageId,cast(fldOrderId as varchar(10)) as fldOrderId
,fldComisionID,fldSubject,fldLetterstatus,fldLetterType,fldLetterTypeID,fldAssigmentDate,assigmentid,fldAnswerDate
,fldSenderComisionID, fldImmediacyID,fldLetterDate,fldLetterNumber,fldImmediacyName,fldTrashType,fldDelDate
,fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,isnull(archive,0) as HaveArchiv,isnull(Attachment,0)HaveAttach
 from 
 (SELECT     tblLetter.fldID,tblLetter.fldOrderId, tblLetter.fldComisionID, tblLetter.fldSubject, tblLetterStatus.fldName AS fldLetterstatus, 
tblLetterType.fldLetterType, tblLetter.fldLetterTypeID, 
(tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentsender.fldSenderComisionID, tblImmediacy.fldFileid fldImmediacyID, 
(tblLetter.fldLetterDate) AS fldLetterDate, tblLetter.fldLetterNumber,tblImmediacy.fldName AS fldImmediacyName 
,1 AS fldTrashType--ارسالی
,tblInternalAssignmentSender.fldDate as fldDelDate,tblLetter.fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
FROM         Auto.tblLetter INNER JOIN
Auto. tblAssignment ON tblLetter.fldID = tblAssignment.fldLetterID INNER JOIN
Auto.tblInternalAssignmentsender ON tblAssignment.fldID = tblInternalAssignmentsender.fldAssignmentID INNER JOIN
Auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
Auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID inner join 
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
box on box.fldid=tblInternalAssignmentsender.fldBoxID
cross apply 
(SELECT     tblAssignment_1.fldLetterID
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto. tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
inner join   box on box.fldid=tblInternalAssignmentsender_1.fldBoxID
where tblLetter.fldid= tblAssignment_1.fldLetterID)ad
	--WHERE     tblInternalAssignmentSender.fldDate >= @Start and tblInternalAssignmentSender.fldDate<= @End
'
set @text3=@text2+' union all
SELECT  distinct   tblLetter.fldID,tblLetter.fldOrderId, tblLetter.fldComisionID, tblLetter.fldSubject, tblLetterStatus.fldName AS fldLetterstatus, 
tblLetterType.fldLetterType, tblLetter.fldLetterTypeID, (tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentReceiver.fldReceiverComisionId fldSenderComisionID,tblImmediacy.fldFileId as  fldImmediacyID, 
(tblLetter.fldLetterDate) AS fldLetterDate, tblLetter.fldLetterNumber,tblImmediacy.fldName AS fldImmediacyName 
,2 AS fldTrashType--جاری
,tblInternalAssignmentReceiver.fldDate  as fldDelDate,tblLetter.fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
FROM         auto.tblLetter INNER JOIN
auto. tblAssignment ON tblLetter.fldID = tblAssignment.fldLetterID INNER JOIN
auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
box on box.fldid=tblInternalAssignmentReceiver.fldBoxID 
cross apply (SELECT     tblAssignment_1.fldLetterID
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
inner join box on box.fldid=tblInternalAssignmentReceiver_1.fldBoxID
WHERE      (tblAssignment_1.fldLetterID= tblLetter.fldID )) aa
	--WHERE    tblInternalAssignmentReceiver.fldDate >= @Start and tblInternalAssignmentReceiver.fldDate<=@End
'
set @text4=@text3+' UNION all
SELECT distinct  tblLetter.fldID,tblLetter.fldOrderID,tblLetter.fldComisionID,tblLetter.fldSubject,tblLetterStatus.fldName AS fldLetterStatus,
 tblLetterType.fldLetterType AS fldLetterType,tblLetter.fldLetterTypeID,
'''' AS fldAssigmentDate, 0 AS assigmentid, '''' AS fldAnswerDate,
0 AS fldReceiverComisionID,tblImmediacy.fldFileId as  fldImmediacyID, 
(tblLetter.fldLetterDate) AS fldLetterDate, tblLetter.fldLetterNumber,                   
tblImmediacy.fldName AS fldImmediacyName,3 AS fldTrashType--ذخیره شده
,tblLetterBox.fldDate as fldDelDate,tblLetter.fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
FROM        auto.tblLetter INNER JOIN
auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join 
auto.tblletterbox on fldletterid=tblLetter.fldid inner join
box on box.fldid=fldBoxid
--WHERE   tblLetterBox.fldDate between  @Start @End 
)temp'
set @text5=@text4+' outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=temp.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=la.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =temp.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =temp.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
)t'
set @text6=@text5+' union all
select * from (select distinct fldId as code,NUll as fldLetterId,fldid as fldMessageId,cast(fldOrderId as varchar(10)) as fldOrderId
,fldComisionID,fldSubject,fldLetterstatus,N'''+@message+''' fldLetterType,fldLetterTypeID,fldAssigmentDate,assigmentid,fldAnswerDate
,fldSenderComisionID,fldImmediacyID,fldLetterDate,fldLetterNumber,fldImmediacyName,fldTrashType,fldDelDate
,fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,0 as HaveArchiv,isnull(Attachment,0)HaveAttach
 from 
 (SELECT   distinct  tblMessage.fldID,0 fldOrderId, tblMessage.fldCommisionId fldComisionID, tblMessage. fldTitle fldSubject, '''' AS fldLetterstatus, 
''''fldLetterType,0fldLetterTypeID, 
(tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentsender.fldSenderComisionID, 0fldImmediacyID, 
'''' AS fldLetterDate, ''''fldLetterNumber,'''' AS fldImmediacyName 
,1 AS fldTrashType--ارسالی
,tblInternalAssignmentSender.fldDate as fldDelDate,tblMessage.fldDesc,''''fldKeywords,fldTarikhShamsi fldCreatedDate,''''fldSecurityType
FROM         Auto.tblMessage INNER JOIN
Auto. tblAssignment ON tblMessage.fldID = tblAssignment.fldMessageId INNER JOIN
Auto.tblInternalAssignmentsender ON tblAssignment.fldID = tblInternalAssignmentsender.fldAssignmentID INNER JOIN
box on box.fldid=tblInternalAssignmentsender.fldBoxID 
cross apply 
(SELECT     tblAssignment_1.fldMessageId
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto. tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
inner join   box on box.fldid=tblInternalAssignmentsender_1.fldBoxID
where tblMessage.fldid= tblAssignment_1.fldMessageId)ad
	--WHERE     tblInternalAssignmentSender.fldDate >= @Start and tblInternalAssignmentSender.fldDate<= @End
'
set @text7=@text6+' union all
SELECT   distinct  tblMessage.fldID,0fldOrderId, tblMessage.fldCommisionId fldComisionID, tblMessage.fldTitle fldSubject, '''' AS fldLetterstatus, 
''''fldLetterType, 0fldLetterTypeID, (tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentReceiver.fldReceiverComisionId fldSenderComisionID, 0 fldImmediacyID, 
'''' AS fldLetterDate, '''' fldLetterNumber,'''' AS fldImmediacyName 
,2 AS fldTrashType--جاری
,tblInternalAssignmentReceiver.fldDate  as fldDelDate,tblMessage.fldDesc,''''fldKeywords,fldTarikhShamsi fldCreatedDate,''''fldSecurityType
FROM         auto.tblMessage INNER JOIN
auto. tblAssignment ON tblMessage.fldID = tblAssignment.fldMessageId INNER JOIN
auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
box on box.fldid=tblInternalAssignmentReceiver.fldBoxID 
cross apply (SELECT     tblAssignment_1.fldMessageId
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
inner join box on box.fldid=tblInternalAssignmentReceiver_1.fldBoxID
WHERE      (tblAssignment_1.fldMessageId= tblMessage.fldID )) aa
	--WHERE    tblInternalAssignmentReceiver.fldDate >= @Start and tblInternalAssignmentReceiver.fldDate<=@End
'
set @text8=@text7+' UNION all
SELECT distinct  tblMessage.fldID,0fldOrderID,tblMessage.fldCommisionId  fldComisionID,tblMessage.fldTitle fldSubject,'''' AS fldLetterStatus,
'''' AS fldLetterType,0fldLetterTypeID,
'''' AS fldAssigmentDate, 0 AS assigmentid, '''' AS fldAnswerDate,
0 AS fldReceiverComisionID, 0fldImmediacyID, 
''''AS fldLetterDate, ''''fldLetterNumber,                   
'''' AS fldImmediacyName,3 AS fldTrashType--ذخیره شده
,tblLetterBox.fldDate as fldDelDate,tblMessage.fldDesc,''''fldKeywords,fldTarikhShamsi fldCreatedDate,''''fldSecurityType
FROM        auto.tblMessage INNER JOIN
auto.tblletterbox on fldMessageid=tblMessage.fldid inner join
box on box.fldid=fldBoxid
--WHERE   tblLetterBox.fldDate between  @Start @End 
)temp1'
set @text9=@text8+' outer apply (select 1  Attachment from auto.tblMessageAttachment a where a.fldMessageId=temp1.fldid) Messagetach

outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =temp1.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp1.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldMessageId  =temp1.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblCommision  on l.fldCommisionId=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp1.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
)t1)q where 1=1'

if (@value<>'')
set @text9=@text9+' '+@value 

set @text9=@text9+ ' order by code desc'
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

set @text2=@text1+'select   top ('+cast(@h  as varchar(20))+') * from ( select  distinct * from (select fldId as code,  fldId as fldLetterId,Null as fldMessageId,cast(fldOrderId as varchar(10)) as fldOrderId
,fldComisionID,fldSubject,fldLetterstatus,fldLetterType,fldLetterTypeID,fldAssigmentDate,assigmentid,fldAnswerDate
,fldSenderComisionID, fldImmediacyID,fldLetterDate,fldLetterNumber,fldImmediacyName,fldTrashType,fldDelDate
,fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,isnull(archive,0) as HaveArchiv,isnull(Attachment,0)HaveAttach
 from 
 (SELECT     tblLetter.fldID,tblLetter.fldOrderId, tblLetter.fldComisionID, tblLetter.fldSubject, tblLetterStatus.fldName AS fldLetterstatus, 
tblLetterType.fldLetterType, tblLetter.fldLetterTypeID, 
(tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentsender.fldSenderComisionID, tblImmediacy.fldFileid fldImmediacyID, 
(tblLetter.fldLetterDate) AS fldLetterDate, tblLetter.fldLetterNumber,tblImmediacy.fldName AS fldImmediacyName 
,1 AS fldTrashType--ارسالی
,tblInternalAssignmentSender.fldDate as fldDelDate,tblLetter.fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
FROM         Auto.tblLetter INNER JOIN
Auto. tblAssignment ON tblLetter.fldID = tblAssignment.fldLetterID INNER JOIN
Auto.tblInternalAssignmentsender ON tblAssignment.fldID = tblInternalAssignmentsender.fldAssignmentID INNER JOIN
Auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
Auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID inner join 
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
auto.tblLetterTabagheBandi on tblLetter.fldid=tblLetterTabagheBandi.fldLetterId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentSender.fldBoxid)box
 cross apply 
(SELECT     tblAssignment_1.fldLetterID
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto. tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID
where tblLetter.fldid= tblAssignment_1.fldLetterID  and box.fldid=tblInternalAssignmentsender_1.fldBoxID)ad
	--WHERE     tblInternalAssignmentSender.fldDate >= @Start and tblInternalAssignmentSender.fldDate<= @End
'
set @text3=@text2+' union all
SELECT     tblLetter.fldID,tblLetter.fldOrderId, tblLetter.fldComisionID, tblLetter.fldSubject, tblLetterStatus.fldName AS fldLetterstatus, 
tblLetterType.fldLetterType, tblLetter.fldLetterTypeID, (tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentReceiver.fldReceiverComisionId fldSenderComisionID,tblImmediacy.fldFileId as  fldImmediacyID, 
(tblLetter.fldLetterDate) AS fldLetterDate, tblLetter.fldLetterNumber,tblImmediacy.fldName AS fldImmediacyName 
,2 AS fldTrashType--جاری
,tblInternalAssignmentReceiver.fldDate  as fldDelDate,tblLetter.fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
FROM         auto.tblLetter INNER JOIN
auto. tblAssignment ON tblLetter.fldID = tblAssignment.fldLetterID INNER JOIN
auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join
auto.tblLetterTabagheBandi on tblLetter.fldid=tblLetterTabagheBandi.fldLetterId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentReceiver.fldBoxid)box
cross apply (SELECT     tblAssignment_1.fldLetterID
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
WHERE      (tblAssignment_1.fldLetterID= tblLetter.fldID and  box.fldid=tblInternalAssignmentReceiver_1.fldBoxID)) aa
	--WHERE    tblInternalAssignmentReceiver.fldDate >= @Start and tblInternalAssignmentReceiver.fldDate<=@End
'
set @text4=@text3+' UNION all
SELECT   tblLetter.fldID,tblLetter.fldOrderID,tblLetter.fldComisionID,tblLetter.fldSubject,tblLetterStatus.fldName AS fldLetterStatus,
 tblLetterType.fldLetterType AS fldLetterType,tblLetter.fldLetterTypeID,
'''' AS fldAssigmentDate, 0 AS assigmentid, '''' AS fldAnswerDate,
0 AS fldReceiverComisionID,tblImmediacy.fldFileId as  fldImmediacyID, 
(tblLetter.fldLetterDate) AS fldLetterDate, tblLetter.fldLetterNumber,                   
tblImmediacy.fldName AS fldImmediacyName,3 AS fldTrashType--ذخیره شده
,tblLetterTabagheBandi.fldDate as fldDelDate,tblLetter.fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
FROM        auto.tblLetter INNER JOIN
auto.tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
auto.tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
auto.tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID inner join
auto.tblSecurityType on fldSecurityTypeID=tblSecurityType.fldid inner join 
auto.tblLetterTabagheBandi on tblLetter.fldid=tblLetterTabagheBandi.fldLetterId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
inner join auto.tblletterbox b on b.fldletterid=  auto.tblLetter.fldid
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=b.fldBoxid)box
--WHERE   tblLetterBox.fldDate between  @Start @End 
)temp'
set @text5=@text4+' outer apply (select 1  Attachment from auto.tblLetterAttachment a where a.fldLetterID=temp.fldid) letterattach
outer apply (select 1 archive from auto.tblLetterActions la where la.fldLetterId=la.fldid and fldLetterActionTypeId=1)letteraction
outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldLetterID  =temp.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblLetter as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldLetterId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldLetterID  =temp.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblletter as l INNER JOIN
auto.tblCommision  on l.fldComisionID=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
)t'
set @text6=@text5+' union all
select * from (select fldId as code,NUll as fldLetterId,fldid as fldMessageId,cast(fldOrderId as varchar(10)) as fldOrderId
,fldComisionID,fldSubject,fldLetterstatus,N'''+@message+''' fldLetterType,fldLetterTypeID,fldAssigmentDate,assigmentid,fldAnswerDate
,fldSenderComisionID,fldImmediacyID,fldLetterDate,fldLetterNumber,fldImmediacyName,fldTrashType,fldDelDate
,fldDesc,fldKeywords,fldCreatedDate,fldSecurityType
,case when  empsend.EmployeeList1 is not null  then empsend.EmployeeList1 else empsend2.EmployeeList  end as fldCommision 
,case when emp1.EmployeeList1 is null  then emp2.EmployeeList when emp2.EmployeeList  is null  then emp1.EmployeeList1 else emp1.EmployeeList1+''/''+emp2.EmployeeList end as LetterRecievers
,0 as HaveArchiv,isnull(Attachment,0)HaveAttach
 from 
 (SELECT     tblMessage.fldID,0 fldOrderId, tblMessage.fldCommisionId fldComisionID, tblMessage. fldTitle fldSubject, '''' AS fldLetterstatus, 
''''fldLetterType,0fldLetterTypeID, 
(tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentsender.fldSenderComisionID, 0fldImmediacyID, 
'''' AS fldLetterDate, ''''fldLetterNumber,'''' AS fldImmediacyName 
,1 AS fldTrashType--ارسالی
,tblInternalAssignmentSender.fldDate as fldDelDate,tblMessage.fldDesc,''''fldKeywords,fldTarikhShamsi fldCreatedDate,''''fldSecurityType
FROM         Auto.tblMessage INNER JOIN
Auto. tblAssignment ON tblMessage.fldID = tblAssignment.fldMessageId INNER JOIN
Auto.tblInternalAssignmentsender ON tblAssignment.fldID = tblInternalAssignmentsender.fldAssignmentID INNER JOIN
auto.tblLetterTabagheBandi on tblMessage.fldid=tblLetterTabagheBandi.fldMessageId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentsender.fldBoxid)box
cross apply 
(SELECT     tblAssignment_1.fldMessageId
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto. tblInternalAssignmentsender AS tblInternalAssignmentsender_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentsender_1.fldAssignmentID

where tblMessage.fldid= tblAssignment_1.fldMessageId and tblInternalAssignmentsender_1.fldBoxID=box.fldid)ad
	--WHERE     tblInternalAssignmentSender.fldDate >= @Start and tblInternalAssignmentSender.fldDate<= @End
'
set @text7=@text6+' union all
SELECT     tblMessage.fldID,0fldOrderId, tblMessage.fldCommisionId fldComisionID, tblMessage.fldTitle fldSubject, '''' AS fldLetterstatus, 
''''fldLetterType, 0fldLetterTypeID, (tblAssignment.fldAssignmentDate) AS fldAssigmentDate, tblAssignment.fldID AS assigmentid, tblAssignment.fldAnswerDate, 
tblInternalAssignmentReceiver.fldReceiverComisionId fldSenderComisionID, 0 fldImmediacyID, 
'''' AS fldLetterDate, '''' fldLetterNumber,'''' AS fldImmediacyName 
,2 AS fldTrashType--جاری
,tblInternalAssignmentReceiver.fldDate  as fldDelDate,tblMessage.fldDesc,''''fldKeywords,fldTarikhShamsi fldCreatedDate,''''fldSecurityType
FROM         auto.tblMessage INNER JOIN
auto. tblAssignment ON tblMessage.fldID = tblAssignment.fldMessageId INNER JOIN
auto.tblInternalAssignmentReceiver ON tblAssignment.fldID = tblInternalAssignmentReceiver.fldAssignmentID INNER JOIN
auto.tblLetterTabagheBandi on tblMessage.fldid=tblLetterTabagheBandi.fldMessageId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId 
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=tblInternalAssignmentReceiver.fldBoxid)box
cross apply (SELECT     tblAssignment_1.fldMessageId
FROM          auto.tblAssignment AS tblAssignment_1 INNER JOIN
auto.tblInternalAssignmentReceiver AS tblInternalAssignmentReceiver_1 ON 
tblAssignment_1.fldID = tblInternalAssignmentReceiver_1.fldAssignmentID
WHERE      (tblAssignment_1.fldMessageId= tblMessage.fldID and  tblInternalAssignmentReceiver_1.fldBoxID=box.fldid)) aa
	--WHERE    tblInternalAssignmentReceiver.fldDate >= @Start and tblInternalAssignmentReceiver.fldDate<=@End
'
set @text8=@text7+' UNION all
SELECT   tblMessage.fldID,0fldOrderID,tblMessage.fldCommisionId  fldComisionID,tblMessage.fldTitle fldSubject,'''' AS fldLetterStatus,
'''' AS fldLetterType,0fldLetterTypeID,
'''' AS fldAssigmentDate, 0 AS assigmentid, '''' AS fldAnswerDate,
0 AS fldReceiverComisionID, 0fldImmediacyID, 
''''AS fldLetterDate, ''''fldLetterNumber,                   
'''' AS fldImmediacyName,3 AS fldTrashType--ذخیره شده
,tblLetterTabagheBandi.fldDate as fldDelDate,tblMessage.fldDesc,''''fldKeywords,fldTarikhShamsi fldCreatedDate,''''fldSecurityType
FROM        auto.tblMessage INNER JOIN
auto.tblLetterTabagheBandi on tblMessage.fldid=tblLetterTabagheBandi.fldMessageId inner join 
TabagheBandi on TabagheBandi.fldID=fldTabagheBandiId
inner join auto.tblletterbox b on b.fldMessageId=  auto.tblMessage.fldid
cross apply (select tblBox.fldid from auto.tblBox where fldBoxTypeID='+cast(@boxId as varchar(10))+' and tblBox.fldid=b.fldBoxid)box
--WHERE   tblLetterBox.fldDate between  @Start @End 
)temp1'
set @text9=@text8+' outer apply (select 1  Attachment from auto.tblMessageAttachment a where a.fldMessageId=temp1.fldid) Messagetach

outer apply (select stuff((SELECT ''/''+auto.tblAshkhaseHoghoghiTitles.fldName
FROM         Auto.tblExternalLetterReceiver INNER JOIN
auto.tblAshkhaseHoghoghiTitles ON auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (Auto.tblExternalLetterReceiver.fldMessageId  =temp1.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) emp1
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.fldMessageId INNER JOIN
auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp1.fldID for xml path('''')),1,1,'''') as EmployeeList)emp2
outer apply (select stuff((SELECT ''/'' + tblAshkhaseHoghoghiTitles.fldName
FROM         auto.tblExternalLetterSender INNER JOIN
auto.tblAshkhaseHoghoghiTitles  ON auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
WHERE     (auto.tblExternalLetterSender.fldMessageId  =temp1.fldID)  for xml path('''')),1,1,'''') as EmployeeList1 ) empsend
outer apply (select stuff((SELECT +''/'' +e.fldName COLLATE Latin1_General_CS_AS+'' ''+ e.fldfamily COLLATE Latin1_General_CS_AS+''-''+ o.fldTitle
FROM         auto.tblMessage as l INNER JOIN
auto.tblCommision  on l.fldCommisionId=tblCommision.fldid inner join 
com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid inner join 
com.tblEmployee e on e.fldid=fldHaghighiId inner join 
com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
WHERE     l.fldId  =temp1.fldID for xml path('''')),1,1,'''') as EmployeeList)empsend2
)t1)q where 1=1'

if (@value<>'')
set @text9=@text9+' '+@value 

set @text9=@text9+ ' order by code desc'
end
--select @text9
execute (@text9)
		
GO
