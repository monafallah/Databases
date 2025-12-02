SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTakhfifSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT TOP (@h) fldId, fldDarsad, fldMablagh, fldShomareMajavez, fldTarikh, fldUserId, fldDesc, fldDate, fldStatusId
FROM     Drd.tblReplyTakhfif
	WHERE  fldId = @Value
  
	if (@fieldname=N'fldRequestId')
SELECT     TOP (1) Drd.tblReplyTakhfif.fldId, Drd.tblReplyTakhfif.fldDarsad, Drd.tblReplyTakhfif.fldMablagh, Drd.tblReplyTakhfif.fldShomareMajavez, 
                      Drd.tblReplyTakhfif.fldTarikh, Drd.tblReplyTakhfif.fldUserId, Drd.tblReplyTakhfif.fldDesc, Drd.tblReplyTakhfif.fldDate, Drd.tblReplyTakhfif.fldStatusId
FROM         Drd.tblReplyTakhfif INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId
	WHERE  fldRequestId = @Value
	ORDER BY Drd.tblReplyTakhfif.fldId DESC


	if (@fieldname=N'fldStatusId')
	SELECT TOP (@h) fldId, fldDarsad, fldMablagh, fldShomareMajavez, fldTarikh, fldUserId, fldDesc, fldDate, fldStatusId
FROM     Drd.tblReplyTakhfif
	WHERE  fldStatusId = @Value

		if (@fieldname=N'fldDesc')
	SELECT TOP (@h) fldId, fldDarsad, fldMablagh, fldShomareMajavez, fldTarikh, fldUserId, fldDesc, fldDate, fldStatusId
FROM     Drd.tblReplyTakhfif
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldDarsad], [fldMablagh], [fldShomareMajavez], [fldTarikh], [fldUserId], [fldDesc], [fldDate], fldStatusId 
	fROM   [Drd].[tblReplyTakhfif] 

	COMMIT
GO
