SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblLoginFailedSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldUserName], [fldIP], [fldDate] 
	FROM   [Com].[tblLoginFailed] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldUserName')
	SELECT top(@h) [fldId], [fldUserName], [fldIP], [fldDate] 
	FROM   [Com].[tblLoginFailed] 
	WHERE fldUserName like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldUserName], [fldIP], [fldDate] 
	FROM   [Com].[tblLoginFailed] 

	COMMIT
GO
