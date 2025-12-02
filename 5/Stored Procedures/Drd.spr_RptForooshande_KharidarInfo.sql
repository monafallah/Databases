SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptForooshande_KharidarInfo](@FieldName NVARCHAR(50),@Value NVARCHAR(50))
AS
IF(@FieldName='Kharidar')
SELECT   (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee where fldId=fldHaghighiId)
				 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId) END  FROM Com.tblAshkhas WHERE fldId=fldAshakhasID)
				 AS fldName,
		(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT ' ' FROM Com.tblEmployee where fldId=fldHaghighiId)
				 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldCodEghtesadi FROM Com.tblAshkhaseHoghoghi_Detail where fldAshkhaseHoghoghiId=fldHoghoghiId) END  FROM Com.tblAshkhas WHERE fldId=fldAshakhasID)
				 AS fldCodEghtesadi,
		 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
				 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi where fldId=fldHoghoghiId) END  FROM Com.tblAshkhas WHERE fldId=fldAshakhasID)
				 AS fldShomareSabt,
		(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldAddress FROM Com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId)
				 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldAddress FROM Com.tblAshkhaseHoghoghi_Detail where fldAshkhaseHoghoghiId=fldHoghoghiId) END  FROM Com.tblAshkhas WHERE fldId=fldAshakhasID)
				 AS fldAddress,
		(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldCodePosti FROM Com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId)
				 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldCodePosti FROM Com.tblAshkhaseHoghoghi_Detail where fldAshkhaseHoghoghiId=fldHoghoghiId) END  FROM Com.tblAshkhas WHERE fldId=fldAshakhasID)
		AS fldCodePosti
		,(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT ' ' FROM Com.tblEmployee_Detail where fldEmployeeId=fldHaghighiId)
				 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareTelephone FROM Com.tblAshkhaseHoghoghi_Detail where fldAshkhaseHoghoghiId=fldHoghoghiId) END  FROM Com.tblAshkhas WHERE fldId=fldAshakhasID)
		AS fldShomareTelephone
FROM         Drd.tblElamAvarez INNER JOIN
                      Drd.tblSodoorFish ON Drd.tblElamAvarez.fldId = Drd.tblSodoorFish.fldElamAvarezId
                      WHERE tblSodoorFish.fldId=@Value
                      
                      
 IF(@FieldName='Forooshande') 
SELECT     Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'')fldShomareSabt, 
                     ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, isnull(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'')fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')Telephone
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblOrganization ON Drd.tblElamAvarez.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Drd.tblSodoorFish ON Drd.tblElamAvarez.fldId = Drd.tblSodoorFish.fldElamAvarezId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                      WHERE tblSodoorFish.fldId=@Value
                                        
                      
                      
GO
