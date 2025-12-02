SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblItemsHoghughiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) i.[fldId], i.[fldTitle], [fldNameEN] ,i.fldType,fldTypeHesabId,h.fldTitle as fldTitleHesab,fldMostamar
	,case when fldMostamar=1 then N'مستمر' else N'غیرمستمر' end as fldMostamarName
	FROM    [Com].[tblItemsHoghughi]  as i
	inner join com.tblHesabType as h on h.fldId=i.fldTypeHesabId
	WHERE  i.fldId = @Value

	if (@fieldname=N'fldTitle')
	SELECT top(@h) i.[fldId], i.[fldTitle], [fldNameEN] ,i.fldType,fldTypeHesabId,h.fldTitle as fldTitleHesab,fldMostamar
	,case when fldMostamar=1 then N'مستمر' else N'غیرمستمر' end as fldMostamarName
	FROM    [Com].[tblItemsHoghughi]  as i
	inner join com.tblHesabType as h on h.fldId=i.fldTypeHesabId
	WHERE  i.fldTitle like @Value

	if (@fieldname=N'fldTitleHesab')
	SELECT top(@h) i.[fldId], i.[fldTitle], [fldNameEN] ,i.fldType,fldTypeHesabId,h.fldTitle as fldTitleHesab,fldMostamar
	,case when fldMostamar=1 then N'مستمر' else N'غیرمستمر' end as fldMostamarName
	FROM    [Com].[tblItemsHoghughi]  as i
	inner join com.tblHesabType as h on h.fldId=i.fldTypeHesabId
	WHERE  h.fldTitle like @Value

	if (@fieldname=N'fldTypeHesabId')
	SELECT top(@h) i.[fldId], i.[fldTitle], [fldNameEN] ,i.fldType,fldTypeHesabId,h.fldTitle as fldTitleHesab,fldMostamar
	,case when fldMostamar=1 then N'مستمر' else N'غیرمستمر' end as fldMostamarName	
	FROM    [Com].[tblItemsHoghughi]  as i
	inner join com.tblHesabType as h on h.fldId=i.fldTypeHesabId
	WHERE  fldTypeHesabId= @Value

	if (@fieldname=N'')
	SELECT top(@h) i.[fldId], i.[fldTitle], [fldNameEN] ,i.fldType,fldTypeHesabId,h.fldTitle as fldTitleHesab,fldMostamar
	,case when fldMostamar=1 then N'مستمر' else N'غیرمستمر' end as fldMostamarName
	FROM    [Com].[tblItemsHoghughi]  as i
	inner join com.tblHesabType as h on h.fldId=i.fldTypeHesabId

	COMMIT
GO
