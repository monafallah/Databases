SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblFileMojazSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
                         Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblFileMojaz INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId
	WHERE  tblFileMojaz.fldId = @Value

	if (@fieldname=N'fldArchiveTreeId')
	SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
                         Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblFileMojaz INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId
	WHERE  fldArchiveTreeId = @Value

	if (@fieldname=N'fldFormatName')
	begin
		SET @Value=Com.fn_TextNormalize(@Value)
		SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
							 Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
		FROM            Arch.tblFileMojaz INNER JOIN
							 Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
							 Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId
		WHERE  fldFormatName like @Value
	end
		if (@fieldname=N'fldTitle')
		begin
		SET @Value=Com.fn_TextNormalize(@Value)
		SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
							 Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
	FROM            Arch.tblFileMojaz INNER JOIN
							 Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
							 Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId
		WHERE  fldTitle like @Value
	end

	if (@fieldname=N'fldPassvand')
	begin
		SET @Value=Com.fn_TextNormalize(@Value)
	SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
                         Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblFileMojaz INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId
	WHERE  fldPassvand like @Value
end
	if (@fieldname=N'fldFormatFileId')
	SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
                         Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblFileMojaz INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId
 
	WHERE  fldFormatFileId = @Value

	if (@fieldname=N'fldDesc')
	begin
		SET @Value=Com.fn_TextNormalize(@Value)
		SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
							 Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
	FROM            Arch.tblFileMojaz INNER JOIN
							 Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
							 Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId

		WHERE tblFileMojaz.fldDesc like  @Value
	end
	if (@fieldname=N'')
	SELECT        TOP (@h) Arch.tblFileMojaz.fldId, Arch.tblFileMojaz.fldArchiveTreeId, Arch.tblFileMojaz.fldFormatFileId, Arch.tblFileMojaz.fldUserId, Arch.tblFileMojaz.fldDesc, Arch.tblFileMojaz.fldDate, 
                         Arch.tblFormatFile.fldFormatName, Arch.tblFormatFile.fldPassvand, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblFileMojaz INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblFileMojaz.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblFormatFile ON Arch.tblFileMojaz.fldFormatFileId = Arch.tblFormatFile.fldId


	COMMIT
GO
