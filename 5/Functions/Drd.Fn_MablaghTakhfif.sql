SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[Fn_MablaghTakhfif](@FieldName NVARCHAR(50), @Id INT )
RETURNS BIGINT
AS
BEGIN

                    
DECLARE @Tarikh NVARCHAR(10),@Mablagh BIGINT--,@FieldName NVARCHAR(50), @Id INT=57


--SELECT @Tarikh=com.MiladiTOShamsi(fldDate) FROM Drd.tblElamAvarez WHERE fldid=@Id


--DECLARE @table TABLE (Mablagh bigint,ShomareHesabCodeDaramad INT,Tarikh NVARCHAR(10),MablaghTakhfif BIGINT,fldMashmooleKarmozd BIT,MablaghMashmool bigint)
--INSERT INTO @table
--SELECT        Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue 
--                          , Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, @Tarikh  , 0 ,
--						  tblCodhayeDaramd_1.fldMashmooleKarmozd ,0
--FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
--                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
--                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
--WHERE        (Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = @Id)
----SELECT * FROM @table

--UPDATE @table
--SET  Mablagh= ISNULL((SELECT TOP(1)  Mablagh-(Mablagh*((CAST(fldTakhfifKoli AS DECIMAL(5,2)))/100))  FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifKoli IS NOT NULL
--					  ORDER BY tblTakhfif.fldId DESC) ,Mablagh)
					  
--,MablaghTakhfif=ISNULL((SELECT TOP(1)   (Mablagh*((CAST(fldTakhfifKoli AS DECIMAL(5,2)))/100))  FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifKoli IS NOT NULL ORDER BY tblTakhfif.fldId desc) ,0)
--,MablaghMashmool=ISNULL((SELECT TOP(1)  Mablagh-(Mablagh*((CAST(fldTakhfifKoli AS DECIMAL(5,2)))/100))  FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifKoli IS NOT NULL AND fldMashmooleKarmozd=1 AND MablaghMashmool<>0
--					  ORDER BY tblTakhfif.fldId DESC) ,0)
----SELECT * FROM @table
--UPDATE @table
--SET  Mablagh=ISNULL((SELECT   Mablagh-(Mablagh*((CAST(fldDarsad AS DECIMAL(5,2)))/100)) 
-- FROM         Drd.tblReplyTakhfif INNER JOIN
--                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
--                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
--                      WHERE  Drd.tblStatusTaghsit_Takhfif.fldTypeMojavez=1 AND  Drd.tblRequestTaghsit_Takhfif.fldRequestType=2 AND fldElamAvarezId=@Id AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)
--) ,Mablagh)
--,MablaghTakhfif=CASE WHEN MablaghTakhfif<>0 then ISNULL((SELECT   MablaghTakhfif+ (Mablagh*((CAST(fldDarsad AS DECIMAL(5,2)))/100)) 
--  FROM         Drd.tblReplyTakhfif INNER JOIN
--                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
--                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
--                      WHERE  Drd.tblStatusTaghsit_Takhfif.fldTypeMojavez=1 AND  Drd.tblRequestTaghsit_Takhfif.fldRequestType=2 AND fldElamAvarezId=@Id AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)) ,MablaghTakhfif)
--					ELSE MablaghTakhfif end
--,MablaghMashmool=CASE WHEN MablaghMashmool<>0  THEN ISNULL((SELECT TOP(1)  MablaghMashmool-(MablaghMashmool*((CAST(fldTakhfifKoli AS DECIMAL(5,2)))/100))  FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifKoli IS NOT NULL AND fldMashmooleKarmozd=1 AND MablaghMashmool<>0
--					  ORDER BY tblTakhfif.fldId DESC) ,MablaghMashmool)
--					 ELSE MablaghMashmool end

----SELECT * FROM @table
----DECLARE @mablaghTakhfif BIGINT=0
----SELECT @mablaghTakhfif=fldMablagh
----FROM         Drd.tblReplyTakhfif INNER JOIN
----                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
----                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
----                      WHERE  Drd.tblStatusTaghsit_Takhfif.fldTypeMojavez=1 AND  Drd.tblRequestTaghsit_Takhfif.fldRequestType=2 AND fldElamAvarezId=@Id AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)


