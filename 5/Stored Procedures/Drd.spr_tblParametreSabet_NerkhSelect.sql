SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_NerkhSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 
	WHERE  fldId like @Value

	if (@fieldname=N'fldParametreSabetId')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 
	WHERE  fldParametreSabetId like @Value

	if (@fieldname=N'fldTarikh_ParametreSabetId')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 
	WHERE  fldParametreSabetId like @Value and com.ShamsiToMiladi(fldTarikhFaalSazi)<= getdate()
		order by [fldTarikhFaalSazi] desc

	if (@fieldname=N'fldValue')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 
	WHERE  fldValue like @Value

	if (@fieldname=N'fldTarikhFaalSazi')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 
	WHERE  fldTarikhFaalSazi like @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldParametreSabetId], [fldTarikhFaalSazi], [fldValue], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblParametreSabet_Nerkh] 

	COMMIT
GO
