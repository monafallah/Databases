SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterBoxSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value=com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
	WHERE  tblLetterBox.fldID like @Value and tblLetterBox.fldOrganId =@OrganId
	
	if (@fieldname=N'fldLetterId')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
	WHERE  tblLetterBox.fldLetterId like @Value and tblLetterBox.fldOrganId =@OrganId

		if (@fieldname=N'fldMessageId')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
	WHERE  tblLetterBox.fldMessageId like @Value and tblLetterBox.fldOrganId =@OrganId
	
	if (@fieldname=N'fldBoxId')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
	WHERE  tblLetterBox.fldBoxID like @Value and tblLetterBox.fldOrganId =@OrganId
	
	
	if (@fieldname=N'fldBoxName')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
	WHERE  tblBox.fldName like @Value and tblLetterBox.fldOrganId =@OrganId
	
	
	
	
	
	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
	WHERE  tblLetterBox.fldDesc like @Value and tblLetterBox.fldOrganId =@OrganId
	
	
	    if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
					  where  tblLetterBox.fldOrganId =@OrganId

    if (@fieldname=N'')
	SELECT     TOP (@h) tblLetterBox.fldId, tblLetterBox.fldLetterId,fldMessageId, tblLetterBox.fldBoxId, tblBox.fldName AS fldBoxName,(tblLetterBox.fldDate) AS fldDate, tblLetterBox.fldUserId, tblLetterBox.fldDesc, 
                    m.fldTitle as fldTitleMessage,tblLetterBox.fldOrganId,tblLetterBox.fldIP
	FROM         tblLetterBox INNER JOIN
                      tblBox ON tblLetterBox.fldBoxID = tblBox.fldID 
					  outer apply (select fldtitle from auto.tblmessage where fldid =fldMessageId) m
					  where  tblLetterBox.fldOrganId =@OrganId
End

GO
