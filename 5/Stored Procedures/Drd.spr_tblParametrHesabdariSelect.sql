SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametrHesabdariSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	
	if (@fieldname=N'fldId')
	SELECT top(@h) h.[fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	FROM   [Drd].[tblParametrHesabdari] h
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON h.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE  h.fldId = @Value  

	if (@fieldname=N'fldDesc')
	SELECT top(@h) h.[fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	FROM   [Drd].[tblParametrHesabdari] h
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON h.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE h.fldDesc like  @Value  
	
	if (@fieldname=N'fldCompanyId')
	SELECT top(@h) h.[fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	FROM   [Drd].[tblParametrHesabdari] h
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON h.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE fldCompanyId like  @Value  
	
	if (@fieldname=N'fldShomareHesabCodeDaramadId')
	SELECT top(@h) h.[fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	FROM   [Drd].[tblParametrHesabdari] h
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON h.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE h.fldShomareHesabCodeDaramadId like  @Value  


	if (@fieldname=N'fldShomareHesabCodeDaramadId_HesabRayan')
	SELECT top(@h) h.[fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	FROM   [Drd].[tblParametrHesabdari] h
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON h.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	   
	WHERE h.fldShomareHesabCodeDaramadId like  @Value  

	if (@fieldname=N'')
	SELECT top(@h) h.[fldId], [fldShomareHesabCodeDaramadId], [fldCodeHesab], [fldHesabId], [fldCompanyId], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	FROM   [Drd].[tblParametrHesabdari] h
	 INNER JOIN Drd.tblShomareHesabCodeDaramad ON h.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
	 

	COMMIT
GO
