SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_UpdateEzafekarKarkardMahane](@Ezafekar DECIMAL(6,3),@Ghati BIT,@PersonalId INT,@Mah TINYINT,@sal SMALLINT)
as
UPDATE Pay.tblKarKardeMahane
SET fldEzafeKari=@Ezafekar,fldGhati=@Ghati
WHERE fldPersonalId=@PersonalId AND fldYear=@sal AND fldMah=@Mah
GO
