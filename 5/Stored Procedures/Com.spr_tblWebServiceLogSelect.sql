SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWebServiceLogSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMatn], [fldUser], [flddate] 
	FROM   [Com].[tblWebServiceLog] 
	WHERE  fldId = @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMatn], [fldUser], [flddate] 
	FROM   [Com].[tblWebServiceLog] 

	COMMIT
GO
