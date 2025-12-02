SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebat_ShomareHesabDaramadSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	 
	@h int
AS 
	BEGIN TRAN
	SET @value=com.fn_TextNormalize(@value) 
	if (@h=0) set @h=2147483647
	
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldMahdodiyatMohasebatId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldUserId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDesc, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDate, tblCodhayeDaramd_1.fldDaramadCode
FROM            Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId 
						   
	WHERE  tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldId = @Value  
	
	if (@fieldname=N'fldShomarehesabDarmadId')
	SELECT        TOP (@h) Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldMahdodiyatMohasebatId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldUserId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDesc, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDate, tblCodhayeDaramd_1.fldDaramadCode
FROM            Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId 
						  
	WHERE  fldShomarehesabDarmadId = @Value  
	
	if (@fieldname=N'fldMahdoodiyatMohasebatId')
	SELECT        TOP (@h) Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldMahdodiyatMohasebatId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldUserId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDesc, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDate, tblCodhayeDaramd_1.fldDaramadCode
FROM            Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId 
					  
	WHERE  fldMahdodiyatMohasebatId = @Value  

	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldMahdodiyatMohasebatId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldUserId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDesc, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDate, tblCodhayeDaramd_1.fldDaramadCode
FROM            Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId 
	  
	WHERE tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDesc like  @Value  

	if (@fieldname=N'')
	SELECT        TOP (@h) Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldMahdodiyatMohasebatId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldUserId, 
                         Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDesc, Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldDate, tblCodhayeDaramd_1.fldDaramadCode
FROM            Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblMahdoodiyatMohasebat_ShomareHesabDaramad.fldShomarehesabDarmadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId 
						   
	
	COMMIT
GO
