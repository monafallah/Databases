SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankBill_HeaderSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId

	WHERE  b.fldId=@value

	if (@fieldname='fldName')
	SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId

	WHERE  b.fldName=@value

	if (@fieldname='fldDesc')
	SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId

	WHERE  b.fldDesc=@value
	
	if (@fieldname='fldShomareHesabId')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	WHERE  fldShomareHesabId=@value

	if (@fieldname='fldFiscalYearId')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	WHERE  fldFiscalYearId=@value

	if (@fieldname='fldPatternId')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	WHERE  fldPatternId=@value


	if (@fieldname='fldNamePattern')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	WHERE  fldNamePattern like @value

	if (@fieldname='fldBankName')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	WHERE  fldBankName like @value

	if (@fieldname='fldShomareHesab')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	WHERE  fldShomareHesab like @value

	if (@fieldname='')
		SELECT        TOP (@h) b.fldId, b.fldName, b.fldShomareHesabId, b.fldFiscalYearId, b.fldJsonFile, b.fldDesc, b.fldDate, b.fldIP, b.fldUserId, b.fldPatternId, p.fldNamePattern
	,s.fldShomareHesab,k.fldBankName
FROM            ACC.tblBankBill_Header AS b INNER JOIN
                         acc.tblBankTemplate_Header AS p ON p.fldId = b.fldPatternId inner join
						 com.tblShomareHesabeOmoomi as s on s.fldId=b.fldShomareHesabId inner join
						 com.tblBank as k on k.fldId=s.fldBankId
	


	COMMIT
GO
