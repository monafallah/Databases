SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankTemplate_DetailsSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)d.[fldId], [fldHeaderId], [fldBankId] ,fldBankName
	FROM   [ACC].[tblBankTemplate_Details]  as d 
	inner join com.tblBank as b on d.fldBankId=b.fldId
	WHERE  d.fldId=@value
	
	if (@fieldname='')
	SELECT  top(@h) d.[fldId], [fldHeaderId], [fldBankId]  ,fldBankName
	FROM   [ACC].[tblBankTemplate_Details]  as d
	inner join com.tblBank as b on d.fldBankId=b.fldId
	

	COMMIT
GO
