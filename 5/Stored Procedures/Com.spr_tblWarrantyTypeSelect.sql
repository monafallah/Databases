SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWarrantyTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalizeSelect(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName],[fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [Com].[tblWarrantyType]
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldName],[fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [Com].[tblWarrantyType] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName],[fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [Com].[tblWarrantyType]
	
	
	
	
	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName],[fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [Com].[tblWarrantyType] 
	WHERE fldName like  @Value
	
	COMMIT
GO
