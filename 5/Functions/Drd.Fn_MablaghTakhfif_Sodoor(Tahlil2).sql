SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- User Defined Function

CREATE FUNCTION [Drd].[Fn_MablaghTakhfif_Sodoor(Tahlil2)](@FieldName NVARCHAR(50), @IdElamAvarez INT,@ShomareHedabId INT,@organId INT,@shorooShenaseGhabz TINYINT )
RETURNS BIGINT
AS
BEGIN           
DECLARE @Tarikh NVARCHAR(10),@Mablagh BIGINT--,@FieldName NVARCHAR(50)='Mablaghkol', @IdElamAvarez INT=609,@ShomareHedabId INT=719,@organId INT=1,@shorooShenaseGhabz TINYINT=12

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

		SELECT @mablaghkoli=cast(SUM(cast(fldAsliValue as bigint)*fldTedad+fldMaliyatValue+fldAvarezValue) as bigint)FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez
		--select @mablaghtakhfif,@mablaghkoli
		
		INSERT INTO @s
		SELECT @mablaghkoli-(t.Expr1*@mablaghtakhfif)/@mablaghkoli FROM (
		SELECT      cast( sum( ( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue  * Drd.tblCodhayeDaramadiElamAvarez.fldTedad as bigint) +
								 Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue+ Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue ))as bigint)AS Expr1
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
		SELECT        ISNULL(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue as bigint)* Drd.tblCodhayeDaramadiElamAvarez.fldTedad, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad) + ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue) + ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue, Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue) AS Expr1
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

		SELECT @mablaghkoli=SUM(fldAsliValue*fldTedad+fldMaliyatValue+fldAvarezValue) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@IdElamAvarez
			INSERT INTO @s
		SELECT (t.Expr1*@mablaghtakhfif)/@mablaghkoli FROM (
		SELECT       sum( ( Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad +
								 Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue+ Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue ))AS Expr1
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
	SELECT    SUM(CAST(fldAsliValue AS BIGINT))-SUM(cast ( fldTakhfifAsliValue AS BIGINT)) AS Expr1
	FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId
	WHERE fldElamAvarezId=@IdElamAvarez AND tblCodhayeDaramadiElamAvarez.fldShomareHesabId=@ShomareHedabId AND fldShorooshenaseGhabz=@shorooShenaseGhabz AND tblElamAvarez.fldOrganId=@organId
		SELECT @Mablagh=(mablagh) FROM @r
	end
	
END



RETURN @Mablagh
--SELECT @Mablagh


end

GO
