SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaliyatDaraeiSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@fldYear smallint,
@fldMonth tinyint,
@fldNobatePardakht tinyint,
@fldOrganId nchar(10),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldCodemeli], [fldYear], [fldMonth], [fldMaliyat], [fldNobatePardakht], [fldOrganId], [fldUserId], [fldIp], [fldDate] 
	FROM   [Pay].[tblMaliyatDaraei] 
	WHERE  fldId=@value
	
	if (@fieldname='Check')
	SELECT top(@h)[fldId], [fldCodemeli], [fldYear], [fldMonth], [fldMaliyat], [fldNobatePardakht], [fldOrganId], [fldUserId], [fldIp], [fldDate] 
	FROM   [Pay].[tblMaliyatDaraei] 
	WHERE  [fldYear] = @fldYear and  [fldMonth] = @fldMonth and  [fldNobatePardakht] = @fldNobatePardakht and [fldOrganId] = @fldOrganId

	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldCodemeli], [fldYear], [fldMonth], [fldMaliyat], [fldNobatePardakht], [fldOrganId], [fldUserId], [fldIp], [fldDate] 
	FROM   [Pay].[tblMaliyatDaraei] 
	


	COMMIT
GO
