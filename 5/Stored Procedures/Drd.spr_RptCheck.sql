SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptCheck](@FieldName NVARCHAR(50),@Value NVARCHAR(50),@azTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10))
AS
IF(@FieldName='CheckId')
SELECT     Drd.tblCheck.fldTarikhSarResid, Drd.tblCheck.fldShomareSanad, Com.tblShomareHesabeOmoomi.fldShomareHesab,cast(Drd.tblCheck.fldMablaghSanad as bigint )fldMablaghSanad, 
                      Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,Drd.tblCheck.fldTarikhAkhz,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldFamily + ' ' + fldname
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId)) AS fldName, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldNameShobe, 
                      tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan, tblSHobe_1.fldName AS fldShobeOrgan, tblBank_1.fldBankName AS fldBankOrgan
                      ,tblRequestTaghsit_Takhfif.fldDesc ,(SELECT  (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT   case when  fldFatherName<>'' and fldFatherName is not null then  fldFamily collate SQL_Latin1_General_CP1_CI_AS+ ' ' + fldname collate SQL_Latin1_General_CP1_CI_AS+'_'+fldFatherName+'('+fldCodemeli+')'
																		else fldFamily+' '+fldname +'('+fldCodemeli+')' end
                                                         FROM          Com.tblEmployee left join 
														 com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldId
                                                         WHERE      tblEmployee.fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName+'_'+fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = tblElamAvarez.fldAshakhasID)) FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldNameMoadi,
isnull((SELECT   (SELECT  fldMobile
                            FROM          Com.tblAshkhas inner join com.tblEmployee_Detail on tblAshkhas.fldHaghighiId=tblEmployee_Detail.fldEmployeeId

                            WHERE      (tblAshkhas.fldId = tblElamAvarez.fldAshakhasID))FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId),'') AS fldmobile
							FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON tblShomareHesabeOmoomi_1.fldId = Drd.tblCheck.fldShomareHesabIdOrgan INNER JOIN
                      Com.tblSHobe AS tblSHobe_1 ON tblSHobe_1.fldId = tblShomareHesabeOmoomi_1.fldShobeId INNER JOIN
                      Com.tblBank AS tblBank_1 ON tblBank_1.fldId = tblSHobe_1.fldBankId
                      WHERE tblCheck.fldId=@Value 
                      ORDER BY fldTarikhSarResid
                      
                      
 IF(@FieldName='ReplyId')
SELECT     Drd.tblCheck.fldTarikhSarResid, Drd.tblCheck.fldShomareSanad, Com.tblShomareHesabeOmoomi.fldShomareHesab,cast(Drd.tblCheck.fldMablaghSanad as bigint )fldMablaghSanad, 
                      Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,Drd.tblCheck.fldTarikhAkhz,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldFamily + ' ' + fldname
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId)) AS fldName, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldNameShobe, 
                      tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan, tblSHobe_1.fldName AS fldShobeOrgan, tblBank_1.fldBankName AS fldBankOrgan
				    ,tblRequestTaghsit_Takhfif.fldDesc ,(SELECT  (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT   case when  fldFatherName<>'' and fldFatherName is not null then  fldFamily collate SQL_Latin1_General_CP1_CI_AS+ ' ' + fldname collate SQL_Latin1_General_CP1_CI_AS+'_'+fldFatherName+'('+fldCodemeli+')'
																		else fldFamily+' '+fldname +'('+fldCodemeli+')' end
                                                         FROM          Com.tblEmployee left join 
														 com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldId
                                                         WHERE      tblEmployee.fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName+'_'+fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = tblElamAvarez.fldAshakhasID)) FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldNameMoadi,
isnull((SELECT   (SELECT  fldMobile
                            FROM          Com.tblAshkhas inner join com.tblEmployee_Detail on tblAshkhas.fldHaghighiId=tblEmployee_Detail.fldEmployeeId

                            WHERE      (tblAshkhas.fldId = tblElamAvarez.fldAshakhasID))FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId),'') AS fldmobile
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON tblShomareHesabeOmoomi_1.fldId = Drd.tblCheck.fldShomareHesabIdOrgan INNER JOIN
                      Com.tblSHobe AS tblSHobe_1 ON tblSHobe_1.fldId = tblShomareHesabeOmoomi_1.fldShobeId INNER JOIN
                      Com.tblBank AS tblBank_1 ON tblBank_1.fldId = tblSHobe_1.fldBankId
                      WHERE fldReplyTaghsitId=@Value  AND fldTypeSanad=0     
                       ORDER BY fldTarikhSarResid
                      
  IF(@FieldName='AzTarikh_TaTarikh')
  BEGIN
  IF(@azTarikh<>'' AND @TaTarikh<>'')
