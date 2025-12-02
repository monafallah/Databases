SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTaghsitSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT TOP (@h) fldId, CAST(fldMablaghNaghdi AS BIGINT)fldMablaghNaghdi, fldTedadAghsat, fldShomareMojavez, fldTarikh, fldUserId, fldDesc, fldDate, fldStatusId, fldTedadMahAghsat, CAST(fldJarimeTakhir AS BIGINT)fldJarimeTakhir,fldDarsad,fldDescKarmozd
FROM     Drd.tblReplyTaghsit
	WHERE  fldId = @Value
	 
	 	if (@fieldname=N'fldRequestId')--این select متفاوت است
SELECT     TOP (1) Drd.tblReplyTaghsit.fldId, CAST(tblReplyTaghsit.fldMablaghNaghdi AS BIGINT)fldMablaghNaghdi, Drd.tblReplyTaghsit.fldTedadAghsat, Drd.tblReplyTaghsit.fldShomareMojavez, 
                      Drd.tblReplyTaghsit.fldTarikh, Drd.tblReplyTaghsit.fldUserId, Drd.tblReplyTaghsit.fldDesc, Drd.tblReplyTaghsit.fldDate, Drd.tblReplyTaghsit.fldStatusId, 
                      Drd.tblReplyTaghsit.fldTedadMahAghsat,  CAST(fldJarimeTakhir AS BIGINT)fldJarimeTakhir,fldDarsad,fldDescKarmozd

FROM         Drd.tblReplyTaghsit INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId
	WHERE  fldRequestId = @Value
	ORDER BY Drd.tblReplyTaghsit.fldId DESC
	
	 
    if (@fieldname=N'fldStatusId')
	SELECT top(@h) [fldId],  CAST(fldMablaghNaghdi AS BIGINT)fldMablaghNaghdi, [fldTedadAghsat], [fldShomareMojavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate] ,fldStatusId, fldTedadMahAghsat,  CAST(fldJarimeTakhir AS BIGINT)fldJarimeTakhir,fldDarsad,fldDescKarmozd
	FROM   [Drd].[tblReplyTaghsit] 
	WHERE  fldStatusId = @Value

	if (@fieldname=N'fldDesc')
	SELECT TOP (@h) fldId, CAST(fldMablaghNaghdi AS BIGINT)fldMablaghNaghdi, fldTedadAghsat, fldShomareMojavez, fldTarikh, fldUserId, fldDesc, fldDate, fldStatusId, fldTedadMahAghsat,  CAST(fldJarimeTakhir AS BIGINT)fldJarimeTakhir,fldDarsad,fldDescKarmozd
    FROM     Drd.tblReplyTaghsit
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], CAST(fldMablaghNaghdi AS BIGINT)fldMablaghNaghdi, [fldTedadAghsat], [fldShomareMojavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate] ,fldStatusId, fldTedadMahAghsat, fldJarimeTakhir,fldDarsad,fldDescKarmozd
	FROM   [Drd].[tblReplyTaghsit] 

	COMMIT
GO
