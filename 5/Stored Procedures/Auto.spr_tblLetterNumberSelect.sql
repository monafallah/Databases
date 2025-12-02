SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROC [Auto].[spr_tblLetterNumberSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin
  if(@h=0) set @h=2147483647
  set @Value=com.fn_TextNormalizeSelect(@Value)
  if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblLetterNumber.fldId, tblLetterNumber.fldLetterId, tblLetterNumber.fldNumber,(tblLetterNumber.fldDate) AS fldDate, tblLetterNumber.fldUserId, tblLetterNumber.fldDesc, 
                     tblLetterNumber.fldOrganId ,tblLetterNumber.fldIP
	FROM         tblLetterNumber INNER JOIN
                      tblLetter ON tblLetterNumber.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterNumber.fldID like @Value and tblLetterNumber.fldOrganId=@organId
	
 if (@fieldname=N'fldLetterId')
	SELECT     TOP (@h) tblLetterNumber.fldId, tblLetterNumber.fldLetterId, tblLetterNumber.fldNumber,(tblLetterNumber.fldDate) AS fldDate, tblLetterNumber.fldUserId, tblLetterNumber.fldDesc, 
                     tblLetterNumber.fldOrganId ,tblLetterNumber.fldIP
	FROM         tblLetterNumber INNER JOIN
                      tblLetter ON tblLetterNumber.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterNumber.fldLetterID like @Value  and tblLetterNumber.fldOrganId=@organId
	
	if (@fieldname=N'fldNumber')
	SELECT     TOP (@h) tblLetterNumber.fldId, tblLetterNumber.fldLetterId, tblLetterNumber.fldNumber,(tblLetterNumber.fldDate) AS fldDate, tblLetterNumber.fldUserId, tblLetterNumber.fldDesc, 
                     tblLetterNumber.fldOrganId ,tblLetterNumber.fldIP
	FROM         tblLetterNumber INNER JOIN
                      tblLetter ON tblLetterNumber.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterNumber.fldNumber like @Value  and tblLetterNumber.fldOrganId=@organId
	
	
	
	if (@fieldname=N'fldDesc')
		SELECT     TOP (@h) tblLetterNumber.fldId, tblLetterNumber.fldLetterId, tblLetterNumber.fldNumber,(tblLetterNumber.fldDate) AS fldDate, tblLetterNumber.fldUserId, tblLetterNumber.fldDesc, 
                     tblLetterNumber.fldOrganId ,tblLetterNumber.fldIP
	FROM         tblLetterNumber INNER JOIN
                      tblLetter ON tblLetterNumber.fldLetterID = tblLetter.fldID 
	WHERE tblLetterNumber.fldDesc like @Value   and tblLetterNumber.fldOrganId=@organId
	
	 if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblLetterNumber.fldId, tblLetterNumber.fldLetterId, tblLetterNumber.fldNumber,(tblLetterNumber.fldDate) AS fldDate, tblLetterNumber.fldUserId, tblLetterNumber.fldDesc, 
                     tblLetterNumber.fldOrganId ,tblLetterNumber.fldIP
	FROM         tblLetterNumber INNER JOIN
                      tblLetter ON tblLetterNumber.fldLetterID = tblLetter.fldID 
					  where   tblLetterNumber.fldOrganId=@organId
	 
  if (@fieldname=N'')
	SELECT     TOP (@h) tblLetterNumber.fldId, tblLetterNumber.fldLetterId, tblLetterNumber.fldNumber,(tblLetterNumber.fldDate) AS fldDate, tblLetterNumber.fldUserId, tblLetterNumber.fldDesc, 
                     tblLetterNumber.fldOrganId ,tblLetterNumber.fldIP
	FROM         tblLetterNumber INNER JOIN
                      tblLetter ON tblLetterNumber.fldLetterID = tblLetter.fldID 
					  where   tblLetterNumber.fldOrganId=@organId
End

GO
