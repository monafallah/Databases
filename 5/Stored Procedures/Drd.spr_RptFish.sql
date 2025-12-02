SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptFish](@fieldName nvarchar(50), @value INT)
as
--declare @value nvarchar(50)='1401162331'
declare @tarikh varchar(10)=dbo.Fn_AssembelyMiladiToShamsi(getdate())
if (@fieldName='Fish')
SELECT     Drd.tblSodoorFish.fldId AS fldSerialFish, Drd.tblSodoorFish.fldTarikh AS fldTarikhSodoor, Drd.tblSodoorFish.fldJamKol, 
                      Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Com.tblBank.fldBankName, Com.tblSHobe.fldName AS fldShobeName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldName + ' ' + fldFamily
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     tblAshkhaseHoghoghi.fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldid = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldName,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldCodemeli
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldid = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas AS tblAshkhas_2
                            WHERE      (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNationalCode, (SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN   Drd.tblSodoorFish.fldShenaseGhabz ELSE '' end  FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId) AS fldShenaseGhabz, (SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN   Drd.tblSodoorFish.fldShenasePardakht ELSE '' end  FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId) AS fldShenasePardakht, 
                      ISNULL
                          ((SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                        (SELECT     fldCodePosti
                                                          FROM          Com.tblEmployee_Detail
                                                          WHERE      fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                        (SELECT     '1'
                                                          FROM          Com.tblAshkhaseHoghoghi
                                                          WHERE      fldid = fldHoghoghiId) END AS Expr1
                              FROM         Com.tblAshkhas AS tblAshkhas_1
                              WHERE     (fldId = Drd.tblElamAvarez.fldAshakhasID)), '') AS fldCodePosti, 
                            case when elam is not null and reply is not null then '('+elam+';'+reply+')' when elam is not null  then '('+elam+')'
							when reply is not null  then '('+reply+')'
							 else '' end +
									 CASE WHEN tblSodoorFish.fldId IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=tblSodoorFish.fldId) THEN Drd.tblElamAvarez.fldDesc 
									ELSE (SELECT fldDesc FROM Drd.tblNaghdi_Talab WHERE fldFishId=tblSodoorFish.fldId) end AS fldDesc
							 , (CASE when fldBarcode IS NOT NULL AND EXISTS(SELECT * FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldChapShenaseGhabz_Pardakht=1) THEN fldBarcode ELSE cast (Drd.tblSodoorFish.fldId AS NVARCHAR(50)) END) AS fldBarcode
							, isnull((SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     tblEmployee_Detail.fldAddress
                                                         FROM          Com.tblEmployee_Detail
                                                         WHERE      fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT    tblAshkhaseHoghoghi_Detail.fldAddress
                                                         FROM          Com.tblAshkhaseHoghoghi_Detail
                                                         WHERE      fldAshkhaseHoghoghiId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Drd.tblElamAvarez.fldAshakhasID)),'') AS fldAddress
							,tblEmployee.fldName+' '+fldFamily as fldNameSaderKonande
FROM         Drd.tblSodoorFish INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblSodoorFish.fldElamAvarezId inner join 
					  com.tblUser on tblSodoorFish.fldUserId =tblUser.fldid inner join 
					  com.tblEmployee on fldEmployId= tblEmployee.fldid
					 outer apply (select stuff((select +';' +cast(cast(c.fldDarsadTakhfif as float) as varchar(10))+N'درصد تخفیف کد درآمد '+code.fldDaramadCode
											 from drd.tblCodhayeDaramadiElamAvarez c
											 inner join drd.tblShomareHesabCodeDaramad s on s.fldid=c.fldShomareHesabCodeDaramadId
											 inner join drd.tblCodhayeDaramd code on code.fldid=s.fldCodeDaramadId 
											 where c.fldElamAvarezId=tblSodoorFish.fldElamAvarezId for xml path('') ),1,1,'')elam
								)codeElam
					outer apply (
								   select +';'+cast(cast(fldDarsad as float) as varchar(10))+N'درصد تخفیف اعمال شده کل فیش ' reply
								   from drd.tblReplyTakhfif inner join drd.tblStatusTaghsit_Takhfif
								  on fldStatusId=tblStatusTaghsit_Takhfif.fldid inner join 
								  drd.tblRequestTaghsit_Takhfif on fldRequestId=tblRequestTaghsit_Takhfif.fldid
								  where tblRequestTaghsit_Takhfif.fldElamAvarezId=tblSodoorFish.fldElamAvarezId 
					  )replyTakhfif
					  
                      WHERE tblSodoorFish.fldId=@value AND tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=@value) 


					  
