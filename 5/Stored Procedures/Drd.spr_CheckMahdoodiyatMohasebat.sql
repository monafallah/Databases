SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CheckMahdoodiyatMohasebat](@tarikh NVARCHAR(10),@userid INT,@AshkhasId INT,@fldShomarehesabDaramd INT)
as
DECLARE @t BIT=1--,@tarikh NVARCHAR(10),@userid INT,@AshkhasId INT,@fldShomarehesabDaramd INT
IF NOT EXISTS(SELECT * FROM Drd.tblMahdoodiyatMohasebat WHERE fldStatus=1 AND @tarikh  BETWEEN fldAzTarikh AND fldTatarikh)
set  @t=0
ELSE
BEGIN
	IF NOT EXISTS(SELECT * FROM Drd.tblMahdoodiyatMohasebat WHERE fldNoeKarbar=0 AND fldid IN (SELECT fldMahdoodiyatMohasebatId FROM Drd.tblMohdoodiyatMohasebat_User WHERE fldMahdoodiyatMohasebatId=tblMahdoodiyatMohasebat.fldid AND fldIdUser=@userid))
	set @t=0
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT * FROM Drd.tblMahdoodiyatMohasebat WHERE fldNoeAshkhas=0 AND fldid IN (SELECT fldMahdoodiyatMohasebatId FROM Drd.tblMahdoodiyatMohasebat_Ashkhas WHERE fldAshkhasId=@AshkhasId AND fldMahdoodiyatMohasebatId=tblMahdoodiyatMohasebat.fldid ))
		set @t=0
		ELSE
		BEGIN
			IF NOT EXISTS(SELECT * FROM Drd.tblMahdoodiyatMohasebat WHERE fldNoeCodeDaramad=0 AND fldid IN (SELECT tblMahdoodiyatMohasebat.fldid FROM Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad WHERE fldShomarehesabDarmadId=@fldShomarehesabDaramd AND fldMahdodiyatMohasebatId=tblMahdoodiyatMohasebat.fldid))
			set @t=0
			ELSE
			set @t=1
		END
	END
END
SELECT @t AS fldCheck
GO
