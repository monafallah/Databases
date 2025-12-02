SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblSMSSettingSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value= com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldUserName], [fldPassword], [fldShomareKhat],fldIP ,[fldUserId], [fldDesc], [fldDate] 
	FROM   [com].[tblSMSSetting] 
	WHERE  fldId = @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldUserName], [fldPassword], [fldShomareKhat],fldIP ,[fldUserId], [fldDesc], [fldDate] 
	FROM   [com].[tblSMSSetting] 

	commit

GO
