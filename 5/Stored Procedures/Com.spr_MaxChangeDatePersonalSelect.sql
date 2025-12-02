SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_MaxChangeDatePersonalSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	
	if (@fieldname=N'Prs_fldPersonalInfoId')
	SELECT top(@h) max(fldDateTaghirVaziyat) AS fldDateTaghierVaziyat
	FROM  Com.tblPersonalStatus
	WHERE  (fldPrsPersonalInfoId) like ( @Value) 
	
	if (@fieldname=N'Pay_fldPersonalInfoId')
	SELECT top(@h) max(fldDateTaghirVaziyat) AS fldDateTaghierVaziyat
	FROM   Com.tblPersonalStatus 
	WHERE  (fldPayPersonalInfoId) like ( @Value) 



	COMMIT
GO
