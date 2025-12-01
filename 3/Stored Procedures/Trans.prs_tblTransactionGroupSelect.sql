SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName] 
	FROM   [Trans].[tblTransactionGroup] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName] 
	FROM   [Trans].[tblTransactionGroup] 
	WHERE  fldName like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName] 
	FROM   [Trans].[tblTransactionGroup] 

	COMMIT
GO
