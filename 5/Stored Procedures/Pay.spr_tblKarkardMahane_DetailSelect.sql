SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarkardMahane_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblKarkardMahane_Detail.fldId, Pay.tblKarkardMahane_Detail.fldKarkardMahaneId, Pay.tblKarkardMahane_Detail.fldKarkard, 
                      Pay.tblKarkardMahane_Detail.fldKargahBimeId, Pay.tblKarkardMahane_Detail.fldUserId, Pay.tblKarkardMahane_Detail.fldDesc, 
                      Pay.tblKarkardMahane_Detail.fldDate, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblInsuranceWorkshop.fldWorkShopNum, 
                      Pay.tblInsuranceWorkshop.fldEmployerName
FROM         Pay.tblKarkardMahane_Detail INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.tblKarkardMahane_Detail.fldKarkardMahaneId = Pay.tblKarKardeMahane.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.tblKarkardMahane_Detail.fldKargahBimeId = Pay.tblInsuranceWorkshop.fldId
	WHERE  Pay.tblKarkardMahane_Detail.fldId = @Value
	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblKarkardMahane_Detail.fldId, Pay.tblKarkardMahane_Detail.fldKarkardMahaneId, Pay.tblKarkardMahane_Detail.fldKarkard, 
                      Pay.tblKarkardMahane_Detail.fldKargahBimeId, Pay.tblKarkardMahane_Detail.fldUserId, Pay.tblKarkardMahane_Detail.fldDesc, 
                      Pay.tblKarkardMahane_Detail.fldDate, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblInsuranceWorkshop.fldWorkShopNum, 
                      Pay.tblInsuranceWorkshop.fldEmployerName
FROM         Pay.tblKarkardMahane_Detail INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.tblKarkardMahane_Detail.fldKarkardMahaneId = Pay.tblKarKardeMahane.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.tblKarkardMahane_Detail.fldKargahBimeId = Pay.tblInsuranceWorkshop.fldId
	WHERE  Pay.tblKarkardMahane_Detail.fldDesc LIKE @Value
	

	if (@fieldname=N'fldKarkardMahaneId')
SELECT     TOP (@h) Pay.tblKarkardMahane_Detail.fldId, Pay.tblKarkardMahane_Detail.fldKarkardMahaneId, Pay.tblKarkardMahane_Detail.fldKarkard, 
                      Pay.tblKarkardMahane_Detail.fldKargahBimeId, Pay.tblKarkardMahane_Detail.fldUserId, Pay.tblKarkardMahane_Detail.fldDesc, 
                      Pay.tblKarkardMahane_Detail.fldDate, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblInsuranceWorkshop.fldWorkShopNum, 
                      Pay.tblInsuranceWorkshop.fldEmployerName
FROM         Pay.tblKarkardMahane_Detail INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.tblKarkardMahane_Detail.fldKarkardMahaneId = Pay.tblKarKardeMahane.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.tblKarkardMahane_Detail.fldKargahBimeId = Pay.tblInsuranceWorkshop.fldId
	WHERE  Pay.tblKarkardMahane_Detail.fldKarkardMahaneId = @Value
	
	if (@fieldname=N'fldKargahBimeId')
SELECT     TOP (@h) Pay.tblKarkardMahane_Detail.fldId, Pay.tblKarkardMahane_Detail.fldKarkardMahaneId, Pay.tblKarkardMahane_Detail.fldKarkard, 
                      Pay.tblKarkardMahane_Detail.fldKargahBimeId, Pay.tblKarkardMahane_Detail.fldUserId, Pay.tblKarkardMahane_Detail.fldDesc, 
                      Pay.tblKarkardMahane_Detail.fldDate, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblInsuranceWorkshop.fldWorkShopNum, 
                      Pay.tblInsuranceWorkshop.fldEmployerName
FROM         Pay.tblKarkardMahane_Detail INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.tblKarkardMahane_Detail.fldKarkardMahaneId = Pay.tblKarKardeMahane.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.tblKarkardMahane_Detail.fldKargahBimeId = Pay.tblInsuranceWorkshop.fldId
	WHERE  Pay.tblKarkardMahane_Detail.fldKargahBimeId = @Value


	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblKarkardMahane_Detail.fldId, Pay.tblKarkardMahane_Detail.fldKarkardMahaneId, Pay.tblKarkardMahane_Detail.fldKarkard, 
                      Pay.tblKarkardMahane_Detail.fldKargahBimeId, Pay.tblKarkardMahane_Detail.fldUserId, Pay.tblKarkardMahane_Detail.fldDesc, 
                      Pay.tblKarkardMahane_Detail.fldDate, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblInsuranceWorkshop.fldWorkShopNum, 
                      Pay.tblInsuranceWorkshop.fldEmployerName
FROM         Pay.tblKarkardMahane_Detail INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.tblKarkardMahane_Detail.fldKarkardMahaneId = Pay.tblKarKardeMahane.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.tblKarkardMahane_Detail.fldKargahBimeId = Pay.tblInsuranceWorkshop.fldId 

	COMMIT
GO