----UPDATE @table 
----SET Mablagh=(SELECT SUM(Mablagh)-@mablaghTakhfif FROM @table)
----,MablaghTakhfif=(SELECT SUM(MablaghTakhfif)+@mablaghTakhfif FROM @table)
------,MablaghMashmool=(SELECT ISNULL(SUM(MablaghMashmool),0) FROM @table WHERE fldMashmooleKarmozd=1 AND MablaghMashmool<>0)-@mablaghTakhfif
----UPDATE @table 
----SET MablaghMashmool=(SELECT ISNULL(SUM(MablaghMashmool),0) FROM @table WHERE  fldMashmooleKarmozd=1) -@mablaghTakhfif
----WHERE MablaghMashmool<>0 AND  fldMashmooleKarmozd=1

----SELECT * FROM @table

--IF EXISTS ( SELECT * from(SELECT TOP(1) * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@Id ORDER BY fldId desc)t 
--			INNER JOIN Drd.tblSodoorFish_Detail ON t.fldId=Drd.tblSodoorFish_Detail.fldFishId
--WHERE t.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)
--HAVING COUNT(tblSodoorFish_Detail.fldId)=(SELECT COUNT(*) FROM @table) )
--begin
----DECLARE @Naghdi1 DECIMAL(5,2),@Naghdi2 DECIMAL(5,2)

---- SELECT @Naghdi1=sum(fldTakhfifNaghdi) from(SELECT MAX(tblTakhfif.fldid) AS id ,(fldTakhfifNaghdi)   FROM    Drd.tblTakhfif INNER JOIN
----                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
----                      WHERE fldShCodeDaramad IN (SELECT ShomareHesabCodeDaramad FROM @table WHERE Tarikh BETWEEN fldAzTarikh AND fldTaTarikh)
----                      AND fldTakhfifKoli IS NOT NULL
----					 GROUP BY fldTakhfifNaghdi,tblTakhfif.fldid)t
----SELECT @Naghdi1

---- SELECT @Naghdi2=sum(fldTakhfifNaghdi) from(SELECT MAX(tblTakhfif.fldid) AS id ,(fldTakhfifNaghdi)   FROM    Drd.tblTakhfif INNER JOIN
----                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
----                      WHERE fldShCodeDaramad IN (SELECT ShomareHesabCodeDaramad FROM @table WHERE Tarikh BETWEEN fldAzTarikh AND fldTaTarikh AND fldMashmooleKarmozd=1)
----                      AND fldTakhfifKoli IS NOT NULL
----					 GROUP BY fldTakhfifNaghdi,tblTakhfif.fldid)t
--UPDATE @table
--SET  Mablagh=ISNULL((SELECT TOP(1)  Mablagh-(Mablagh*((CAST(fldTakhfifNaghdi AS DECIMAL(5,2)))/100)) 
-- FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifNaghdi IS NOT NULL
--					  ORDER BY tblTakhfif.fldId DESC) ,Mablagh)

--,MablaghTakhfif=CASE WHEN MablaghTakhfif<>0 then ISNULL((SELECT TOP(1)   MablaghTakhfif+(Mablagh*((CAST(fldTakhfifNaghdi AS DECIMAL(5,2)))/100))  FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifNaghdi IS NOT NULL ORDER BY tblTakhfif.fldId desc) ,0)
--					  ELSE MablaghTakhfif end
--,MablaghMashmool=CASE WHEN MablaghMashmool<>0 THEN  ISNULL((SELECT TOP(1)  Mablagh-(Mablagh*((CAST(fldTakhfifNaghdi AS DECIMAL(5,2)))/100))  FROM    Drd.tblTakhfif INNER JOIN
--                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
--                      WHERE fldShCodeDaramad = ShomareHesabCodeDaramad AND  tarikh  BETWEEN fldAzTarikh AND fldTaTarikh
--                      AND fldTakhfifNaghdi IS NOT NULL AND fldMashmooleKarmozd=1 AND MablaghMashmool<>0
--					  ORDER BY tblTakhfif.fldId DESC) ,0) ELSE MablaghMashmool end


--end
--UPDATE @table
--SET Mablagh=ISNULL(Mablagh-(Mablagh*(@Naghdi1)/100),Mablagh)
--,MablaghTakhfif=ISNULL(MablaghTakhfif+(MablaghTakhfif*(@Naghdi1)/100),MablaghTakhfif)
--,MablaghMashmool=ISNULL(MablaghMashmool-(MablaghMashmool*(@Naghdi2)/100),MablaghMashmool)
--SELECT * FROM @table

--SELECT @mablaghtakhfif
--SET @Mablagh=@mablaghtakhfif


