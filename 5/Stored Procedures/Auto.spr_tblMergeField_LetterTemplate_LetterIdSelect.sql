SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeField_LetterTemplate_LetterIdSelect] 
@Value nvarchar(50),
@value2 nvarchar(50),
@organId int
as
--declare @Value nvarchar(50)=1,
--@value2 nvarchar(50)=20,
--@organId int=1
SELECT 0as radif,  [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,value as fldValue
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	
	cross apply(
		select  [value]as value, [NameColum] as NameColum
					from (SELECT    tblLetter.fldID, 
					cast(tblLetter.fldSubject as nvarchar(1000))fldSubject, 
					cast(isnull(tblLetter.fldLetterNumber,'') as nvarchar(1000))fldLetterNumber, 
					case when tblLetter.fldLetterDate is null then '' else cast(SUBSTRING (tblLetter.fldLetterDate,9,2)+'/'+SUBSTRING (tblLetter.fldLetterDate,6,2)+'/'+SUBSTRING (tblLetter.fldLetterDate,1,4) as  nvarchar(1000)) end 
					/* cast((isnull(tblLetter.fldLetterDate,'')) as  nvarchar(1000)) */ AS fldLetterDate, 
					cast(case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
					when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end  as nvarchar(1000))as fldSenderName
					,cast(isnull(case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+empReceiver2.EmployeeList end,'') as nvarchar(1000)) as fldRecieverName
					,cast(isnull(empReceiverPost2.EmployeeList ,'') as nvarchar(1000))fldPostReciv
					,cast(isnull(empsendPost2.EmployeeList ,'') as nvarchar(1000))fldPostSend
					,cast(isnull(ExtSenderName,'') as nvarchar(1000))fldExternalSenderName	,
					cast(isnull(fldAttach,N'ندارد') as nvarchar(1000))fldAttach,
					cast(isnull(case when ronevshhoghghi is null then N'رونوشت; '+ronevshComi when ronevshComi is null  then N'رونوشت; '+ronevshhoghghi WHEN ronevshComi is not null and ronevshhoghghi is not null then N'رونوشت; '+ ronevshComi +ronevshhoghghi end,'')  as nvarchar(1000))  as fldRoonevesht
					,cast(isnull (tblLetter.fldDesc,'')as nvarchar(1000)) fldDescLetter
		FROM        auto. tblLetter INNER JOIN
						 auto.  tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
						 auto.  tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
						 auto.  tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
						 auto.  tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
						  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  
	outer apply (select stuff((SELECT ','+auto.tblAshkhaseHoghoghiTitles.fldName
				FROM         Auto.tblExternalLetterReceiver INNER JOIN
							auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
				WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

	outer apply (select stuff((SELECT ','+tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS
					FROM        auto. tblLetter as l INNER JOIN
											Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
											inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
											inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
											inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
											inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					WHERE     l.fldId  =tblLetter.fldID  for xml path('')),1,1,'') as EmployeeList)empReceiver2

	outer apply (select STUFF((SELECT ','+o.fldTitle
					FROM        auto. tblLetter as l INNER JOIN
											Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
											inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
											inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
											inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
											inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'')  as EmployeeList)empReceiverPost2

					
	outer apply (select (SELECT tblAshkhaseHoghoghiTitles.fldName+';'
				FROM    Auto.tblExternalLetterSender INNER JOIN
						auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldid
				WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')) as EmployeeList1 ) empsender1
					
	outer apply (select (SELECT  tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS +';'
							FROM        Auto.tblLetter as l INNER JOIN
										Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
										inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
										inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
										inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
							WHERE     l.fldId  =tblLetter.fldID for xml path('')) as EmployeeList)empsend2
		
	outer apply (select (SELECT  o.fldTitle  +';' 
							FROM        Auto.tblLetter as l INNER JOIN
										Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
										inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
										inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
										inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
							WHERE     l.fldId  =tblLetter.fldID for xml path('')) as EmployeeList)empsendPost2

	outer apply (select (select fldName+';' from Auto.tblExternalLetterSender
					inner join auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=tblAshkhaseHoghoghiTitles.fldid
				where fldLetterID=tblLetter.fldid  for xml path ('') )ExtSenderName)ExtSenderN

	outer apply (select cast(N'دارد'  as nvarchar(10))fldAttach from auto.tblLetterAttachment 
					where fldLetterID=tblLetter.fldid)attachme

	outer apply (select (select ' - ' + a.fldName+' - '+t.fldType +';' from auto.tblRonevesht
								inner join auto.tblAshkhaseHoghoghiTitles a on a.fldid=tblRonevesht.fldAshkhasHoghoghiTitlesId
								inner join auto.tblAssignmentType t on t.fldid=fldAssignmentTypeId
							where fldLetterID=tblLetter.fldid  for xml path (''))ronevshhoghghi)RnvHoghoghi
		
	outer apply (select  (select ' - '+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'('+ o.fldTitle+')'+t.fldType+';' 
								from auto.tblRonevesht
								inner join auto.tblCommision c on tblRonevesht.fldCommisionId=c.fldid
								inner join com.tblAshkhas a on a.fldid=fldAshkhasID
								inner join com.tblEmployee e on e.fldid=fldHaghighiId
								inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								inner join auto.tblAssignmentType t on t.fldid=fldAssignmentTypeId
							where fldLetterID=tblLetter.fldid  for xml path (''))ronevshComi)RnvCommi

	WHERE  tblLetter.fldID like @Value2  and m.fldType=0
	)p
	unpivot 
		(value for NameColum   in 
			(	
			fldSubject, fldLetterNumber, fldLetterDate,fldSenderName, fldRecieverName,fldPostReciv,fldPostSend, 
			fldExternalSenderName,fldAttach,fldRoonevesht,fldDescLetter
			)
		) as unpiv
)letter
where fldLetterTamplateId=@value and NameColum=fldEnName  and NameColum<>'fldSignerName' and [tblMergeField_LetterTemplate].fldOrganId=@organId



union all

select row_number()over (order by dd)radif, fldid,fldLetterTamplateId,fldMergeFieldId,fldUserId,fldOrganId,fldDesc,fldIP,fldDate,case when fldEnName='fldSignerName1' then 'fldSignerName' else  fldEnName end 
,fldFaName,fldTitleLetter,fldValue   COLLATE Latin1_General_CS_AS
  from (SELECT rr,dd,  [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName+cast(row_number()over (order by (select 1 ))as varchar(10)) fldEnName,m.fldFaName,l.fldName as fldTitleLetter,value as fldValue
	
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	
	cross apply(
		select row_number()over (order by signid )rr,dd,  [value]as value, [NameColum] as NameColum
					from (select  signid,dd,
					cast(isnull(SignerName,'')as nvarchar(1000))--+ cast(row_number()over (order by (select 1 ))as varchar(10)) 
					As fldSignerName
							FROM        auto. tblLetter INNER JOIN
						 auto.  tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
						 auto.  tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
						 auto.  tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
						 auto.  tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
						  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  

	outer apply (select auto.tblSigner.fldid SignId, e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+' ; '+ o.fldTitle as SignerName
						,internal.fldDate dd
						 from auto.tblSigner
					inner join auto.tblCommision c on fldFirstSigner=c.fldid
					inner join com.tblAshkhas a on a.fldid=fldAshkhasID
					inner join com.tblEmployee e on e.fldid=fldHaghighiId
					inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					outer apply (select max(c1.fldDate)flddate,fldReceiverComisionId from auto.tblInternalAssignmentReceiver c1 inner join auto.tblAssignment a
					 on a.fldid=fldAssignmentID where a.fldLetterID= tblLetter.fldid  and c1.fldReceiverComisionId=c.fldid
					 group by fldReceiverComisionId) internal
				where fldLetterID=tblLetter.fldid 
				)Sname
		
	
	

	

	WHERE  tblLetter.fldID like @value2  and m.fldType=0
			
	)p
	unpivot 
		(value for NameColum   in 
			(	
				fldSignerName
			)
		) as unpiv
)letter
where fldLetterTamplateId=@value  and fldEnName='fldSignerName'  and [tblMergeField_LetterTemplate].fldOrganId=@organId

)t

union all

select  0as radif,  [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,fldValue  from
   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	inner join [Auto].tblLetter_MergeFieldType mf on mf.fldMergeTypeId=m.fldid
	where  fldLetterTamplateId=@value and m.fldtype=1 and fldletterid=@value2 and  [tblMergeField_LetterTemplate].fldOrganId=@organId
GO