SELECT     Drd.tblCheck.fldTarikhSarResid, Drd.tblCheck.fldShomareSanad, Com.tblShomareHesabeOmoomi.fldShomareHesab,cast(Drd.tblCheck.fldMablaghSanad as bigint )fldMablaghSanad, 
                      Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,Drd.tblCheck.fldTarikhAkhz,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldFamily + ' ' + fldname
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId)) AS fldName, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldNameShobe, 
                      tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan, tblSHobe_1.fldName AS fldShobeOrgan, tblBank_1.fldBankName AS fldBankOrgan
			    ,tblRequestTaghsit_Takhfif.fldDesc ,(SELECT  (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT   case when  fldFatherName<>'' and fldFatherName is not null then  fldFamily collate SQL_Latin1_General_CP1_CI_AS+ ' ' + fldname collate SQL_Latin1_General_CP1_CI_AS+'_'+fldFatherName+'('+fldCodemeli+')'
																		else fldFamily+' '+fldname +'('+fldCodemeli+')' end
                                                         FROM          Com.tblEmployee left join 
														 com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldId
                                                         WHERE      tblEmployee.fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName+'_'+fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = tblElamAvarez.fldAshakhasID)) FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldNameMoadi,
isnull((SELECT   (SELECT  fldMobile
                            FROM          Com.tblAshkhas inner join com.tblEmployee_Detail on tblAshkhas.fldHaghighiId=tblEmployee_Detail.fldEmployeeId

                            WHERE      (tblAshkhas.fldId = tblElamAvarez.fldAshakhasID))FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId),'') AS fldmobile
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON tblShomareHesabeOmoomi_1.fldId = Drd.tblCheck.fldShomareHesabIdOrgan INNER JOIN
                      Com.tblSHobe AS tblSHobe_1 ON tblSHobe_1.fldId = tblShomareHesabeOmoomi_1.fldShobeId INNER JOIN
                      Com.tblBank AS tblBank_1 ON tblBank_1.fldId = tblSHobe_1.fldBankId
                      WHERE tblCheck.fldTarikhSarResid BETWEEN @azTarikh AND @TaTarikh   
                      AND fldTypeSanad=0     
                       ORDER BY fldTarikhSarResid
 
  IF(@azTarikh='' AND @TaTarikh='')
SELECT     Drd.tblCheck.fldTarikhSarResid, Drd.tblCheck.fldShomareSanad, Com.tblShomareHesabeOmoomi.fldShomareHesab,cast(Drd.tblCheck.fldMablaghSanad as bigint )fldMablaghSanad, 
                      Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,Drd.tblCheck.fldTarikhAkhz,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldFamily + ' ' + fldname
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId)) AS fldName, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldNameShobe, 
                      tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan, tblSHobe_1.fldName AS fldShobeOrgan, tblBank_1.fldBankName AS fldBankOrgan
				    ,tblRequestTaghsit_Takhfif.fldDesc ,(SELECT  (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT   case when  fldFatherName<>'' and fldFatherName is not null then  fldFamily collate SQL_Latin1_General_CP1_CI_AS+ ' ' + fldname collate SQL_Latin1_General_CP1_CI_AS+'_'+fldFatherName+'('+fldCodemeli+')'
																		else fldFamily+' '+fldname +'('+fldCodemeli+')' end
                                                         FROM          Com.tblEmployee left join 
														 com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldId
                                                         WHERE      tblEmployee.fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName+'_'+fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = tblElamAvarez.fldAshakhasID)) FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldNameMoadi,
isnull((SELECT   (SELECT  fldMobile
                            FROM          Com.tblAshkhas inner join com.tblEmployee_Detail on tblAshkhas.fldHaghighiId=tblEmployee_Detail.fldEmployeeId

                            WHERE      (tblAshkhas.fldId = tblElamAvarez.fldAshakhasID))FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId),'') AS fldmobile
							FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON tblShomareHesabeOmoomi_1.fldId = Drd.tblCheck.fldShomareHesabIdOrgan INNER JOIN
                      Com.tblSHobe AS tblSHobe_1 ON tblSHobe_1.fldId = tblShomareHesabeOmoomi_1.fldShobeId INNER JOIN
                      Com.tblBank AS tblBank_1 ON tblBank_1.fldId = tblSHobe_1.fldBankId
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Value ))
and fldTypeSanad=0     
 ORDER BY fldTarikhSarResid
            

  IF(@azTarikh<>'' AND @TaTarikh='')
