SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_Ashkhas_Taghsit](@ElamAvarId INT)
AS
DECLARE @RequestId INT,@StatusId INT,@ReplyTaghsit INT
SELECT TOP(1) @RequestId=fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarId AND fldRequestType = 1  AND fldId NOT in(select drd.tblEbtal.fldRequestTaghsit_TakhfifId from drd.tblEbtal WHERE drd.tblEbtal.fldRequestTaghsit_TakhfifId=drd.tblRequestTaghsit_Takhfif.fldid )  ORDER BY fldId DESC
SELECT @StatusId=fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=@RequestId and tblStatusTaghsit_Takhfif.fldTypeMojavez=1 and tblStatusTaghsit_Takhfif.fldTypeRequest=1
SELECT @ReplyTaghsit=fldId FROM Drd.tblReplyTaghsit WHERE fldStatusId=@StatusId

SELECT     Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, 
ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, 
ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad,
ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
 CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht,  
CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus,
ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, 
Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId
, '' AS fldNameBaratDar,Drd.tblCheck.fldShomareHesabIdOrgan, 
tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,dbo.Fn_AssembelyMiladiToShamsi(tblCheck.fldDate) AS fldTarikhSabt
,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
WHERE fldReplyTaghsitId=@ReplyTaghsit


UNION ALL
SELECT    fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, 
ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, 
0,0,CAST(3 AS TINYINT),'',
N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,0 ,''
					,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
FROM         Drd.tblSafte
WHERE fldReplyTaghsitId=@ReplyTaghsit

UNION ALL
SELECT   fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,
 ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad,
  0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), 
  ISNULL(fldMakanPardakht,'')AS fldMakanPardakht
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,0 ,'',
dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'' AS TarikhPardakht
FROM         Drd.tblBarat
WHERE fldReplyTaghsitId=@ReplyTaghsit
GO
