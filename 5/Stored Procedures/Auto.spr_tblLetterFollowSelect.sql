SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROC [Auto].[spr_tblLetterFollowSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value=com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblLetterFollow.fldId, tblLetterFollow.fldLetterText, tblLetterFollow.fldLetterId,(tblLetterFollow.fldDate) AS fldDate, tblLetterFollow.fldUserId, tblLetterFollow.fldDesc, 
                    tblLetterFollow.fldOrganId,tblLetterFollow.fldIP
	FROM         tblLetterFollow INNER JOIN
                      tblLetter ON tblLetterFollow.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterFollow.fldID like @Value and  tblLetterFollow.fldOrganId=@OrganId

	if (@fieldname=N'fldLetterText')
	SELECT     TOP (@h) tblLetterFollow.fldId, tblLetterFollow.fldLetterText, tblLetterFollow.fldLetterId,(tblLetterFollow.fldDate) AS fldDate, tblLetterFollow.fldUserId, tblLetterFollow.fldDesc, 
                    tblLetterFollow.fldOrganId,tblLetterFollow.fldIP
	FROM         tblLetterFollow INNER JOIN
                      tblLetter ON tblLetterFollow.fldLetterID = tblLetter.fldID 
	WHERE  fldLetterText like @Value  and  tblLetterFollow.fldOrganId=@OrganId
	
	if (@fieldname=N'fldLetterId')
	SELECT     TOP (@h) tblLetterFollow.fldId, tblLetterFollow.fldLetterText, tblLetterFollow.fldLetterId,(tblLetterFollow.fldDate) AS fldDate, tblLetterFollow.fldUserId, tblLetterFollow.fldDesc, 
                   tblLetterFollow.fldOrganId,tblLetterFollow.fldIP
	FROM         tblLetterFollow INNER JOIN
                      tblLetter ON tblLetterFollow.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterFollow.fldLetterID like @Value and  tblLetterFollow.fldOrganId=@OrganId
	
	

	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblLetterFollow.fldId, tblLetterFollow.fldLetterText, tblLetterFollow.fldLetterId,(tblLetterFollow.fldDate) AS fldDate, tblLetterFollow.fldUserId, tblLetterFollow.fldDesc, 
                    tblLetterFollow.fldOrganId,tblLetterFollow.fldIP
	FROM         tblLetterFollow INNER JOIN
                      tblLetter ON tblLetterFollow.fldLetterID = tblLetter.fldID 
	WHERE  tblLetterFollow.fldDesc like @Value  and  tblLetterFollow.fldOrganId=@OrganId
	
    if (@fieldname=N'')
	SELECT     TOP (@h) tblLetterFollow.fldId, tblLetterFollow.fldLetterText, tblLetterFollow.fldLetterId,(tblLetterFollow.fldDate) AS fldDate, tblLetterFollow.fldUserId, tblLetterFollow.fldDesc, 
                    tblLetterFollow.fldOrganId,tblLetterFollow.fldIP
	FROM         tblLetterFollow INNER JOIN
                      tblLetter ON tblLetterFollow.fldLetterID = tblLetter.fldID 
					  where   tblLetterFollow.fldOrganId=@OrganId



    if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblLetterFollow.fldId, tblLetterFollow.fldLetterText, tblLetterFollow.fldLetterId,(tblLetterFollow.fldDate) AS fldDate, tblLetterFollow.fldUserId, tblLetterFollow.fldDesc, 
                     tblLetterFollow.fldOrganId,tblLetterFollow.fldIP
	FROM         tblLetterFollow INNER JOIN
                      tblLetter ON tblLetterFollow.fldLetterID = tblLetter.fldID 
					  where   tblLetterFollow.fldOrganId=@OrganId
End

GO
