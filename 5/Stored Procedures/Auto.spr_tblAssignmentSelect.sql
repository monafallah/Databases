SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Auto].[spr_tblAssignmentSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin
    if(@h=0) set @h=2147483647
    set @Value= com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  tblAssignment.fldID like @Value and fldOrganId=@organId


	 if (@fieldname=N'fldMessageId')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  fldMessageId like @Value and fldOrganId=@organId

	
	 if (@fieldname=N'fldTitleMessage')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  tblMessage.fldTitle like @Value and fldOrganId=@organId
	
	
	if (@fieldname=N'fldLetterID')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  tblAssignment.fldLetterID like @Value and fldOrganId=@organId
	
	if (@fieldname=N'fldSubject')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  fldSubject like @Value and fldOrganId=@organId

	
	if (@fieldname=N'fldAssignmentDate')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  (tblAssignment.fldAssignmentDate) like @Value and fldOrganId=@organId
	
	
	if (@fieldname=N'fldAnswerDate')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  ( tblAssignment.fldAnswerDate) like @Value and fldOrganId=@organId
	
	
	
	if (@fieldname=N'fldUserID')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  tblAssignment.fldUserID like @Value and fldOrganId=@organId
	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	WHERE  fldDesc like @Value  and fldOrganId=@organId
	
	
	


    if (@fieldname=N'')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	where  fldOrganId=@organId

	
    if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblAssignment.fldID, tblAssignment.fldLetterID,fldMessageId ,  fldAssignmentDate, 
                       fldAnswerDate, fldDate, tblAssignment.fldUserID, 
                      tblAssignment.fldDesc,fldOrganId ,fldIP,
                      tblAssignment.fldSourceAssId,fldSubject,tblMessage.fldTitle as fldTitleMessage
	FROM         tblAssignment 
	outer apply (select fldSubject from Auto.tblLetter where fldid=fldLetterID)Letter
	outer apply (select fldTitle from Auto.tblMessage where fldid=fldMessageId)tblMessage
	where  fldOrganId=@organId
End

GO
