SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_SumKomakGheyerNaghdi](@PersonalId INT,@Type BIT,@Mah TINYINT,@Year SMALLINT)
AS
--DECLARE @PersonalId INT,@Type BIT,@Mah TINYINT,@Year SMALLINT
SELECT ISNULL(SUM(fldMablagh),0) AS Jam,ISNULL(SUM(fldMaliyat),0) AS JamMaliyat FROM Pay.tblKomakGheyerNaghdi
WHERE fldPersonalId=@PersonalId AND fldYear = @Year AND fldMonth<>@Mah AND fldNoeMostamer=@Type
GO
