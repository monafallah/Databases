SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblHistoryLetterSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as INT
	
AS 
BEGIN
       if(@h=0) set @h=2147483647
       if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblHistoryLetter.fldId, tblHistoryLetter.fldCurrentLetter_Id, tblHistoryLetter.fldHistoryType_Id, tblHistoryLetter.fldHistoryLetter_Id, tblHistoryLetter.fldDate, 
                      tblHistoryLetter.fldUserId, tblHistoryLetter.fldDesc, tblLetter.fldSubject, tblLetter.fldLetterNumber, tblLetter.fldID AS fldCreatedLetterId, 
                     fldLetterDate, tblLetter.fldComisionID, tblHistoryType.fldName AS fldHistoryTypeName,tblHistoryLetter.fldOrganId,tblHistoryLetter.fldIP
	FROM         tblHistoryLetter INNER JOIN
                      tblHistoryType ON tblHistoryLetter.fldHistoryType_Id = tblHistoryType.fldID INNER JOIN
                      tblLetter ON tblHistoryLetter.fldHistoryLetter_Id = tblLetter.fldID 
       where tblHistoryLetter.fldId like @Value and tblHistoryLetter.fldOrganId =@organId
       
       if (@fieldname=N'fldCurrentLetter_Id')
	SELECT     TOP (@h) tblHistoryLetter.fldId, tblHistoryLetter.fldCurrentLetter_Id, tblHistoryLetter.fldHistoryType_Id, tblHistoryLetter.fldHistoryLetter_Id, tblHistoryLetter.fldDate, 
                      tblHistoryLetter.fldUserId, tblHistoryLetter.fldDesc, tblLetter.fldSubject, tblLetter.fldLetterNumber, tblLetter.fldID AS fldCreatedLetterId, 
                     fldLetterDate, tblLetter.fldComisionID, tblHistoryType.fldName AS fldHistoryTypeName,tblHistoryLetter.fldOrganId,tblHistoryLetter.fldIP
	FROM         tblHistoryLetter INNER JOIN
                      tblHistoryType ON tblHistoryLetter.fldHistoryType_Id = tblHistoryType.fldID INNER JOIN
                      tblLetter ON tblHistoryLetter.fldHistoryLetter_Id = tblLetter.fldID 
       where tblHistoryLetter.fldCurrentLetter_Id like @Value  and tblHistoryLetter.fldOrganId =@organId
       
       if (@fieldname=N'fldLetterId')
	SELECT     TOP (@h) tblHistoryLetter.fldId, tblHistoryLetter.fldCurrentLetter_Id, tblHistoryLetter.fldHistoryType_Id, tblHistoryLetter.fldHistoryLetter_Id, tblHistoryLetter.fldDate, 
                      tblHistoryLetter.fldUserId, tblHistoryLetter.fldDesc, tblLetter.fldSubject, tblLetter.fldLetterNumber, tblLetter.fldID AS fldCreatedLetterId, 
                     fldLetterDate, tblLetter.fldComisionID, tblHistoryType.fldName AS fldHistoryTypeName,tblHistoryLetter.fldOrganId,tblHistoryLetter.fldIP
	FROM         tblHistoryLetter INNER JOIN
                      tblHistoryType ON tblHistoryLetter.fldHistoryType_Id = tblHistoryType.fldID INNER JOIN
                      tblLetter ON tblHistoryLetter.fldHistoryLetter_Id = tblLetter.fldID 
       where tblLetter.fldID like @Value  and tblHistoryLetter.fldOrganId =@organId
       
       if (@fieldname=N'fldHistoryLetter_Id')
	SELECT     TOP (@h) tblHistoryLetter.fldId, tblHistoryLetter.fldCurrentLetter_Id, tblHistoryLetter.fldHistoryType_Id, tblHistoryLetter.fldHistoryLetter_Id, tblHistoryLetter.fldDate, 
                      tblHistoryLetter.fldUserId, tblHistoryLetter.fldDesc, tblLetter.fldSubject, tblLetter.fldLetterNumber, tblLetter.fldID AS fldCreatedLetterId, 
                     fldLetterDate, tblLetter.fldComisionID, tblHistoryType.fldName AS fldHistoryTypeName,tblHistoryLetter.fldOrganId,tblHistoryLetter.fldIP
	FROM         tblHistoryLetter INNER JOIN
                      tblHistoryType ON tblHistoryLetter.fldHistoryType_Id = tblHistoryType.fldID INNER JOIN
                      tblLetter ON tblHistoryLetter.fldHistoryLetter_Id = tblLetter.fldID 
       where tblHistoryLetter.fldHistoryLetter_Id like @Value  and tblHistoryLetter.fldOrganId =@organId
   
       if (@fieldname=N'')
	SELECT     TOP (@h) tblHistoryLetter.fldId, tblHistoryLetter.fldCurrentLetter_Id, tblHistoryLetter.fldHistoryType_Id, tblHistoryLetter.fldHistoryLetter_Id, tblHistoryLetter.fldDate, 
                      tblHistoryLetter.fldUserId, tblHistoryLetter.fldDesc, tblLetter.fldSubject, tblLetter.fldLetterNumber, tblLetter.fldID AS fldCreatedLetterId, 
                     fldLetterDate, tblLetter.fldComisionID, tblHistoryType.fldName AS fldHistoryTypeName,tblHistoryLetter.fldOrganId,tblHistoryLetter.fldIP
	FROM         tblHistoryLetter INNER JOIN
                      tblHistoryType ON tblHistoryLetter.fldHistoryType_Id = tblHistoryType.fldID INNER JOIN
                      tblLetter ON tblHistoryLetter.fldHistoryLetter_Id = tblLetter.fldID 
					  where  tblHistoryLetter.fldOrganId =@organId
    if (@fieldname=N'tblHistoryLetter.fldOrganId')
	SELECT     TOP (@h) tblHistoryLetter.fldId, tblHistoryLetter.fldCurrentLetter_Id, tblHistoryLetter.fldHistoryType_Id, tblHistoryLetter.fldHistoryLetter_Id, tblHistoryLetter.fldDate, 
                      tblHistoryLetter.fldUserId, tblHistoryLetter.fldDesc, tblLetter.fldSubject, tblLetter.fldLetterNumber, tblLetter.fldID AS fldCreatedLetterId, 
                     fldLetterDate, tblLetter.fldComisionID, tblHistoryType.fldName AS fldHistoryTypeName,tblHistoryLetter.fldOrganId,tblHistoryLetter.fldIP
	FROM         tblHistoryLetter INNER JOIN
                      tblHistoryType ON tblHistoryLetter.fldHistoryType_Id = tblHistoryType.fldID INNER JOIN
                      tblLetter ON tblHistoryLetter.fldHistoryLetter_Id = tblLetter.fldID 
					  where  tblHistoryLetter.fldOrganId =@organId

END

GO
