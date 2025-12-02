SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_CheckKosorat_Motalebat](@FieldName NVARCHAR(50),@Id INT)
AS
IF(@FieldName='Kosorat')
BEGIN
	IF EXISTS( SELECT * FROM Pay.[tblMohasebat_kosorat/MotalebatParam] WHERE fldKosoratId=@id)
	SELECT '1' AS fldType 
	ELSE
    SELECT '0'AS fldType 

END
IF(@FieldName='Motalebat')
BEGIN
IF EXISTS(SELECT * FROM Pay.[tblMohasebat_kosorat/MotalebatParam] WHERE fldMotalebatId=@id)
	SELECT '1' AS fldType 
	ELSE
    SELECT '0'AS fldType 
END
IF(@FieldName='MotalebatGhatei')
BEGIN
IF EXISTS(SELECT * FROM pay.tblMohasebat as m
inner join Pay.[tblMohasebat_kosorat/MotalebatParam] as km on km.fldMohasebatId=m.fldId WHERE m.fldFlag=1 and km.fldMotalebatId=@id)
	SELECT '1' AS fldType 
	ELSE
    SELECT '0'AS fldType 
END

IF(@FieldName='KosoratGhatei')
BEGIN
IF EXISTS(SELECT * FROM pay.tblMohasebat as m
inner join Pay.[tblMohasebat_kosorat/MotalebatParam] as km on km.fldMohasebatId=m.fldId WHERE m.fldFlag=1 and km.fldKosoratId=@id)
	SELECT '1' AS fldType 
	ELSE
    SELECT '0'AS fldType 
END

IF(@FieldName='Kosorat_Bank')
BEGIN
IF EXISTS( SELECT * FROM Pay.tblMohasebat_KosoratBank WHERE fldKosoratBankId=@id)
	SELECT '1' AS fldType 
	ELSE
    SELECT '0'AS fldType 
end


IF(@FieldName='Kosorat_BankGhatei')
BEGIN
IF EXISTS( SELECT * FROM  pay.tblMohasebat as m
inner join Pay.tblMohasebat_KosoratBank as km on km.fldMohasebatId=m.fldId WHERE m.fldFlag=1 and km.fldKosoratBankId=@id)
	SELECT '1' AS fldType 
	ELSE
    SELECT '0'AS fldType 
end
GO
