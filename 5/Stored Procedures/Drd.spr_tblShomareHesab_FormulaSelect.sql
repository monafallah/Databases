SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesab_FormulaSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organid int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) f.[fldId], [fldShomareHesab_CodeId], f.[fldFormolsaz], f.[fldFormulKoliId], f.[fldFormulMohasebatId], [fldTarikhEjra], f.[fldDate], f.[fldUserId] 
	FROM   [Drd].[tblShomareHesab_Formula]f
	inner join drd.tblShomareHesabCodeDaramad c
	on c.fldid=[fldShomareHesab_CodeId]

	WHERE  f.fldId=@Value and fldActive=1

	
	if (@FieldName='fldShomareHesab_CodeId')
SELECT top(@h) f.[fldId], [fldShomareHesab_CodeId], f.[fldFormolsaz], f.[fldFormulKoliId], f.[fldFormulMohasebatId], [fldTarikhEjra], f.[fldDate], f.[fldUserId] 
	FROM   [Drd].[tblShomareHesab_Formula]f
	inner join drd.tblShomareHesabCodeDaramad c
	on c.fldid=[fldShomareHesab_CodeId]
	WHERE  fldShomareHesab_CodeId=@Value  and fldOrganId=@organid  and fldActive=1
	ORDER BY f.fldTarikhEjra desc

	if (@FieldName='LastFormule')
	SELECT top(1) f.[fldId], [fldShomareHesab_CodeId], f.[fldFormolsaz], f.[fldFormulKoliId], f.[fldFormulMohasebatId], [fldTarikhEjra], f.[fldDate], f.[fldUserId] 
	FROM   [Drd].[tblShomareHesab_Formula]f
	inner join drd.tblShomareHesabCodeDaramad c
	on c.fldid=[fldShomareHesab_CodeId] 
	WHERE  fldTarikhEjra<=dbo.Fn_AssembelyMiladiToShamsi(cast(getdate()as date)) and fldShomareHesab_CodeId=@Value and fldOrganId=@organid  and fldActive=1
	order by fldid desc

		if (@FieldName='fldOrganId')
	SELECT top(@h) f.[fldId], [fldShomareHesab_CodeId], f.[fldFormolsaz], f.[fldFormulKoliId], f.[fldFormulMohasebatId], [fldTarikhEjra], f.[fldDate], f.[fldUserId] 
	FROM   [Drd].[tblShomareHesab_Formula]f
	inner join drd.tblShomareHesabCodeDaramad c
	on c.fldid=[fldShomareHesab_CodeId]
	where fldOrganId=@organid  and fldActive=1
	ORDER BY f.fldTarikhEjra desc

	if (@FieldName='')
	SELECT top(@h) f.[fldId], [fldShomareHesab_CodeId], f.[fldFormolsaz], f.[fldFormulKoliId], f.[fldFormulMohasebatId], [fldTarikhEjra], f.[fldDate], f.[fldUserId] 
	FROM   [Drd].[tblShomareHesab_Formula]f
	inner join drd.tblShomareHesabCodeDaramad c
	on c.fldid=[fldShomareHesab_CodeId]
	where   fldActive=1
	ORDER BY f.fldTarikhEjra desc

	
	COMMIT
GO
