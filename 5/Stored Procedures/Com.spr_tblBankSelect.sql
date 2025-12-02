SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblBankSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldBankName')
	SELECT top(@h) [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] 
	WHERE  fldBankName LIKE @Value
	
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'BankFix')
	SELECT top(@h) [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] 
	WHERE  fldFix=1

	if (@fieldname=N'fldFixTitle')
	SELECT top(@h) *from(select [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] )as t
	WHERE  fldFixTitle like @Value
	
	if (@fieldname=N'fldInfinitiveBank')
	SELECT top(@h) *from(select [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] )as t
	WHERE  fldInfinitiveBank like @Value

	if (@fieldname=N'BankTemplate_DetailsId')/**فرق داره*/
	SELECT        TOP (@h) b.fldId, b.fldBankName,isnull(d.fldId,0) fldFileId, b.fldUserId, b.fldDate, b.fldDesc, b.fldCentralBankCode, b.fldInfinitiveBank, b.fldFix, CASE WHEN fldFix = 1 THEN N'ثابت' WHEN fldFix = 0 THEN N'عمومی' END AS fldFixTitle
FROM            Com.tblBank AS b left JOIN
                         acc.tblBankTemplate_Details AS d ON d.fldBankId = b.fldId and d.fldHeaderId=@value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldBankName], [fldFileId], [fldUserId], [fldDate], [fldDesc] ,fldCentralBankCode,fldInfinitiveBank,fldFix,CASE WHEN fldFix=1 THEN N'ثابت' WHEN fldFix=0 THEN N'عمومی' END AS fldFixTitle
	FROM   [Com].[tblBank] 

	COMMIT
GO
