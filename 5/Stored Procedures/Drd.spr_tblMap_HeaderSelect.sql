SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMap_HeaderSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldSalMada], [fldSalMaghsad], [fldMarja], [fldDate] 
	FROM   [Drd].[tblMap_Header] 
	WHERE  fldId=@value
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldSalMada], [fldSalMaghsad], [fldMarja], [fldDate] 
	FROM   [Drd].[tblMap_Header] 
	


	COMMIT
GO
