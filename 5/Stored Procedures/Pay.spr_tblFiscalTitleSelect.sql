SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscalTitleSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT TOP (@h) Pay.tblFiscalTitle.fldId, Pay.tblFiscalTitle.fldFiscalHeaderId, Pay.tblFiscalTitle.fldItemEstekhdamId, 
                     Pay.tblFiscalTitle.fldUserId, Pay.tblFiscalTitle.fldDate, Pay.tblFiscalTitle.fldDesc, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldAnvaEstekhdamId
FROM         Pay.tblFiscalTitle INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblFiscalTitle.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  Pay.tblFiscalTitle.fldId = @Value
	
		if (@fieldname=N'fldDesc')
	SELECT TOP (@h) Pay.tblFiscalTitle.fldId, Pay.tblFiscalTitle.fldFiscalHeaderId, Pay.tblFiscalTitle.fldItemEstekhdamId, 
                     Pay.tblFiscalTitle.fldUserId, Pay.tblFiscalTitle.fldDate, Pay.tblFiscalTitle.fldDesc, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldAnvaEstekhdamId
FROM         Pay.tblFiscalTitle INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblFiscalTitle.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  Pay.tblFiscalTitle.fldDesc LIKE @Value
	

	if (@fieldname=N'fldAnvaEstekhdamId')
		SELECT TOP (@h) Pay.tblFiscalTitle.fldId, Pay.tblFiscalTitle.fldFiscalHeaderId, Pay.tblFiscalTitle.fldItemEstekhdamId,
                       Pay.tblFiscalTitle.fldUserId, Pay.tblFiscalTitle.fldDate, Pay.tblFiscalTitle.fldDesc, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldAnvaEstekhdamId
FROM         Pay.tblFiscalTitle INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblFiscalTitle.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  Pay.tblFiscalTitle.fldAnvaEstekhdamId = @Value
	
	if (@fieldname=N'fldFiscalHeaderId')
		SELECT TOP (@h) Pay.tblFiscalTitle.fldId, Pay.tblFiscalTitle.fldFiscalHeaderId, Pay.tblFiscalTitle.fldItemEstekhdamId, 
                      Pay.tblFiscalTitle.fldUserId, Pay.tblFiscalTitle.fldDate, Pay.tblFiscalTitle.fldDesc, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldAnvaEstekhdamId
FROM         Pay.tblFiscalTitle INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblFiscalTitle.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  Pay.tblFiscalTitle.fldFiscalHeaderId = @Value


	if (@fieldname=N'')
	SELECT TOP (@h) Pay.tblFiscalTitle.fldId, Pay.tblFiscalTitle.fldFiscalHeaderId, Pay.tblFiscalTitle.fldItemEstekhdamId, 
                      Pay.tblFiscalTitle.fldUserId, Pay.tblFiscalTitle.fldDate, Pay.tblFiscalTitle.fldDesc, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldAnvaEstekhdamId
FROM         Pay.tblFiscalTitle INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblFiscalTitle.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	COMMIT
GO
