SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[prs_FishSaderShodeForXmlOut]
@FieldName NVARCHAR(50),@value  NVARCHAR(50),@h INT
as
--SELECT 0 AS MablaghPardakhtShode,0 AS Avarez,0 AS Maliyat,'' AS TarikhSodoor,'' AS NoePardakht,'' AS CodeRahgiri,
--'' AS CodeErja,'' AS TarikhVarizBeHesab,'' AS ShomareHesabVariz,'' AS Infi_Bank,'' AS OrganName,'' AS ShenaseMeliOrgan,
--'' AS NameBank,'' AS NoeMoadi,'' AS NameMoadi,''AS FamilyMoadi,'' AS CodeMeli,'' AS NoeSherkat,'' AS ShenaseMeliSherkat,
--'' AS ShomareSabt,0 AS CodeDaramadElamAvarez
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
IF(@FieldName='')
SELECT    TOP(@h) Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghPardakhtShode,
(SELECT     SUM(ISNULL(fldTakhfifAvarezValue, a.fldAvarezValue))  FROM Drd.tblCodhayeDaramadiElamAvarez AS a
 WHERE      (fldElamAvarezId = Drd.tblSodoorFish.fldElamAvarezId))Avarez 
,(SELECT     SUM(ISNULL(a.fldTakhfifMaliyatValue, fldMaliyatValue)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a
                            WHERE      (fldElamAvarezId = Drd.tblSodoorFish.fldElamAvarezId))Maliyat
 ,(SELECT     SUM(ISNULL(a.fldTakhfifAmuzeshParvareshValue, fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a
                            WHERE      (fldElamAvarezId = Drd.tblSodoorFish.fldElamAvarezId))AmuzeshParvaresh                          
 ,tblSodoorFish.fldTarikh AS TarikhSodoor,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldNahvePardakhtId AS NoePardakht
 ,ISNULL((SELECT fldTrackingCode FROM Drd.tblPcPosTransaction AS b WHERE b.fldFishId=Drd.tblSodoorFish.fldid AND b.fldStatus=1),'' )CodeRahgiri  ,
 '' AS CodeErja, '' AS TarikhVarizBeHesab,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi AS c WHERE c.fldid=fldShomareHesabId)AS  ShomareHesabVariz  
 ,(SELECT fldInfinitiveBank    
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId WHERE tblShomareHesabeOmoomi.fldid=fldShomareHesabId)as Infi_Bank              
 ,(SELECT   com.fn_stringDecode( Com.tblOrganization.fldName)
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblOrganization ON Drd.tblElamAvarez.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                       WHERE tblElamAvarez.fldid=fldElamAvarezId) as OrganName                                                
 ,(SELECT  fldShenaseMelli
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblOrganization ON Drd.tblElamAvarez.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                       WHERE tblElamAvarez.fldid=fldElamAvarezId)  AS ShenaseMeliOrgan 
                       
 ,  (SELECT fldBankName+'_'+fldName   
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId WHERE tblShomareHesabeOmoomi.fldid=fldShomareHesabId) AS NameBank               
,
(SELECT   (CASE WHEN fldHoghoghiId IS NOT NULL  THEN (CASE WHEN EXISTS(SELECT * FROM Com.tblAshkhaseHoghoghi WHERE  tblAshkhaseHoghoghi.fldId =fldHoghoghiId AND fldSayer=1) THEN N'1'
WHEN EXISTS(SELECT * FROM Com.tblAshkhaseHoghoghi WHERE  tblAshkhaseHoghoghi.fldId =fldHoghoghiId AND fldSayer=2) THEN N'2' end  )
 WHEN fldHaghighiId IS NOT NULL THEN N'0' end)  
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId 
                      WHERE fldElamAvarezId=tblElamAvarez.fldId  ) AS  NoeMoadi
                      
,(SELECT     CASE WHEN fldHaghighiId IS NOT NULL then(SELECT fldName FROM Com.tblEmployee WHERE tblEmployee.fldId=fldHaghighiId)
WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) end
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId)  AS NameMoadi    
,(SELECT     CASE WHEN fldHaghighiId IS NOT NULL then(SELECT fldFamily FROM Com.tblEmployee WHERE tblEmployee.fldId=fldHaghighiId)
ELSE '' END
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId)  AS FamilyMoadi          
,(SELECT     CASE WHEN fldHaghighiId IS NOT NULL then(SELECT fldCodemeli FROM Com.tblEmployee WHERE tblEmployee.fldId=fldHaghighiId)
ELSE '' END
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) as  CodeMeli                    
,( SELECT CASE WHEN fldHoghoghiId IS NOT NULL AND EXISTS (SELECT * FROM Com.tblAshkhaseHoghoghi WHERE fldTypeShakhs=0 AND tblAshkhaseHoghoghi.fldId=fldHoghoghiId)
THEN N'0' WHEN fldHoghoghiId IS NOT NULL AND EXISTS (SELECT * FROM Com.tblAshkhaseHoghoghi WHERE fldTypeShakhs=1 AND tblAshkhaseHoghoghi.fldId=fldHoghoghiId)
THEN N'1' END 
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) as NoeSherkat             

,(SELECT CASE WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE tblAshkhaseHoghoghi.fldid=fldHoghoghiId)
ELSE '' END 
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) AS ShenaseMeliSherkat  
                      
