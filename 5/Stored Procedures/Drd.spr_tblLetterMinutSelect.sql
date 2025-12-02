SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterMinutSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647

	if (@fieldname=N'fldId')
	SELECT TOP (@h) l.fldId, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, l.fldUserId, l.fldDate,l. fldDesc, fldSodoorBadAzVarizNaghdi, fldSodoorBadAzTaghsit, 
                  fldTanzimkonande ,CASE WHEN fldSodoorBadAzVarizNaghdi=1 THEN N'امکان' WHEN fldSodoorBadAzVarizNaghdi=0 THEN N'عدم امکان' END AS VarizNaghdiName,
				  CASE WHEN fldSodoorBadAzTaghsit=1 THEN N'امکان' WHEN fldSodoorBadAzTaghsit=0 THEN N'عدم امکان' END AS TaghsitName,
				  CASE WHEN fldTanzimkonande=1 THEN N'امکان' WHEN fldTanzimkonande=0 THEN N'عدم امکان' END AS TanzimkonandeName
FROM     Drd.tblLetterMinut l INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON l.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
				      
	WHERE  l.fldId like @Value  

	if (@fieldname=N'fldShomareHesabCodeDaramadId')
	SELECT TOP (@h) l.fldId, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, l.fldUserId, l.fldDate,l. fldDesc, fldSodoorBadAzVarizNaghdi, fldSodoorBadAzTaghsit, 
                  fldTanzimkonande ,CASE WHEN fldSodoorBadAzVarizNaghdi=1 THEN N'امکان' WHEN fldSodoorBadAzVarizNaghdi=0 THEN N'عدم امکان' END AS VarizNaghdiName,
				  CASE WHEN fldSodoorBadAzTaghsit=1 THEN N'امکان' WHEN fldSodoorBadAzTaghsit=0 THEN N'عدم امکان' END AS TaghsitName,
				  CASE WHEN fldTanzimkonande=1 THEN N'امکان' WHEN fldTanzimkonande=0 THEN N'عدم امکان' END AS TanzimkonandeName
FROM     Drd.tblLetterMinut l INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON l.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
				     
	WHERE  fldShomareHesabCodeDaramadId = @Value  

	if (@fieldname=N'fldTitle')
	SELECT TOP (@h) l.fldId, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, l.fldUserId, l.fldDate,l. fldDesc, fldSodoorBadAzVarizNaghdi, fldSodoorBadAzTaghsit, 
                  fldTanzimkonande ,CASE WHEN fldSodoorBadAzVarizNaghdi=1 THEN N'امکان' WHEN fldSodoorBadAzVarizNaghdi=0 THEN N'عدم امکان' END AS VarizNaghdiName,
				  CASE WHEN fldSodoorBadAzTaghsit=1 THEN N'امکان' WHEN fldSodoorBadAzTaghsit=0 THEN N'عدم امکان' END AS TaghsitName,
				  CASE WHEN fldTanzimkonande=1 THEN N'امکان' WHEN fldTanzimkonande=0 THEN N'عدم امکان' END AS TanzimkonandeName
FROM     Drd.tblLetterMinut l INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON l.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
				      
	WHERE  fldTitle like @Value  
	
	if (@fieldname=N'fldDescMinut')
	SELECT TOP (@h) l.fldId, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, l.fldUserId, l.fldDate,l. fldDesc, fldSodoorBadAzVarizNaghdi, fldSodoorBadAzTaghsit, 
                  fldTanzimkonande ,CASE WHEN fldSodoorBadAzVarizNaghdi=1 THEN N'امکان' WHEN fldSodoorBadAzVarizNaghdi=0 THEN N'عدم امکان' END AS VarizNaghdiName,
				  CASE WHEN fldSodoorBadAzTaghsit=1 THEN N'امکان' WHEN fldSodoorBadAzTaghsit=0 THEN N'عدم امکان' END AS TaghsitName,
				  CASE WHEN fldTanzimkonande=1 THEN N'امکان' WHEN fldTanzimkonande=0 THEN N'عدم امکان' END AS TanzimkonandeName
FROM     Drd.tblLetterMinut l INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON l.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
				      
	WHERE  fldDescMinut like @Value  

	if (@fieldname=N'fldDesc')
	SELECT TOP (@h) l.fldId, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, l.fldUserId, l.fldDate,l. fldDesc, fldSodoorBadAzVarizNaghdi, fldSodoorBadAzTaghsit, 
                  fldTanzimkonande ,CASE WHEN fldSodoorBadAzVarizNaghdi=1 THEN N'امکان' WHEN fldSodoorBadAzVarizNaghdi=0 THEN N'عدم امکان' END AS VarizNaghdiName,
				  CASE WHEN fldSodoorBadAzTaghsit=1 THEN N'امکان' WHEN fldSodoorBadAzTaghsit=0 THEN N'عدم امکان' END AS TaghsitName,
				  CASE WHEN fldTanzimkonande=1 THEN N'امکان' WHEN fldTanzimkonande=0 THEN N'عدم امکان' END AS TanzimkonandeName
FROM     Drd.tblLetterMinut l INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON l.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
				      
	WHERE  l.fldDesc like @Value  

	if (@fieldname=N'')
	SELECT TOP (@h) l.fldId, fldShomareHesabCodeDaramadId, fldTitle, fldDescMinut, l.fldUserId, l.fldDate,l. fldDesc, fldSodoorBadAzVarizNaghdi, fldSodoorBadAzTaghsit, 
                  fldTanzimkonande ,CASE WHEN fldSodoorBadAzVarizNaghdi=1 THEN N'امکان' WHEN fldSodoorBadAzVarizNaghdi=0 THEN N'عدم امکان' END AS VarizNaghdiName,
				  CASE WHEN fldSodoorBadAzTaghsit=1 THEN N'امکان' WHEN fldSodoorBadAzTaghsit=0 THEN N'عدم امکان' END AS TaghsitName,
				  CASE WHEN fldTanzimkonande=1 THEN N'امکان' WHEN fldTanzimkonande=0 THEN N'عدم امکان' END AS TanzimkonandeName
FROM     Drd.tblLetterMinut l INNER JOIN
                  Drd.tblShomareHesabCodeDaramad ON l.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
				      
					

	COMMIT
GO
