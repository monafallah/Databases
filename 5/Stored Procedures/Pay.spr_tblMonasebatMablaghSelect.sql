SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatMablaghSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@value3 nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	WHERE  m.fldId=@value
	
	if (@fieldname='fldNameMonasebat')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	WHERE  fldNameMonasebat like @value

	if (@fieldname='CheckUnique')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	WHERE  fldHeaderId= @value and fldMonasebatId=@value2 and fldTypeNesbatId=@value3

	if (@fieldname='CheckCalc')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], m.[fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	inner join pay.tblMohasebat_Items as i on fldSourceId=m.fldId 
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	WHERE  fldHeaderId= @value and e.fldItemsHoghughiId=67

	
	if (@fieldname='fldHeaderId_MonasebatId')
	select  isnull(m.[fldId],0) as fldId,  isnull(m.[fldHeaderId],@value) as [fldHeaderId], isnull(m.[fldMonasebatId],@value2) as [fldMonasebatId], isnull(m.[fldMablagh],0) as [fldMablagh],
	 n.fldid as[fldTypeNesbatId],  isnull(m.[fldIP],0) as [fldIP],  isnull(m.[fldUserId],0) as [fldUserId], isnull(getDate(),0) as [fldDate] 
	,a.fldNameMonasebat,a.fldNameType,n.fldTypeName as fldTypeNesbatName
	from  pay.tblTypeNesbat as n
	left join pay.[tblMonasebatMablagh] as m on n.fldId=m.fldTypeNesbatId and m.fldHeaderId=@value and fldMonasebatId=@value2
	cross apply(
			select a.fldNameMonasebat,t.fldName as fldNameType from pay.tblMonasebat as a 
			inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId
			where a.fldId=@value2	)a

	if (@fieldname='fldMonasebatId')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	WHERE  m.fldMonasebatId like @value

	if (@fieldname='fldNameType')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	WHERE  t.fldName like @value

	if (@fieldname='')
	SELECT top(@h)m.[fldId], [fldHeaderId], [fldMonasebatId], [fldMablagh], [fldTypeNesbatId], m.[fldIP], m.[fldUserId], m.[fldDate] 
	,a.fldNameMonasebat,t.fldName as fldNameType,n.fldTypeName as fldTypeNesbatName
	FROM   [Pay].[tblMonasebatMablagh] as m
	inner join pay.tblMonasebat as a on a.fldId=m.fldMonasebatId
	inner join pay.tblMonasebatType as t on t.fldId=a.fldMonasebatTypeId	
	inner join pay.tblTypeNesbat as n on n.fldId=m.fldTypeNesbatId
	


	COMMIT
GO