,(SELECT CASE WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE tblAshkhaseHoghoghi.fldid=fldHoghoghiId)
ELSE '' END 
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) as ShomareSabt   

, drd.fn_IdCodeElamAvarez(tblSodoorFish.fldid) AS CodeDaramadElamAvarez,tblSodoorFish.fldId AS SerialFish   ,fldElamAvarezId AS ElamAvarezId
                                                             
FROM         Drd.tblSodoorFish INNER JOIN
                      Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
                      WHERE tblSodoorFish.fldId IN (SELECT tblSodoorFish_Detail.fldFishId FROM Drd.tblSodoorFish_Detail WHERE tblSodoorFish_Detail.fldFishId=tblSodoorFish.fldId)
                      AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) 
 
 IF(@FieldName='FishId')
SELECT    TOP(@h) Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghPardakhtShode,
(SELECT     SUM(ISNULL(fldTakhfifAvarezValue, a.fldAvarezValue))  FROM Drd.tblCodhayeDaramadiElamAvarez AS a
 WHERE      (fldElamAvarezId = Drd.tblSodoorFish.fldElamAvarezId))Avarez 
,(SELECT     SUM(ISNULL(a.fldTakhfifMaliyatValue, fldMaliyatValue)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a
                            WHERE      (fldElamAvarezId = Drd.tblSodoorFish.fldElamAvarezId))Maliyat
  ,(SELECT     SUM(ISNULL(a.fldTakhfifAmuzeshParvareshValue, fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a
                            WHERE      (fldElamAvarezId = Drd.tblSodoorFish.fldElamAvarezId))AmuzeshParvaresh                          
 ,tblSodoorFish.fldTarikh AS TarikhSodoor,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldNahvePardakhtId AS NoePardakht
 ,ISNULL((SELECT fldTrackingCode FROM Drd.tblPcPosTransaction AS b WHERE b.fldFishId=Drd.tblSodoorFish.fldid AND b.fldStatus=1),'' )CodeRahgiri  ,
 '' AS CodeErja, '' AS TarikhVarizBeHesab,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi AS c WHERE c.fldid=fldShomareHesabId)AS  ShomareHesabVariz  
 ,(SELECT fldInfinitiveBank    
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId WHERE tblShomareHesabeOmoomi.fldid=fldShomareHesabId)as Infi_Bank              
 ,(SELECT   com.fn_stringDecode( Com.tblOrganization.fldName)
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblOrganization ON Drd.tblElamAvarez.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                       WHERE tblElamAvarez.fldid=fldElamAvarezId) as OrganName                                                
 ,(SELECT  fldShenaseMelli
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblOrganization ON Drd.tblElamAvarez.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
                       WHERE tblElamAvarez.fldid=fldElamAvarezId)  AS ShenaseMeliOrgan 
                       
 ,  (SELECT fldBankName+'_'+fldName   
FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId WHERE tblShomareHesabeOmoomi.fldid=fldShomareHesabId) AS NameBank               
,
(SELECT   (CASE WHEN fldHoghoghiId IS NOT NULL  THEN (CASE WHEN EXISTS(SELECT * FROM Com.tblAshkhaseHoghoghi WHERE  tblAshkhaseHoghoghi.fldId =fldHoghoghiId AND fldSayer=1) THEN N'1'
WHEN EXISTS(SELECT * FROM Com.tblAshkhaseHoghoghi WHERE  tblAshkhaseHoghoghi.fldId =fldHoghoghiId AND fldSayer=2) THEN N'2' end  )
 WHEN fldHaghighiId IS NOT NULL THEN N'0' end)  
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId 
                      WHERE fldElamAvarezId=tblElamAvarez.fldId  ) AS  NoeMoadi
                      
,(SELECT     CASE WHEN fldHaghighiId IS NOT NULL then(SELECT fldName FROM Com.tblEmployee WHERE tblEmployee.fldId=fldHaghighiId)
WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId) end
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId)  AS NameMoadi    
,(SELECT     CASE WHEN fldHaghighiId IS NOT NULL then(SELECT fldFamily FROM Com.tblEmployee WHERE tblEmployee.fldId=fldHaghighiId)
ELSE '' END
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId)  AS FamilyMoadi          
,(SELECT     CASE WHEN fldHaghighiId IS NOT NULL then(SELECT fldCodemeli FROM Com.tblEmployee WHERE tblEmployee.fldId=fldHaghighiId)
ELSE '' END
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) as  CodeMeli                    
,( SELECT CASE WHEN fldHoghoghiId IS NOT NULL AND EXISTS (SELECT * FROM Com.tblAshkhaseHoghoghi WHERE fldTypeShakhs=0 AND tblAshkhaseHoghoghi.fldId=fldHoghoghiId)
THEN N'0' WHEN fldHoghoghiId IS NOT NULL AND EXISTS (SELECT * FROM Com.tblAshkhaseHoghoghi WHERE fldTypeShakhs=1 AND tblAshkhaseHoghoghi.fldId=fldHoghoghiId)
THEN N'1' END 
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) as NoeSherkat             

,(SELECT CASE WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE tblAshkhaseHoghoghi.fldid=fldHoghoghiId)
ELSE '' END 
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) AS ShenaseMeliSherkat  
                      
,(SELECT CASE WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE tblAshkhaseHoghoghi.fldid=fldHoghoghiId)
ELSE '' END 
FROM         Drd.tblElamAvarez INNER JOIN
                      Com.tblAshkhas ON Drd.tblElamAvarez.fldAshakhasID = Com.tblAshkhas.fldId
                      WHERE fldElamAvarezId=tblElamAvarez.fldId) as ShomareSabt   

, drd.fn_IdCodeElamAvarez(tblSodoorFish.fldid) AS CodeDaramadElamAvarez,tblSodoorFish.fldId AS SerialFish   ,fldElamAvarezId AS ElamAvarezId
                                                             
FROM         Drd.tblSodoorFish INNER JOIN
                      Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
                      WHERE tblSodoorFish.fldId IN (SELECT tblSodoorFish_Detail.fldFishId FROM Drd.tblSodoorFish_Detail WHERE tblSodoorFish_Detail.fldFishId=tblSodoorFish.fldId)
                      AND tblSodoorFish.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldid) 
              AND fldFishId=@value       
GO
