SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_CheckMohasebat](@FieldName NVARCHAR(50),@PersonalId INT,@Mah TINYINT,@Sal SMALLINT,@NobatPardakht TINYINT,@OrganId int )
AS 
IF(@FieldName='Hoghogh_Personal')
SELECT TOP(1) fldId FROM Pay.tblMohasebat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht

IF(@FieldName='EzafeKar_Personal')
SELECT TOP(1) fldId FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1

IF(@FieldName='TatilKar_Personal')
SELECT TOP(1) fldId FROM Pay.tblMohasebatEzafeKari_TatilKari WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2

IF(@FieldName='Morakhasi_Personal')
SELECT TOP(1) fldId FROM Pay.tblMohasebat_Morakhasi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht

IF(@FieldName='Mamooriyat_Personal')
SELECT TOP(1) fldId FROM Pay.tblMohasebat_Mamuriyat WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah 

IF(@FieldName='Eydi_Personal')
SELECT TOP(1) fldId FROM Pay.tblMohasebat_Eydi WHERE fldPersonalId=@PersonalId AND fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht

IF(@FieldName='Hoghogh')
SELECT TOP(1) m.fldId FROM Pay.tblMohasebat as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatId=m.fldId
WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId

IF(@FieldName='EzafeKar')
SELECT TOP(1) m.fldId FROM Pay.tblMohasebatEzafeKari_TatilKari  as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldEzafe_TatilKariId=m.fldId
WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=1 and fldOrganId=@OrganId

IF(@FieldName='TatilKar')
SELECT TOP(1) m.fldId FROM Pay.tblMohasebatEzafeKari_TatilKari  as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldEzafe_TatilKariId=m.fldId
WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht AND fldType=2 and fldOrganId=@OrganId

IF(@FieldName='Morakhasi')
SELECT TOP(1) m.fldId FROM Pay.tblMohasebat_Morakhasi  as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMorakhasiId=m.fldId
WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId

IF(@FieldName='Mamooriyat')
SELECT TOP(1) m.fldId FROM Pay.tblMohasebat_Mamuriyat  as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMamuriyatId=m.fldId and fldOrganId=@OrganId
WHERE  fldYear=@Sal AND fldMonth=@Mah 

IF(@FieldName='Eydi')
SELECT TOP(1) m.fldId FROM Pay.tblMohasebat_Eydi  as m
inner join pay.tblMohasebat_PersonalInfo as p on p.fldMohasebatEydiId=m.fldId
WHERE  fldYear=@Sal AND fldMonth=@Mah AND fldNobatPardakht=@NobatPardakht and fldOrganId=@OrganId
GO