if( @fieldName='Taghsit')
SELECT     Drd.tblElamAvarez.fldId AS fldSerialFish, Drd.tblElamAvarez.fldTarikh AS fldTarikhSodoor,  sum(ISNULL(cast((c.fldTakhfifAsliValue * c.fldTedad + c.fldTakhfifAvarezValue + c.fldTakhfifMaliyatValue)as bigint),
										  cast((c.fldAsliValue * c.fldTedad + c.fldAvarezValue + c.fldMaliyatValue)as bigint)))
					fldJamKol, 
                      sum(ISNULL(cast((c.fldTakhfifAsliValue * c.fldTedad + c.fldTakhfifAvarezValue + c.fldTakhfifMaliyatValue)as bigint),
										  cast((c.fldAsliValue * c.fldTedad + c.fldAvarezValue + c.fldMaliyatValue)as bigint))) fldMablaghAvarezGerdShode,''fldBankName, ''fldShobeName, 
                      ''fldShomareHesab,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldName + ' ' + fldFamily
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     tblAshkhaseHoghoghi.fldName
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldid = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldName,
                          (SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     fldCodemeli
                                                         FROM          Com.tblEmployee
                                                         WHERE      fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT     fldShenaseMelli
                                                         FROM          Com.tblAshkhaseHoghoghi
                                                         WHERE      fldid = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas AS tblAshkhas_2
                            WHERE      (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS fldNationalCode, '' AS fldShenasePardakht, 
                      ISNULL
                          ((SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                        (SELECT     fldCodePosti
                                                          FROM          Com.tblEmployee_Detail
                                                          WHERE      fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                        (SELECT     '1'
                                                          FROM          Com.tblAshkhaseHoghoghi
                                                          WHERE      fldid = fldHoghoghiId) END AS Expr1
                              FROM         Com.tblAshkhas AS tblAshkhas_1
                              WHERE     (fldId = Drd.tblElamAvarez.fldAshakhasID)), '') AS fldCodePosti, 
                          N'درخواست تقسیط ثبت شده است .' fldDesc,'' fldBarcode
							, isnull((SELECT     CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                       (SELECT     tblEmployee_Detail.fldAddress
                                                         FROM          Com.tblEmployee_Detail
                                                         WHERE      fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                       (SELECT    tblAshkhaseHoghoghi_Detail.fldAddress
                                                         FROM          Com.tblAshkhaseHoghoghi_Detail
                                                         WHERE      fldAshkhaseHoghoghiId = fldHoghoghiId) END AS Expr1
                            FROM          Com.tblAshkhas
                            WHERE      (fldId = Drd.tblElamAvarez.fldAshakhasID)),'') AS fldAddress
							,'' as fldNameSaderKonande
FROM    
                      Drd.tblElamAvarez  
					  inner join drd.tblCodhayeDaramadiElamAvarez c on c.fldElamAvarezId=tblElamAvarez .fldid
					
					  
                      WHERE tblElamAvarez.fldId=@value 

					  group by  Drd.tblElamAvarez.fldId , Drd.tblElamAvarez.fldTarikh ,Drd.tblElamAvarez.fldAshakhasID
GO
