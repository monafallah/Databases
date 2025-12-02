SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Pay].[spr_tblMohasebat_ItemMotamamSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
		SELECT top(@h) i.[fldId], i.[fldMohasebatId],i.[fldItemEstekhdamId], i.[fldMablagh] ,h.fldTitle
	FROM   [Pay].[tblMohasebat_ItemMotamam]  as i
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
	WHERE  i.fldId = @Value

	
	if (@fieldname=N'fldMohasebatId')
	SELECT top(@h) i.[fldId], i.[fldMohasebatId],i.[fldItemEstekhdamId], i.[fldMablagh] ,h.fldTitle
	FROM   [Pay].[tblMohasebat_ItemMotamam]  as i
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
	WHERE  fldMohasebatId = @Value

	if (@fieldname=N'Bime')
	SELECT top(@h) i.[fldId], i.[fldMohasebatId],i.[fldItemEstekhdamId], i.[fldMablagh] ,h.fldTitle
	FROM   [Pay].[tblMohasebat_ItemMotamam]  as i
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
	WHERE  fldMohasebatId = @Value and fldItemsHoghughiId=76


	if (@fieldname=N'')
		SELECT top(@h) i.[fldId], i.[fldMohasebatId],i.[fldItemEstekhdamId], i.[fldMablagh] ,h.fldTitle
	FROM   [Pay].[tblMohasebat_ItemMotamam]  as i
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId

	COMMIT
GO
