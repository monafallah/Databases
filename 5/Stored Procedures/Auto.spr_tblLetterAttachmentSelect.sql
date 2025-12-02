SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblLetterAttachmentSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value=com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID 
	WHERE  tblLetterAttachment.fldID like @Value and tblLetterAttachment.fldOrganId=@organId
	
	if (@fieldname=N'fldLetterID')
	SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID 
	WHERE  tblLetterAttachment.fldLetterID like @Value and tblLetterAttachment.fldOrganId=@organId

	
	if (@fieldname=N'fldName')
SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID 
	WHERE  tblLetterAttachment.fldName like @Value and tblLetterAttachment.fldOrganId=@organId
	
	if (@fieldname=N'fldContentFileID')
	SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID 
	WHERE  tblLetterAttachment.fldContentFileID like @Value and tblLetterAttachment.fldOrganId=@organId
	
	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID 
	WHERE  tblLetterAttachment.fldDesc like @Value and tblLetterAttachment.fldOrganId=@organId
	
	if (@fieldname=N'')
SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID
					  where tblLetterAttachment.fldOrganId=@organId 

	if (@fieldname=N'fldOrganId')
SELECT     TOP (@h) tblLetterAttachment.fldID, tblLetterAttachment.fldLetterID  , tblLetterAttachment.fldName, tblLetterAttachment.fldContentFileID,(tblLetterAttachment.fldDate) AS fldDate, 
                      tblLetterAttachment.fldUserID, tblLetterAttachment.fldDesc,
                     tblContentFile.fldName as fldNameFile,tblLetterAttachment.fldOrganId ,tblLetterAttachment.fldIP
	FROM         tblLetterAttachment INNER JOIN
                      tblLetter ON tblLetterAttachment.fldLetterID = tblLetter.fldID INNER JOIN
                      tblContentFile ON tblLetterAttachment.fldContentFileID = tblContentFile.fldID
					  where tblLetterAttachment.fldOrganId=@organId 

End

GO
