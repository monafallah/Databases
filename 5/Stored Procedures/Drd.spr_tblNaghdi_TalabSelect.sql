SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblNaghdi_TalabSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
    SELECT TOP (@h) fldId, fldMablagh, fldReplyTaghsitId, fldType, fldUserId, fldDesc, fldDate, 
    CASE WHEN fldType = 1 THEN N'نقدی' WHEN fldType = 2 THEN N'بدهکاری' WHEN fldType = 3 THEN N'بستانکاری'  END AS fldTypeName, 
                  fldFishId, fldShomareHesabId
    FROM     Drd.tblNaghdi_Talab
	WHERE  fldId = @Value


	 if (@fieldname=N'fldReplyTaghsitId')
	 SELECT TOP (@h) fldId, fldMablagh, fldReplyTaghsitId, fldType, fldUserId, fldDesc, fldDate, 
	 CASE WHEN fldType = 1 THEN N'نقدی' WHEN fldType = 2 THEN N'بدهکاری' WHEN fldType = 3 THEN N'بستانکاری'  END AS fldTypeName,
                  fldFishId, fldShomareHesabId
    FROM     Drd.tblNaghdi_Talab
	WHERE  fldReplyTaghsitId = @Value

		if (@fieldname=N'fldDesc')
	SELECT TOP (@h) fldId, fldMablagh, fldReplyTaghsitId, fldType, fldUserId, fldDesc, fldDate, 
	 CASE WHEN fldType = 1 THEN N'نقدی' WHEN fldType = 2 THEN N'بدهکاری' WHEN fldType = 3 THEN N'بستانکاری'  END AS fldTypeName,
					  fldFishId, fldShomareHesabId
	FROM     Drd.tblNaghdi_Talab
	WHERE  fldDesc like @Value

	if (@fieldname=N'fldFishId')
    SELECT TOP (@h) fldId, fldMablagh, fldReplyTaghsitId, fldType, fldUserId, fldDesc, fldDate,
     CASE WHEN fldType = 1 THEN N'نقدی' WHEN fldType = 2 THEN N'بدهکاری' WHEN fldType = 3 THEN N'بستانکاری'  END AS fldTypeName,
                  fldFishId, fldShomareHesabId
    FROM     Drd.tblNaghdi_Talab
	WHERE  fldFishId like @Value

	if (@fieldname=N'')
	SELECT TOP (@h) fldId, fldMablagh, fldReplyTaghsitId, fldType, fldUserId, fldDesc, fldDate,
	 CASE WHEN fldType = 1 THEN N'نقدی' WHEN fldType = 2 THEN N'بدهکاری' WHEN fldType = 3 THEN N'بستانکاری'  END AS fldTypeName,
					  fldFishId, fldShomareHesabId
	FROM     Drd.tblNaghdi_Talab

	COMMIT
GO
