SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_tblFileMojazSelect]
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value2 NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	SET @Value2=dbo.fn_TextNormalize(@Value2)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId,  tblFileMojaz.fldDesc ,
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
                       
                       FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
	WHERE  tblFileMojaz.fldId = @Value

	if (@fieldname=N'fldArchiveTreeId')
	SELECT        TOP (@h)tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId,  tblFileMojaz.fldDesc ,
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
                      
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
	WHERE  fldArchiveTreeId = @Value
	
	
	if (@fieldname=N'fldArchiveTreeId_Passvand')
	SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc  ,
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
                      
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
	WHERE  fldArchiveTreeId = @Value AND fldPassvand LIKE @value2


if (@fieldname=N'fldArchiveTreeId_FormatFileId')
	SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc  ,
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
                      
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
	WHERE  fldArchiveTreeId = @Value AND fldFormatFileId = @value2

	if (@fieldname=N'fldFormatName')
	begin
		
		SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc , 
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
                     
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
		WHERE  fldFormatName like @Value
	end
		if (@fieldname=N'fldTitle')
		begin
		
		SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc , 
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
            
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
		WHERE  fldTitle like @Value
	end

	if (@fieldname=N'fldPassvand')
	begin
		
SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc , 
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
         
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
	WHERE  fldPassvand like @Value
end
	if (@fieldname=N'fldFormatFileId')
	SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc , 
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
  
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId
 
	WHERE  fldFormatFileId = @Value

	if (@fieldname=N'fldDesc')
	begin
		
		SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc , 
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
                      
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId

		WHERE tblFileMojaz.fldDesc like  @Value
	end
	if (@fieldname=N'')
	SELECT        TOP (@h) tblFileMojaz.fldId, tblFileMojaz.fldArchiveTreeId,tblFileMojaz.fldFormatFileId, tblFileMojaz.fldDesc , 
                       tblFormatFile.fldFormatName,tblFormatFile.fldPassvand, tblArchiveTree.fldTitle
         
FROM           tblFileMojaz INNER JOIN
                         tblArchiveTree ON tblFileMojaz.fldArchiveTreeId = tblArchiveTree.fldId INNER JOIN
                        tblFormatFile ON tblFileMojaz.fldFormatFileId = tblFormatFile.fldId

	COMMIT
GO
