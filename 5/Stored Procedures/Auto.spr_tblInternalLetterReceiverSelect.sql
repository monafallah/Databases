SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROC [Auto].[spr_tblInternalLetterReceiverSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin tran
    if(@h=0) set @h=2147483647
    set @Value=com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
	WHERE  tblInternalLetterReceiver.fldId like @Value  and tblInternalLetterReceiver.fldorganId=@organId
	
	if (@fieldname=N'fldLetterId')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
	WHERE     (tblInternalLetterReceiver.fldLetterId = @Value)and tblInternalLetterReceiver.fldorganId=@organId
	
	if (@fieldname=N'fldReceiverComisionId')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
		WHERE  tblInternalLetterReceiver.fldReceiverComisionId like @Value and tblInternalLetterReceiver.fldorganId=@organId
	
	if (@fieldname=N'fldAssignmentStatusId')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
		WHERE  tblInternalLetterReceiver.fldAssignmentStatusId like @Value and tblInternalLetterReceiver.fldorganId=@organId
	
	if (@fieldname=N'fldAssignmentStatusName')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
	WHERE    tblAssignmentStatus.fldName  like @Value  and tblInternalLetterReceiver.fldorganId=@organId
	
	
		if (@fieldname=N'fldDesc')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
	WHERE  tblInternalLetterReceiver.fldDesc like @Value and tblInternalLetterReceiver.fldorganId=@organId
	
	

    if (@fieldname=N'')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
						  and tblInternalLetterReceiver.fldorganId=@organId


   if (@fieldname=N'fldOrganId')
	SELECT     tblInternalLetterReceiver.fldId, tblInternalLetterReceiver.fldLetterId, tblInternalLetterReceiver.fldReceiverComisionId, isnull(tblInternalLetterReceiver.fldAssignmentStatusId,0) as fldAssignmentStatusId, 
						  tblAssignmentStatus.fldName AS fldAssignmentStatusName, tblInternalLetterReceiver.fldDate, tblInternalLetterReceiver.fldUserId, 
						  tblInternalLetterReceiver.fldDesc,tblInternalLetterReceiver.fldMessageId,tblInternalLetterReceiver.fldOrganId,tblInternalLetterReceiver.fldIP
						
	FROM         tblInternalLetterReceiver INNER JOIN
						  tblLetter ON tblInternalLetterReceiver.fldLetterId = tblLetter.fldId INNER JOIN
						  tblCommision ON tblInternalLetterReceiver.fldReceiverComisionId = tblCommision.fldId LEFT OUTER JOIN
						  tblAssignmentStatus ON tblInternalLetterReceiver.fldAssignmentStatusId = tblAssignmentStatus.fldId
						where    tblInternalLetterReceiver.fldorganId=@organId

commit

GO
