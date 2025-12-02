SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblMotammamSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@organId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h) m.[fldId], [fldFiscalYearId], [fldTarikh], m.[fldDesc], m.[fldUserId], m.[fldOrganId], m.[fldDate] 
	,f.fldYear
	FROM   [BUD].[tblMotammam] m inner join acc.tblFiscalYear f 
	on f.fldid=m.fldFiscalYearId
	WHERE  m.fldId=@value
	
	if (@fieldname='fldFiscalYearId')
		SELECT top(@h) m.[fldId], [fldFiscalYearId], [fldTarikh], m.[fldDesc], m.[fldUserId], m.[fldOrganId], m.[fldDate] 
	,f.fldYear
	FROM   [BUD].[tblMotammam] m inner join acc.tblFiscalYear f 
	on f.fldid=m.fldFiscalYearId
	WHERE  fldFiscalYearId=@value and m.fldOrganid=@organId

	if (@fieldname='fldTarikh')
		SELECT top(@h) m.[fldId], [fldFiscalYearId], [fldTarikh], m.[fldDesc], m.[fldUserId], m.[fldOrganId], m.[fldDate] 
	,f.fldYear
	FROM   [BUD].[tblMotammam] m inner join acc.tblFiscalYear f 
	on f.fldid=m.fldFiscalYearId
	WHERE  fldTarikh like @value and m.fldOrganid=@organId

	if (@fieldname='fldYear')
	SELECT top(@h)m.[fldId], [fldFiscalYearId], [fldTarikh], m.[fldDesc], m.[fldUserId], m.[fldOrganId], m.[fldDate] 
	,f.fldYear
	FROM   [BUD].[tblMotammam] m inner join acc.tblFiscalYear f 
	on f.fldid=m.fldFiscalYearId
	WHERE  fldYear=@value and m.fldOrganid=@organId

	if (@fieldname='fldOrganid')
	SELECT top(@h)m.[fldId], [fldFiscalYearId], [fldTarikh], m.[fldDesc], m.[fldUserId], m.[fldOrganId], m.[fldDate] 
	,f.fldYear
	FROM   [BUD].[tblMotammam] m inner join acc.tblFiscalYear f 
	on f.fldid=m.fldFiscalYearId
	WHERE   m.fldOrganid=@organId


	if (@fieldname='')
		SELECT top(@h) m.[fldId], [fldFiscalYearId], [fldTarikh], m.[fldDesc], m.[fldUserId], m.[fldOrganId], m.[fldDate] 
	,f.fldYear
	FROM   [BUD].[tblMotammam] m inner join acc.tblFiscalYear f 
	on f.fldid=m.fldFiscalYearId


	COMMIT
GO
