SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblRooneveshtSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)

	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) r.[fldId], [fldShomareHesabCodeDaramadId], [fldTitle], r.[fldUserId], r.[fldDate], r.[fldDesc] 
	FROM   [Drd].[tblRoonevesht] r
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON r.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE  r.fldId = @Value 

	if (@fieldname=N'fldTitle')
	SELECT top(@h) r.[fldId], [fldShomareHesabCodeDaramadId], [fldTitle], r.[fldUserId], r.[fldDate], r.[fldDesc] 
	FROM   [Drd].[tblRoonevesht] r
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON r.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE  fldTitle like @Value 

	if (@fieldname=N'fldDesc')
	SELECT top(@h) r.[fldId], [fldShomareHesabCodeDaramadId], [fldTitle], r.[fldUserId], r.[fldDate], r.[fldDesc] 
	FROM   [Drd].[tblRoonevesht] r
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON r.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE  r.fldDesc like @Value 

	if (@fieldname=N'fldShomareHesabCodeDaramadId')
	SELECT top(@h) r.[fldId], [fldShomareHesabCodeDaramadId], [fldTitle], r.[fldUserId], r.[fldDate], r.[fldDesc] 
	FROM   [Drd].[tblRoonevesht] r
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON r.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE  fldShomareHesabCodeDaramadId = @Value 


	if (@fieldname=N'')
	SELECT top(@h) r.[fldId], [fldShomareHesabCodeDaramadId], [fldTitle], r.[fldUserId], r.[fldDate], r.[fldDesc] 
	FROM   [Drd].[tblRoonevesht] r
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON r.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	
	COMMIT
GO
