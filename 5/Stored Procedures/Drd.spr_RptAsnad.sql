SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptAsnad](@fieldname NVARCHAR(50),@Status TINYINT,@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@organId INT)
AS
--declare @fieldname NVARCHAR(50)='check',@Status TINYINT=1,@AzTarikh NVARCHAR(10)='1402/01/01',@TaTarikh NVARCHAR(10)='1402/12/01',@organId INT=1
DECLARE @azdate DATE=dbo.Fn_AssembelyShamsiToMiladiDate(@AzTarikh),@tadate DATE=dbo.Fn_AssembelyShamsiToMiladiDate(@TaTarikh)

IF(@fieldname='Barat')
SELECT    fldBaratDarId AS fldId,   ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad,  
'' AS fldTypeSanadName,'' AS fldShomareHesab,'' fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(b.flddate) AS fldTarikhAkhz,'' AS TarikhVosool
,/*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/fldElamAvarezId AS fldElamAvarezId
, Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs
FROM         Drd.tblBarat b inner join 
drd.tblReplyTaghsit r on r.fldid=b.fldReplyTaghsitId
inner join drd.tblElamAvarez e on e.fldId=r.fldElamAvarezId

WHERE /*fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))*/e.fldOrganId=@organid
AND fldTarikhSarResid >= @AzTarikh AND fldTarikhSarResid<=@TaTarikh AND fldStatus=@Status


IF(@fieldname='Barat_Date')
SELECT    fldBaratDarId AS fldId,   ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad,  
'' AS fldTypeSanadName,'' AS fldShomareHesab,'' fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(b.flddate) AS fldTarikhAkhz,'' AS TarikhVosool
,/*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/fldElamAvarezId AS fldElamAvarezId
, Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs
FROM         Drd.tblBarat b inner join 
drd.tblReplyTaghsit r on r.fldid=b.fldReplyTaghsitId
inner join drd.tblElamAvarez e on e.fldId=r.fldElamAvarezId

WHERE /*fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))*/e.fldOrganId=@organid
AND cast(b.fldDate as date) >= @azdate AND cast(b.fldDate as date)<=@tadate




IF(@fieldname='Check')
BEGIN
IF(@Status=1) 

select * from (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                   isnull(elam. fldElamAvarezId,0)fldElamAvarezId ,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					  outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh AND fldTarikhSarResid<=@TaTarikh AND fldStatus=@Status)t


else
select * from (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                      /*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
					  isnull(elam. fldElamAvarezId,0)  AS fldElamAvarezId,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					 outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldDateStatus >= @AzTarikh AND fldDateStatus<= @TaTarikh AND fldStatus=@Status )r
order by fldTarikhAkhz,fldElamAvarezId
END


IF(@fieldname='Check_Date')
BEGIN
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                      /*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
					   isnull(elam. fldElamAvarezId,0)  AS fldElamAvarezId,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					  outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND tblCheck.fldTarikhAkhz >= @AzTarikh AND tblCheck.fldTarikhAkhz<=@TaTarikh 

END

---------------------
IF(@fieldname='Check_Adi')
BEGIN
IF(@Status=1) 

select * from (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                   isnull(elam. fldElamAvarezId,0)fldElamAvarezId ,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					  outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh AND fldTarikhSarResid<=@TaTarikh AND fldStatus=@Status and fldTypeSanad=0)t


else
select * from (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                      /*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
					  isnull(elam. fldElamAvarezId,0)  AS fldElamAvarezId,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					 outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldDateStatus >= @AzTarikh AND fldDateStatus<= @TaTarikh AND fldStatus=@Status and fldTypeSanad=0 )r
order by fldTarikhAkhz,fldElamAvarezId
END


IF(@fieldname='Check_Date_Adi')
BEGIN
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                      /*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
					   isnull(elam. fldElamAvarezId,0)  AS fldElamAvarezId,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					  outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND tblCheck.fldTarikhAkhz >= @AzTarikh AND tblCheck.fldTarikhAkhz<=@TaTarikh and fldTypeSanad=0 

END

----------------------
IF(@fieldname='Check_Zemanat')
BEGIN
IF(@Status=1) 

select * from (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                   isnull(elam. fldElamAvarezId,0)fldElamAvarezId ,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					  outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh AND fldTarikhSarResid<=@TaTarikh AND fldStatus=@Status and fldTypeSanad=1)t


else
select * from (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                      /*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
					  isnull(elam. fldElamAvarezId,0)  AS fldElamAvarezId,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					 outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldDateStatus >= @AzTarikh AND fldDateStatus<= @TaTarikh AND fldStatus=@Status and fldTypeSanad=1 )r
order by fldTarikhAkhz,fldElamAvarezId
END


IF(@fieldname='Check_Date_Zemanat')
BEGIN
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid,
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghSanad
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName+'_'+ 
                      Com.tblSHobe.fldName AS fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.flddate)AS fldTarikhAkhz,'' AS TarikhVosool,
                      /*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
					   isnull(elam. fldElamAvarezId,0)  AS fldElamAvarezId,isnull( Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID),'') AS fldNameShakhs
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId
					  outer apply (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif 
					  WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId))
				)elam
				outer apply (select fldAshakhasID from  drd.tblElamAvarez where fldid=elam.fldElamAvarezId)avarez
                      WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND tblCheck.fldTarikhAkhz >= @AzTarikh AND tblCheck.fldTarikhAkhz<=@TaTarikh and fldTypeSanad=1 

END


IF(@fieldname='Safte')
SELECT      Drd.tblSafte.fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(fldMablaghSanad,CAST(0 AS TINYINT)) AS fldMablaghSanad,'' fldTypeSanadName  
,''fldShomareHesab,'' fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblSafte.flddate) AS fldTarikhAkhz,'' AS TarikhVosool
,/*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
fldElamAvarezId AS fldElamAvarezId , Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs
FROM         Drd.tblSafte
inner join drd.tblReplyTaghsit r on r.fldid=fldReplyTaghsitId
inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
WHERE e.fldOrganId=@organId/*fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))*/
AND fldTarikhSarResid >= @AzTarikh AND fldTarikhSarResid<=@TaTarikh AND fldStatus=@Status



IF(@fieldname='Safte_Date')

SELECT      Drd.tblSafte.fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(fldMablaghSanad,CAST(0 AS TINYINT)) AS fldMablaghSanad,'' fldTypeSanadName  
,''fldShomareHesab,'' fldNameShobe,dbo.Fn_AssembelyMiladiToShamsi(tblSafte.flddate) AS fldTarikhAkhz,'' AS TarikhVosool
,/*ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0)*/
fldElamAvarezId AS fldElamAvarezId , Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs
FROM         Drd.tblSafte
inner join drd.tblReplyTaghsit r on r.fldid=fldReplyTaghsitId
inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
WHERE  e.fldOrganId=@organId /*fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))*/
AND cast(tblSafte.fldDate as date) >= @azdate AND cast(tblSafte.fldDate as date)<=@tadate 
GO
