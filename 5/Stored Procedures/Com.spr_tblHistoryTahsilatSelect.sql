SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblHistoryTahsilatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	WHERE  h.fldId = @Value

	if (@fieldname=N'fldDesc')
		SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	where h.flddesc like @Value

	if (@fieldname=N'fldEmployeeId')
	SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	WHERE fldEmployeeId =  @Value

	if (@fieldname=N'fldMadrakId_ReshteId')
	SELECT  h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	WHERE fldEmployeeId =  @Value and [fldMadrakId]=@Value2 and [fldReshteId]=@h

	if (@fieldname=N'fldTarikh')
		SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	WHERE  fldEmployeeId =  @Value and fldTarikh like  @Value2

	if (@fieldname=N'fldTitleMadrak')
		SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	WHERE  fldEmployeeId =  @Value and m.fldTitle like  @Value2

	if (@fieldname=N'fldTitleReshte')
		SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]
	WHERE  fldEmployeeId =  @Value and r.fldTitle like  @Value2

	if (@fieldname=N'')
		SELECT top(@h) h.[fldId], h.[fldEmployeeId], h.[fldMadrakId], h.[fldReshteId], h.[fldTarikh], h.[fldUserId], h.[fldDesc], h.[fldDate] 
	,m.fldTitle as fldTitleMadrak,r.fldTitle as fldTitleReshte
	FROM   [Com].[tblHistoryTahsilat] as h
	inner join com.tblMadrakTahsili as m on m.fldid=h.[fldMadrakId]
	inner join com.tblReshteTahsili as r on r.fldid=h.[fldReshteId]

	COMMIT
GO
