SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMablaghTakhfifSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTakhfifAsli], [fldTakhfifMaliyat], [fldTakhfifAvarez], [fldCodeDaramadElamAvarezId], [fldType], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldType=1 THEN N'تخفیف کلی'  WHEN fldType=2 THEN N'پاسخ تخفیف'   WHEN fldType=3 THEN N'تخفیف نقدی'  end
	FROM   [Drd].[tblMablaghTakhfif] 
	WHERE  fldId = @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTakhfifAsli], [fldTakhfifMaliyat], [fldTakhfifAvarez], [fldCodeDaramadElamAvarezId], [fldType], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldType=1 THEN N'تخفیف کلی'  WHEN fldType=2 THEN N'پاسخ تخفیف'   WHEN fldType=3 THEN N'تخفیف نقدی'  end
	FROM   [Drd].[tblMablaghTakhfif] 

	COMMIT
GO
