SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPSPModel_ShomareHesabSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Drd.tblPSPModel_ShomareHesab.fldId, Drd.tblPSPModel_ShomareHesab.fldPSPModelId, Drd.tblPSPModel_ShomareHesab.fldShHesabId, Drd.tblPSPModel_ShomareHesab.fldOrder, 
                         Drd.tblPSPModel_ShomareHesab.fldUserId, Drd.tblPSPModel_ShomareHesab.fldDesc, Drd.tblPSPModel_ShomareHesab.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab
FROM            Drd.tblPSPModel_ShomareHesab INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblPSPModel_ShomareHesab.fldShHesabId = Com.tblShomareHesabeOmoomi.fldId	
						 WHERE  tblPSPModel_ShomareHesab.fldId = @Value

	if (@fieldname=N'fldShHesabId')
	SELECT        TOP (@h) Drd.tblPSPModel_ShomareHesab.fldId, Drd.tblPSPModel_ShomareHesab.fldPSPModelId, Drd.tblPSPModel_ShomareHesab.fldShHesabId, Drd.tblPSPModel_ShomareHesab.fldOrder, 
                         Drd.tblPSPModel_ShomareHesab.fldUserId, Drd.tblPSPModel_ShomareHesab.fldDesc, Drd.tblPSPModel_ShomareHesab.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab
FROM            Drd.tblPSPModel_ShomareHesab INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblPSPModel_ShomareHesab.fldShHesabId = Com.tblShomareHesabeOmoomi.fldId	
	WHERE fldShHesabId like  @Value
	
	if (@fieldname=N'fldPSPModelId')
	SELECT        TOP (@h) Drd.tblPSPModel_ShomareHesab.fldId, Drd.tblPSPModel_ShomareHesab.fldPSPModelId, Drd.tblPSPModel_ShomareHesab.fldShHesabId, Drd.tblPSPModel_ShomareHesab.fldOrder, 
                         Drd.tblPSPModel_ShomareHesab.fldUserId, Drd.tblPSPModel_ShomareHesab.fldDesc, Drd.tblPSPModel_ShomareHesab.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab
FROM            Drd.tblPSPModel_ShomareHesab INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblPSPModel_ShomareHesab.fldShHesabId = Com.tblShomareHesabeOmoomi.fldId	
	WHERE fldPSPModelId like  @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) Drd.tblPSPModel_ShomareHesab.fldId, Drd.tblPSPModel_ShomareHesab.fldPSPModelId, Drd.tblPSPModel_ShomareHesab.fldShHesabId, Drd.tblPSPModel_ShomareHesab.fldOrder, 
                         Drd.tblPSPModel_ShomareHesab.fldUserId, Drd.tblPSPModel_ShomareHesab.fldDesc, Drd.tblPSPModel_ShomareHesab.fldDate, Com.tblShomareHesabeOmoomi.fldShomareHesab
FROM            Drd.tblPSPModel_ShomareHesab INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblPSPModel_ShomareHesab.fldShHesabId = Com.tblShomareHesabeOmoomi.fldId	
 

	COMMIT
GO
