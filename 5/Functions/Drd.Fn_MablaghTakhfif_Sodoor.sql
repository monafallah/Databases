SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[Fn_MablaghTakhfif_Sodoor](@FieldName NVARCHAR(50), @IdElamAvarez INT,@ShomareHedabId INT,@organId INT,@shorooShenaseGhabz TINYINT )
RETURNS BIGINT
AS
BEGIN

                    
DECLARE @Tarikh NVARCHAR(10),@Mablagh BIGINT--,@FieldName NVARCHAR(50)='Mablaghkol', @IdElamAvarez INT=609,@ShomareHedabId INT=719,@organId INT=1,@shorooShenaseGhabz TINYINT=12


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


DECLARE @r TABLE(mablagh bigINT)
DECLARE @s TABLE(mablagh bigint)
DECLARE @mablaghtakhfif bigINT=0,@mablaghkoli bigINT=0 
IF(@FieldName='MablaghKol')
BEGIN
IF EXISTS (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez) AND fldType not in (1,3)
)
	BEGIN
		SELECT    @mablaghtakhfif= cast(fldMablagh as bigint)
		FROM         Drd.tblReplyTakhfif INNER JOIN
						  Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
						  Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
						 WHERE fldElamAvarezId=@IdElamAvarez

		SELECT @mablaghkoli=cast(SUM(fldSumAsli+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue) as bigint)FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez
		--select @mablaghtakhfif,@mablaghkoli
		
		INSERT INTO @s
		SELECT @mablaghkoli-(t.Expr1*@mablaghtakhfif)/@mablaghkoli FROM (
		SELECT      cast( sum( ( Drd.tblCodhayeDaramadiElamAvarez.fldSumAsli +
								 Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue+ Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue ))as bigint)AS Expr1
		FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
								 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
								 Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE fldElamAvarezId=@IdElamAvarez AND tblCodhayeDaramadiElamAvarez.fldShomareHesabId=@ShomareHedabId AND fldShorooshenaseGhabz=@shorooShenaseGhabz AND tblElamAvarez.fldOrganId=@organId
		)t
		--select * from @s

		SELECT @Mablagh=cast((mablagh)as bigint) FROM @s
	END
ELSE 
	BEGIN
		INSERT INTO @r
		SELECT        ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldSumAsli,cast(0  as bigint)) + ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue) + ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue, Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)
								 + ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue, Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue) AS Expr1
		FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
								 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
								 Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE fldElamAvarezId=@IdElamAvarez AND tblCodhayeDaramadiElamAvarez.fldShomareHesabId=@ShomareHedabId AND fldShorooshenaseGhabz=@shorooShenaseGhabz AND tblElamAvarez.fldOrganId=@organId

		SELECT @Mablagh=SUM(mablagh) FROM @r
	END
END

IF(@FieldName='MablaghTakhfif')
BEGIN
IF EXISTS (SELECT fldCodeDaramadElamAvarezId FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId IN (SELECT fldid FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez) AND fldType not in (1,3)
)
	BEGIN
		SELECT    @mablaghtakhfif= fldMablagh
		FROM         Drd.tblReplyTakhfif INNER JOIN
						  Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
						  Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
						 WHERE fldElamAvarezId=@IdElamAvarez

		SELECT @mablaghkoli=SUM(fldAsliValue*fldTedad+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez
			INSERT INTO @s
		SELECT (t.Expr1*@mablaghtakhfif)/@mablaghkoli FROM (
		SELECT       sum( ( Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad +
								 Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue+ Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue
								 + Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue ))AS Expr1
		FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
								 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
								 Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE fldElamAvarezId=@IdElamAvarez AND tblCodhayeDaramadiElamAvarez.fldShomareHesabId=@ShomareHedabId AND fldShorooshenaseGhabz=@shorooShenaseGhabz AND tblElamAvarez.fldOrganId=@organId
		)t
		SELECT @Mablagh=(mablagh) FROM @s
	END
ELSE
	BEGIN
	INSERT INTO @r
	SELECT        CASE WHEN fldTakhfifAsliValue IS NOT NULL THEN ((fldAsliValue * fldTedad)) - ISNULL((ISNULL(fldTakhfifAsliValue, 0) * fldTedad), 0) 
							 ELSE cast(0  as bigint) END + CASE WHEN fldTakhfifAvarezValue <> 0 THEN ((fldAvarezValue) - ISNULL((fldTakhfifAvarezValue), cast(0  as bigint))) ELSE 0 END + CASE WHEN fldTakhfifMaliyatValue <> 0 THEN ((fldMaliyatValue) 
							 - ISNULL((fldTakhfifMaliyatValue), cast(0  as bigint))) ELSE 0 END 
							 + CASE WHEN fldTakhfifAmuzeshParvareshValue <> 0 THEN ((fldAmuzeshParvareshValue) 
							 - ISNULL((fldTakhfifAmuzeshParvareshValue), cast(0  as bigint))) ELSE 0 END AS Expr1
	FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId
	WHERE fldElamAvarezId=@IdElamAvarez AND tblCodhayeDaramadiElamAvarez.fldShomareHesabId=@ShomareHedabId AND fldShorooshenaseGhabz=@shorooShenaseGhabz AND tblElamAvarez.fldOrganId=@organId
		SELECT @Mablagh=SUM(mablagh) FROM @r
	end
	
END



RETURN @Mablagh
--SELECT @Mablagh


end

GO
