SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_KarKard](@NoeEstekhdam INT,@PersonalId INT,@sal SMALLINT,@mah TINYINT,@nobat TINYINT)
RETURNS INT
--DECLARE @NoeEstekhdam INT,@PersonalId INT,@sal SMALLINT,@mah TINYINT
AS
BEGIN
declare @karkard INT,@r INT

SELECT     @karkard=ISNULL(Pay.tblKarkardMahane_Detail.fldKarkard,CAST(Pay.tblKarKardeMahane.fldKarkard AS INT))
FROM         Pay.tblKarKardeMahane LEFT outer JOIN
                      Pay.tblKarkardMahane_Detail ON Pay.tblKarKardeMahane.fldId = Pay.tblKarkardMahane_Detail.fldKarkardMahaneId
                      WHERE Pay.tblKarKardeMahane.fldPersonalId=@PersonalId AND fldYear=@sal AND fldMah=@mah AND fldNobatePardakht=@nobat
IF(@NoeEstekhdam=1)
SET @r= @karkard

ELSE
BEGIN
	IF(@karkard>=30)
	BEGIN
		IF(@mah<=6)
		SET @karkard=31
		ELSE IF(@mah>6)
		BEGIN
			IF(@mah<=11)
			SET @karkard=30
			ELSE IF(@mah=12)
			BEGIN
				IF(Com.fn_SaleKabise(@sal)=1)
				SET @karkard=30
				ELSE
				SET @karkard=29
			END
		END
		SET @r= @karkard
	END
	ELSE
		SET @r= @karkard
END
RETURN @r
END
GO