SELECT     Drd.tblCheck.fldTarikhSarResid, Drd.tblCheck.fldShomareSanad, Com.tblShomareHesabeOmoomi.fldShomareHesab,cast(Drd.tblCheck.fldMablaghSanad as bigint )fldMablaghSanad, 
                      Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,Drd.tblCheck.fldTarikhAkhz,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldFamily + ' ' + fldname
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId)) AS fldName, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldNameShobe, 
                      tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan, tblSHobe_1.fldName AS fldShobeOrgan, tblBank_1.fldBankName AS fldBankOrgan
					    ,tblRequestTaghsit_Takhfif.fldDesc ,(SELECT  (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT   case when  fldFatherName<>'' and fldFatherName is not null then  fldFamily collate SQL_Latin1_General_CP1_CI_AS+ ' ' + fldname collate SQL_Latin1_General_CP1_CI_AS+'_'+fldFatherName+'('+fldCodemeli+')'
																		else fldFamily+' '+fldname +'('+fldCodemeli+')' end
                                                         FROM          Com.tblEmployee left join 
														 com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldId
                                                         WHERE      tblEmployee.fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName+'_'+fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = tblElamAvarez.fldAshakhasID)) FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldNameMoadi,
isnull((SELECT   (SELECT  fldMobile
                            FROM          Com.tblAshkhas inner join com.tblEmployee_Detail on tblAshkhas.fldHaghighiId=tblEmployee_Detail.fldEmployeeId

                            WHERE      (tblAshkhas.fldId = tblElamAvarez.fldAshakhasID))FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId),'') AS fldmobile
							FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON tblShomareHesabeOmoomi_1.fldId = Drd.tblCheck.fldShomareHesabIdOrgan INNER JOIN
                      Com.tblSHobe AS tblSHobe_1 ON tblSHobe_1.fldId = tblShomareHesabeOmoomi_1.fldShobeId INNER JOIN
                      Com.tblBank AS tblBank_1 ON tblBank_1.fldId = tblSHobe_1.fldBankId
                      WHERE tblCheck.fldTarikhSarResid >=@azTarikh AND fldTypeSanad=0     
                       AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Value ))
 ORDER BY fldTarikhSarResid
 
  IF(@azTarikh='' AND @TaTarikh<>'')
SELECT     Drd.tblCheck.fldTarikhSarResid, Drd.tblCheck.fldShomareSanad, Com.tblShomareHesabeOmoomi.fldShomareHesab,cast(Drd.tblCheck.fldMablaghSanad as bigint )fldMablaghSanad, 
                      Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,Drd.tblCheck.fldTarikhAkhz,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldFamily + ' ' + fldname
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId)) AS fldName, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldNameShobe, 
                      tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan, tblSHobe_1.fldName AS fldShobeOrgan, tblBank_1.fldBankName AS fldBankOrgan
						    ,tblRequestTaghsit_Takhfif.fldDesc ,(SELECT  (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT   case when  fldFatherName<>'' and fldFatherName is not null then  fldFamily collate SQL_Latin1_General_CP1_CI_AS+ ' ' + fldname collate SQL_Latin1_General_CP1_CI_AS+'_'+fldFatherName+'('+fldCodemeli+')'
																		else fldFamily+' '+fldname +'('+fldCodemeli+')' end
                                                         FROM          Com.tblEmployee left join 
														 com.tblEmployee_Detail d on d.fldEmployeeId=tblEmployee.fldId
                                                         WHERE      tblEmployee.fldid = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldName+'_'+fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = tblElamAvarez.fldAshakhasID)) FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldNameMoadi,
isnull((SELECT   (SELECT  fldMobile
                            FROM          Com.tblAshkhas inner join com.tblEmployee_Detail on tblAshkhas.fldHaghighiId=tblEmployee_Detail.fldEmployeeId

                            WHERE      (tblAshkhas.fldId = tblElamAvarez.fldAshakhasID))FROM Drd.tblElamAvarez WHERE tblElamAvarez.fldid=tblRequestTaghsit_Takhfif.fldElamAvarezId),'') AS fldmobile
							FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON tblShomareHesabeOmoomi_1.fldId = Drd.tblCheck.fldShomareHesabIdOrgan INNER JOIN
                      Com.tblSHobe AS tblSHobe_1 ON tblSHobe_1.fldId = tblShomareHesabeOmoomi_1.fldShobeId INNER JOIN
                      Com.tblBank AS tblBank_1 ON tblBank_1.fldId = tblSHobe_1.fldBankId
                      WHERE 
                      tblCheck.fldTarikhSarResid <=@TaTarikh    AND 
                       fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Value ))
AND fldTypeSanad=0     
  ORDER BY fldTarikhSarResid                    
      end 
GO
