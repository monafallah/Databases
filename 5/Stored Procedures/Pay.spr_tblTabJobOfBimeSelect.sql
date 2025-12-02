SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTabJobOfBimeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldJobCode')
	SELECT top(@h) [fldJobCode], [fldJobDesc] 
	FROM   [Pay].[tblTabJobOfBime] 
	WHERE  fldJobCode = @Value

	if (@fieldname=N'fldJobDesc')
	SELECT top(@h) [fldJobCode], [fldJobDesc] 
	FROM   [Pay].[tblTabJobOfBime] 
	WHERE  fldJobDesc like @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldJobCode], [fldJobDesc] 
	FROM   [Pay].[tblTabJobOfBime] 

	COMMIT
GO