DECLARE @r TABLE(mablagh bigint)
IF(@FieldName='MablaghKol')
BEGIN
INSERT INTO @r
SELECT fldSumAsli+ISNULL((fldTakhfifAvarezValue),(fldAvarezValue) )+isnull((fldTakhfifMaliyatValue) ,(fldMaliyatValue))+isnull((fldTakhfifAmuzeshParvareshValue) ,(fldAmuzeshParvareshValue)) FROM Drd.tblCodhayeDaramadiElamAvarez 
WHERE fldElamAvarezId=@Id
SELECT @Mablagh=SUM(mablagh) FROM @r
END

IF(@FieldName='MablaghTakhfif')
BEGIN

INSERT INTO @r
SELECT  case WHEN fldTakhfifAsliValue IS NOT NULL THEN((fldAsliValue*fldTedad))
-ISNULL((ISNULL(fldTakhfifAsliValue,cast(0  as bigint))*fldTedad),cast(0  as bigint)) ELSE cast(0  as bigint) END  
+ CASE WHEN fldTakhfifAvarezValue<>0 then((fldAvarezValue)-ISNULL((fldTakhfifAvarezValue),cast(0  as bigint))) ELSE cast(0  as bigint) END 
+ CASE WHEN fldTakhfifMaliyatValue<>0  then
((fldMaliyatValue)-ISNULL((fldTakhfifMaliyatValue),cast(0  as bigint)) )  ELSE cast(0  as bigint) end
+ CASE WHEN fldTakhfifAmuzeshParvareshValue<>0  then
((fldAmuzeshParvareshValue)-ISNULL((fldTakhfifAmuzeshParvareshValue),cast(0  as bigint)) )  ELSE cast(0  as bigint) end
 FROM Drd.tblCodhayeDaramadiElamAvarez 
WHERE fldElamAvarezId=@Id --AND fldShomareHesabCodeDaramadId=13

SELECT @Mablagh=SUM(mablagh) FROM @r
END
IF(@FieldName='MablaghMashmool')
BEGIN
INSERT INTO @r
SELECT ISNULL( (fldTakhfifAsliValue*fldTedad),(fldAsliValue*fldTedad))+ISNULL((fldTakhfifAvarezValue),(fldAvarezValue) )+isnull((fldTakhfifMaliyatValue) ,(fldMaliyatValue)) +isnull((fldTakhfifAmuzeshParvareshValue) ,(fldAmuzeshParvareshValue)) 
FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId
WHERE        (Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = @Id) AND tblCodhayeDaramd_1.fldMashmooleKarmozd<>0
SELECT @Mablagh=SUM(mablagh) FROM @r
END

IF(@FieldName='MablaghTakhfif_ElamAvarez')
BEGIN
IF EXISTS (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@Id) AND fldType not in (1,3)
)
begin
	INSERT INTO @r
	SELECT     fldMablagh   
	FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							 Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTakhfif ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTakhfif.fldStatusId
	WHERE fldElamAvarezId=@Id --AND fldShomareHesabCodeDaramadId=13 
	and Drd.tblRequestTaghsit_Takhfif.fldId not in (select fldRequestTaghsit_TakhfifId from drd.tblebtal where fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)
		SELECT @Mablagh=(mablagh) FROM @r

end
else
begin
	INSERT INTO @r
	SELECT  CASE WHEN fldTakhfifAsliValue IS NOT NULL THEN((fldAsliValue*fldTedad))-ISNULL((ISNULL(cast(fldTakhfifAsliValue as bigint),cast(0  as bigint))*fldTedad),cast(0  as bigint)) ELSE cast(0  as bigint) END  + CASE WHEN fldTakhfifAvarezValue<>0 then((fldAvarezValue)-ISNULL((fldTakhfifAvarezValue),cast(0  as bigint))) ELSE cast(0  as bigint) END + CASE WHEN fldTakhfifMaliyatValue<>0  then
	((fldMaliyatValue)-ISNULL((fldTakhfifMaliyatValue),cast(0  as bigint)) ) ELSE cast(0  as bigint) END
	 + CASE WHEN fldTakhfifAmuzeshParvareshValue<>0  then
	((fldAmuzeshParvareshValue)-ISNULL((fldTakhfifAmuzeshParvareshValue),cast(0  as bigint)) ) ELSE cast(0  as bigint) END FROM Drd.tblCodhayeDaramadiElamAvarez 
	WHERE fldElamAvarezId=@Id
	SELECT @Mablagh=sum(mablagh) FROM @r
end

END

RETURN @Mablagh
----SELECT @Mablagh


end

GO
