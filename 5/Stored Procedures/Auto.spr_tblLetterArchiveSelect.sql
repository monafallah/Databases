SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROC [Auto].[spr_tblLetterArchiveSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
     set @Value=com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterArchive.fldID like @Value and tblLetterArchive.fldOrganId=@OrganId


if (@fieldname=N'fldLetterID')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterArchive.fldLetterID = @Value and tblLetterArchive.fldOrganId=@OrganId


if (@fieldname=N'fldMessageId')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterArchive.fldMessageId = @Value and tblLetterArchive.fldOrganId=@OrganId
	
	
	if (@fieldname=N'fldArchiveID')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterArchive.fldArchiveID like @Value and tblLetterArchive.fldOrganId=@OrganId
	
	
	if (@fieldname=N'fldArchiveName')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
	WHERE tblArchive.fldName like @Value  and tblLetterArchive.fldOrganId=@OrganId
	

	
	
	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterArchive.fldDesc like @Value  and tblLetterArchive.fldOrganId=@OrganId
	


    if (@fieldname=N'')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
					  where  tblLetterArchive.fldOrganId=@OrganId

					      if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblLetterArchive.fldID, tblLetterArchive.fldLetterID,fldMessageId , tblLetterArchive.fldArchiveID,tblArchive.fldName AS fldArchiveName,
					(tblLetterArchive.fldDate) AS fldDate, tblLetterArchive.fldUserID, tblLetterArchive.fldDesc, tblLetterArchive.fldOrganId ,tblLetterArchive.fldIp
						 
	FROM         tblLetterArchive INNER JOIN
                      tblArchive ON tblLetterArchive.fldArchiveID = tblArchive.fldID INNER JOIN
                      tblLetter ON tblLetterArchive.fldLetterID = tblLetter.fldID 
					  where  tblLetterArchive.fldOrganId=@OrganId
End

GO
