SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabetSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	
	if (@fieldname=N'fldId')
SELECT TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                  Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                  Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                  Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                  CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                  CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, Drd.tblComboBox.fldTitle, 
                  Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM     Drd.tblParametreSabet INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                  Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                  Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
				   
	WHERE   Drd.tblParametreSabet.fldId = @Value   
	
	if (@fieldname=N'fldShomareHesabCodeDaramadId')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE  fldShomareHesabCodeDaramadId like @Value  


	if (@fieldname=N'VaziyatName')
	SELECT TOP (@h)* from(SELECT   Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					   
					   ) as t
	WHERE   VaziyatName like @Value and t.fldShomareHesabCodeDaramadId like @Value1  


	if (@fieldname=N'NoeFieldName')
	SELECT TOP (@h)* from(SELECT    Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
					   ) as t
	WHERE   NoeFieldName like @Value and t.fldShomareHesabCodeDaramadId like @Value1  


	if (@fieldname=N'NoeName')
	SELECT TOP (@h)* from(SELECT     Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					   
					    ) as t
	WHERE   NoeName  like @Value and t.fldShomareHesabCodeDaramadId like @Value1 

			if (@fieldname=N'fldDaramadTitle')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE  tblCodhayeDaramd.fldDaramadTitle like @Value and Drd.tblParametreSabet.fldShomareHesabCodeDaramadId like @Value1
	 


		if (@fieldname=N'fldComboBaxId')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE   Drd.tblParametreSabet.fldComboBaxId = @Value  


		if (@fieldname=N'fldNameParametreFa')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE  Drd.tblParametreSabet.fldNameParametreFa like @Value and Drd.tblParametreSabet.fldShomareHesabCodeDaramadId like @Value1
	 

			if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE  Drd.tblParametreSabet.fldDesc like @Value and Drd.tblParametreSabet.fldShomareHesabCodeDaramadId like @Value1


				if (@fieldname=N'fldNameParametreEn')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE  Drd.tblParametreSabet.fldNameParametreEn like @Value and Drd.tblParametreSabet.fldShomareHesabCodeDaramadId like @Value1
	 




		if (@fieldname=N'fldNoe')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE  Drd.tblParametreSabet.fldNoe like @Value and Drd.tblParametreSabet.fldShomareHesabCodeDaramadId like @Value1
	 


	if (@fieldname=N'fldFormulId')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
	WHERE   Drd.tblParametreSabet.fldFormulId = @Value  


	if (@fieldname=N'')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    
                       
                      
                      

	if (@fieldname=N'CheckNameParametreEn')
SELECT     TOP (@h) Drd.tblParametreSabet.fldId, Drd.tblParametreSabet.fldShomareHesabCodeDaramadId, Drd.tblParametreSabet.fldNameParametreFa, 
                      Drd.tblParametreSabet.fldNameParametreEn, Drd.tblParametreSabet.fldNoe, Drd.tblParametreSabet.fldNoeField, Drd.tblParametreSabet.fldVaziyat, 
                      Drd.tblParametreSabet.fldFormulId, Drd.tblParametreSabet.fldComboBaxId, Drd.tblParametreSabet.fldUserId, Drd.tblParametreSabet.fldDesc, 
                      Drd.tblParametreSabet.fldDate, CASE WHEN fldNoe = 0 THEN N'محاسبات' WHEN fldNoe = 1 THEN N'نامه نگاری' END AS NoeName, 
                      CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField
                       = 5 THEN 'combobox' END AS NoeFieldName, tblCodhayeDaramd.fldDaramadTitle, 
                      CASE WHEN Drd.tblParametreSabet.fldVaziyat = 0 THEN N'غیرفعال' WHEN Drd.tblParametreSabet.fldVaziyat = 1 THEN N'فعال' END AS VaziyatName, 
                      Drd.tblComboBox.fldTitle,Drd.tblParametreSabet.fldTypeParametr,CASE WHEN Drd.tblParametreSabet.fldTypeParametr=1 THEN N'متغیر' WHEN Drd.tblParametreSabet.fldTypeParametr=0 THEN N'ثابت' END AS fldNoeParametr
FROM         Drd.tblParametreSabet INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON Drd.tblParametreSabet.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd AS tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd.fldId LEFT OUTER JOIN
                      Drd.tblComboBox ON Drd.tblParametreSabet.fldComboBaxId = Drd.tblComboBox.fldId
					    	
                      WHERE  fldNameParametreEn LIKE @Value  
                      
COMMIT
GO
