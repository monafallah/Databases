SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblLetterSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value=com.fn_TextNormalizeSelect(@Value)
   if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles  ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + Auto.tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										Auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = Auto.tblAshkhaseHoghoghiTitles.fldId
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	
	WHERE  tblLetter.fldID like @Value 
	
  if (@fieldname=N'fldSubject')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  fldSubject like @Value
	
	if (@fieldname=N'fldLetterNumber')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSender
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldReciever
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  tblLetter.fldLetterNumber like @Value
	
	if (@fieldname=N'fldLetterDate')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
	outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  (tblLetter.fldLetterDate) like @Value
	
	
	if (@fieldname=N'fldCreatedDate')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
	outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  (tblLetter.fldCreatedDate) like @Value
	
	if (@fieldname=N'fldKeywords')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE fldKeywords like @Value
	
	if (@fieldname=N'fldLetterStatusID')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldAshkhasHoghoghiId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  tblLetter.fldLetterStatusID like @Value
	
	if (@fieldname=N'fldComisionID')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  tblLetter.fldComisionID like @Value
	
	if (@fieldname=N'fldImmediacyID')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
	outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  tblLetter.fldImmediacyID like @Value
	
	if (@fieldname=N'fldSecurityTypeID')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  tblLetter.fldSecurityTypeID like @Value
	
	if (@fieldname=N'fldLetterTypeID')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										 Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						WHERE  tblLetter.fldLetterTypeID like @Value
	
	
	
	
	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender 
											inner join Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
							WHERE  tblletter.fldDesc like @Value
	
	if (@fieldname=N'fldLetterStatusName')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' +auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
												where tblLetterStatus.fldName=@value
	
	
	if (@fieldname=N'fldImmediacyName')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldAshkhasHoghoghiId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender 
											inner join Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
							WHERE  tblImmediacy.fldName like @Value
	
	if (@fieldname=N'fldLetterTypeName')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender 
											inner join Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						WHERE  fldLetterType  like @Value
	
	
	
	if (@fieldname=N'fldYear')	
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldAshkhasHoghoghiId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender 
											inner join Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
	WHERE  tblLetter.fldYear  like @Value


   if (@fieldname=N'')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + Auto.tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										Auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = Auto.tblAshkhaseHoghoghiTitles.fldId
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
							where tblletter.fldOrganID=@OrganId


