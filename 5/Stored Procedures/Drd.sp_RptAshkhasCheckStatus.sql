SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[sp_RptAshkhasCheckStatus]
@AshkhasId int
as
--select @FromDate,@ToDate
SELECT  fldId,fldNameShakhs
  ,  fldTarikh,isnull(fldFather_Sabt,'')fldFather_Sabt,fldMablaghKoli,
  fldMablaghTakhfif,ISNULL((fldMablaghKoli/*-fldMablaghTakhfif*/),0) AS fldMablaghGHabelPardakht
,fldNameOrgan
 ,SharhDesc
 ,fldTarikhSarResid,fldDateStatus,fldStatusName,fldCountCheck,fldShomareSanad,fldMablaghCheck,fldMablaghTaghsit
 ,fldMablaghNaghdi,fldMablaghNaghdiPardakhtNashode
 FROM(SELECT  e.fldId, e.fldDesc,   
                  Com.fn_NameAshkhasHaghighi_Hoghoghi(fldAshakhasID) AS fldNameShakhs, 
            e.fldTarikh ,
                      (SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN(SELECT fldFatherName FROM  Com.tblEmployee_Detail WHERE   fldEmployeeId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                      (SELECT fldShomareSabt FROM      Com.tblAshkhaseHoghoghi WHERE   fldid = fldHoghoghiId) END AS Expr1 FROM Com.tblAshkhas AS tblAshkhas_1 WHERE   (fldId = e.fldAshakhasID)) AS fldFather_Sabt
                  
                      ,isnull((SELECT isnull(SUM(fldTakhfifMaliyatValue+fldSumAsli+fldTakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue),SUM(fldMaliyatValue+fldSumAsli+fldAvarezValue+fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=e.fldId),cast(0 as bigint)) fldMablaghKoli,
						ISNULL(cast(drd.Fn_MablaghTakhfif('MablaghTakhfif_ElamAvarez',e.fldId) AS BIGINT),CAST(0 AS BIGINT)) AS fldMablaghTakhfif
						,(SELECT com.fn_stringDecode(fldName) FROM Com.tblOrganization WHERE fldid=e.fldOrganId)AS fldNameOrgan
,drd.fn_SharheCode_ElamAvarez(e.fldid) AS SharhDesc
 ,ISNULL(c.fldTarikhSarResid, '') AS fldTarikhSarResid,fldDateStatus,
                      ISNULL(cast(c.fldMablaghSanad as bigint ), cast(0 as bigint))AS fldMablaghCheck
                     , CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      fldTarikhAkhz ,fldStatus,
					  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName
,COUNT(*) over (partition by q.fldElamAvarezId) as fldCountCheck,c.fldShomareSanad
,sum(fldMablaghSanad)over (partition by q.fldElamAvarezId) as fldMablaghTaghsit
 ,isnull(naghd.fldMablaghNaghdi,0) as fldMablaghNaghdi,isnull(fldMablaghNaghdiPardakhtNashode,cast(0 as bigint)) as fldMablaghNaghdiPardakhtNashode
from Drd.tblElamAvarez as e
	inner join Drd.tblRequestTaghsit_Takhfif as q on  e.fldId=q.fldElamAvarezId
	inner join Drd.tblStatusTaghsit_Takhfif as s on q.fldId=s.fldRequestId
	INNER JOIN  Drd.tblReplyTaghsit as r on s.fldId=r.fldStatusId
	INNER JOIN   Drd.tblCheck as c  on r.fldId=c.fldReplyTaghsitId

outer apply(
	select  sum(n.fldMablagh) as fldMablaghNaghdi  from Drd.tblNaghdi_Talab as n
	INNER JOIN  Drd.tblReplyTaghsit as r on r.fldId=n.fldReplyTaghsitId
	inner join  Drd.tblStatusTaghsit_Takhfif as s on s.fldId=r.fldStatusId
	inner join Drd.tblRequestTaghsit_Takhfif as q on q.fldId=s.fldRequestId
	inner join Drd.tblPardakhtFish as p on p.fldFishId=n.fldFishId
	WHERE q.fldElamAvarezId= e.fldId and n.fldType = 1
)naghd
outer apply(
	select  sum(n.fldMablagh) as fldMablaghNaghdiPardakhtNashode  from Drd.tblNaghdi_Talab as n
	INNER JOIN  Drd.tblReplyTaghsit as r on r.fldId=n.fldReplyTaghsitId
	inner join  Drd.tblStatusTaghsit_Takhfif as s on s.fldId=r.fldStatusId
	inner join Drd.tblRequestTaghsit_Takhfif as q on q.fldId=s.fldRequestId
	left outer join Drd.tblPardakhtFish as p on p.fldFishId=n.fldFishId
	WHERE q.fldElamAvarezId= e.fldId  and n.fldType = 1 and p.fldFishId is null
)pardakht
	WHERE  e.fldAshakhasID=@AshkhasId
)t
	ORDER BY t.fldid DESC



GO
