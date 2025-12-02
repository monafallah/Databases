SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblStatusTaghsit_TakhfifSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldRequestId], [fldTypeMojavez], [fldTypeRequest], [fldUserId], [fldDesc], [fldDate],
	case when  fldTypeMojavez=1 then N'توافق' when fldTypeMojavez=2 then N'عدم توافق'end as Vaziyat,case when  fldTypeRequest=1 then N'تقسیط' when fldTypeRequest=2 then N'تخفیف'end as NoeDarkhast
	FROM   [Drd].[tblStatusTaghsit_Takhfif] 
	WHERE  fldId = @Value


	if (@fieldname=N'fldRequestId')
	SELECT top(@h) [fldId], [fldRequestId], [fldTypeMojavez], [fldTypeRequest], [fldUserId], [fldDesc], [fldDate],
	case when  fldTypeMojavez=1 then N'توافق' when fldTypeMojavez=2 then N'عدم توافق'end as Vaziyat,case when  fldTypeRequest=1 then N'تقسیط' when fldTypeRequest=2 then N'تخفیف'end as NoeDarkhast
	FROM   [Drd].[tblStatusTaghsit_Takhfif] 
	WHERE  fldRequestId = @Value


	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldRequestId], [fldTypeMojavez], [fldTypeRequest], [fldUserId], [fldDesc], [fldDate],
	case when  fldTypeMojavez=1 then N'توافق' when fldTypeMojavez=2 then N'عدم توافق'end as Vaziyat,case when  fldTypeRequest=1 then N'تقسیط' when fldTypeRequest=2 then N'تخفیف'end as NoeDarkhast
	FROM   [Drd].[tblStatusTaghsit_Takhfif] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldRequestId], [fldTypeMojavez], [fldTypeRequest], [fldUserId], [fldDesc], [fldDate] ,
	case when  fldTypeMojavez=1 then N'توافق' when fldTypeMojavez=2 then N'عدم توافق'end as Vaziyat,case when  fldTypeRequest=1 then N'تقسیط' when fldTypeRequest=2 then N'تخفیف'end as NoeDarkhast
	FROM   [Drd].[tblStatusTaghsit_Takhfif] 

	COMMIT
GO