if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblLetter.fldID, tblLetter.fldSubject, tblLetter.fldLetterNumber, (tblLetter.fldLetterDate) AS fldLetterDate, (tblLetter.fldCreatedDate) AS fldCreatedDate, 
                    cast( cast(d.flddATE AS nvarchar(10))+' '+substring(fldCreatedDate,11, len (fldCreatedDate))as datetime)  AS fldCreatedDateEn, tblLetter.fldKeywords, tblLetter.fldLetterStatusID, tblLetter.fldComisionID, tblLetter.fldImmediacyID, tblLetter.fldSecurityTypeID, tblLetter.fldLetterTypeID, 
                     tblLetter.fldUserID, tblLetter.fldDesc, tblLetterStatus.fldName AS fldLetterStatusName, 
                      tblImmediacy.fldName AS fldImmediacyName, tblLetterType.fldLetterType AS fldLetterTypeName, tblSecurityType.fldSecurityType AS fldSecurityTypeName, 
                      tblLetter.fldYear, tblLetter.fldOrderId, tblLetter.fldSignType,tblLetter.fldOrganId,tblLetter.fldIP
					  ,case when charindex('*',fldSubject)<>0 then '/'+' '+substring(fldSubject,1,charindex('*',fldSubject))
						when  empsender1.EmployeeList1 is not null  then empsend2.EmployeeList else empsend2.EmployeeList  end as fldSenderName
						,case when empReceiver1.EmployeeList1 is null  then empReceiver2.EmployeeList when empReceiver2.EmployeeList is null  then empReceiver1.EmployeeList1 else empReceiver1.EmployeeList1+';'+empReceiver2.EmployeeList end as fldRecieverName
						,isnull(ExtId,'')+isnull(InterId,'') as fldReceiver
						,isnull(ronevshhoghghi,'')+isnull(ronevshComi,'')  as fldRoonevesht
						,isnull(Singer.SignerId,'') as fldSigner,isnull(SignerName,'') as fldSignerName
						,isnull(ExtSenderName,'')fldExternalSenderName,isnull(ExtSenderIde,'') fldExternalSender
						,fldMatnLetter,fldLetterTemplateId,fldContentFileID,fldFont
	FROM         tblLetter INNER JOIN
                      tblLetterStatus ON tblLetter.fldLetterStatusID = tblLetterStatus.fldID INNER JOIN
                      tblImmediacy ON tblLetter.fldImmediacyID = tblImmediacy.fldID INNER JOIN
                      tblSecurityType ON tblLetter.fldSecurityTypeID = tblSecurityType.fldID INNER JOIN
                      tblLetterType ON tblLetter.fldLetterTypeID = tblLetterType.fldID  inner join
					  com.tblDateDim d on d.fldTarikh=cast(fldCreatedDate as nvarchar(10))
		  outer apply (select stuff((SELECT ';' + auto.tblAshkhaseHoghoghiTitles.fldName
						FROM         Auto.tblExternalLetterReceiver INNER JOIN
									auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterReceiver.fldHoghoghiTitlesId = auto.tblAshkhaseHoghoghiTitles.fldId
						WHERE     (auto.tblExternalLetterReceiver.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empReceiver1

			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
								FROM        auto. tblLetter as l INNER JOIN
														Auto.tblInternalLetterReceiver ON l.fldId = tblInternalLetterReceiver.[fldLetterId]
														inner join auto.tblCommision on  tblInternalLetterReceiver.fldReceiverComisionID = tblCommision.fldId
														inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
														inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
														inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
								WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empReceiver2
					
			outer apply (select stuff((SELECT ';' + Auto.tblAshkhaseHoghoghiTitles.fldName
								FROM    Auto.tblExternalLetterSender INNER JOIN
										Auto.tblAshkhaseHoghoghiTitles ON Auto.tblExternalLetterSender.fldShakhsHoghoghiTitlesId = Auto.tblAshkhaseHoghoghiTitles.fldId
								WHERE     (Auto.tblExternalLetterSender.fldLetterId  =tblLetter.fldID)  for xml path('')),1,1,'') as EmployeeList1 ) empsender1
					
			outer apply (select stuff((SELECT +';' +tblEmployee.fldName  COLLATE Latin1_General_CS_AS+' '+ tblEmployee.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
									FROM        Auto.tblLetter as l INNER JOIN
												Auto.tblCommision  ON l.fldComisionId = tblCommision.fldId
												inner join com.tblAshkhas on fldAshkhasID=tblAshkhas.fldid
												inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldid
												inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
									WHERE     l.fldId  =tblLetter.fldID for xml path('')),1,1,'') as EmployeeList)empsend2
	

		outer apply (select stuff((select ';'+cast(a.fldid as varchar(10))+'|2'  from auto.tblExternalLetterReceiver
										inner join auto.tblAshkhaseHoghoghiTitles a on fldHoghoghiTitlesId=a.fldid
							where fldLetterID=tblLetter.fldid for xml path ('')),1,1,'')+';' as ExtId)ExternalReceivId
		
		outer apply (select stuff ((select ';'+cast(fldReceiverComisionId as varchar(10))+'|1' from auto.tblInternalLetterReceiver
						where fldLetterId=tblLetter.fldid for xml path ('')),1,1,'')+';' as InterId)InternalRecievId
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldAshkhasHoghoghiTitlesId as varchar(10))+'|2' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1, '')+';' as ronevshhoghghi)RnvHoghoghi
		
		outer apply (select stuff((select ';'+cast(tblRonevesht.fldCommisionId as varchar(10))+'|1' from auto.tblRonevesht
							where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')+';' as ronevshComi)RnvCommi
		
		outer apply (select stuff((select ';'+e.fldName  COLLATE Latin1_General_CS_AS+' '+ e.fldfamily  COLLATE Latin1_General_CS_AS+'-'+ o.fldTitle
							 from auto.tblSigner
							inner join auto.tblCommision c on fldSignerComisionId=c.fldid
							inner join com.tblAshkhas a on a.fldid=fldAshkhasID
							inner join com.tblEmployee e on e.fldid=fldHaghighiId
							inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerName)Sname
		
		outer apply (select stuff ((select ';'+cast(fldSignerComisionId as varchar(10))
							from auto.tblSigner
					 where fldLetterID=tblLetter.fldid  for xml path ('')),1,1,'')SignerId)Singer

		outer apply (select stuff((select ';'+fldName from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderName)ExtSenderN

		
		outer apply (select stuff((select ';'+cast(fldShakhsHoghoghiTitlesId as nvarchar(10))+'|2' from Auto.tblExternalLetterSender
							inner join  Auto.tblAshkhaseHoghoghiTitles on fldShakhsHoghoghiTitlesId=Auto.tblAshkhaseHoghoghiTitles.fldid
						where fldLetterID=tblLetter.fldid  for xml path ('') ),1,1,'')ExtSenderIde)ExtSenderId
						
						where tblletter.fldOrganID=@OrganId

End

GO
