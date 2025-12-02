SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblStateSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblState] 
	WHERE  fldId = @Value
	ORDER BY fldName

if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblState] 
	WHERE  fldName like @Value
		ORDER BY fldName

	if (@fieldname=N'fldDesc')
		SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate] 
		FROM   [Com].[tblState] 
		WHERE  fldDesc like @Value
		ORDER BY fldName

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblState] 
	ORDER BY fldName

	COMMIT
GO
