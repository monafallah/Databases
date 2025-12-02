SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatTarikhSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value1 nvarchar(50),
@value2 nvarchar(50),
@value3 nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	WHERE  m.fldId=@value
	
	if (@fieldname='fldMonasebatId')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	WHERE  m.fldMonasebatId=@value

	if (@fieldname='fldNameMonasebat')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	WHERE  a.fldNameMonasebat like @value

	if (@fieldname='fldNameType')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	WHERE t.fldName like @value

	if (@fieldname='CheckUniqe')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	WHERE  m.fldYear=@value and m.fldMonth=@value1 and m.fldDay=@value2 and m.fldMonasebatId=@value3

	if (@fieldname='DateShamsi')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	WHERE  m.fldYear=@value and m.fldMonth=@value1 

	if (@fieldname='')
	SELECT top(@h)m.[fldId], [fldYear], m.[fldMonth], m.[fldDay], [fldMonasebatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,fldMazaya
	FROM   [Pay].[tblMonasebatTarikh]  as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
	


	COMMIT
GO
