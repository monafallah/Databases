SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptSooratHesabForoosh](@IdElamAvarez INT )
AS 
SELECT   tblCodhayeDaramadiElamAvarez.fldID,  ISNULL(Drd.tblCodhayeDaramd.fldDaramadCode,0)fldDaramadCode,ISNULL( Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,'')AS fldSharheCodeDaramad, ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldTedad,0)AS fldTedad, 
                     ISNULL(Com.tblMeasureUnit.fldNameVahed,'')AS fldNameVahed,ISNULL(fldAsliValue,0)AS fldAsliValue,/*ISNULL((SELECT fldMablagh FROM Drd.tblReplyTakhfif WHERE fldStatusId =(SELECT fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =(SELECT TOP(1) CASE WHEN fldId NOT IN (SELECT fldId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldId) THEN fldId ELSE 0 end FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@IdElamAvarez AND fldRequestType=2 ORDER BY fldId DESC ) ) ),0)*/
					drd.Fn_MablaghTakhfif('mablaghTakhfif',@IdElamAvarez) AS fldTakhfif
					 ,ISNULL((fldAvarezValue+fldMaliyatValue),0) AS fldMaliyat,ISNULL((fldAmuzeshParvareshValue),0) AS fldAmuzeshParvareshValue,
				ISNULL((SELECT TOP(1) CASE WHEN fldId IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeMojavez=1 AND fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND fldId NOT IN (SELECT fldId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'0' ELSE N'1' end FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@IdElamAvarez  AND fldRequestType=1 ORDER BY fldId desc),1) AS fldNahveForoosh
FROM         Drd.tblElamAvarez INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblCodhayeDaramd.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId INNER JOIN
                      Com.tblMeasureUnit ON Drd.tblCodhayeDaramd.fldUnitId = Com.tblMeasureUnit.fldId
                      WHERE fldElamAvarezId=@IdElamAvarez AND tblElamAvarez.fldOrganId=Drd.tblShomareHesabCodeDaramad.fldOrganId
                      
                      
GO
