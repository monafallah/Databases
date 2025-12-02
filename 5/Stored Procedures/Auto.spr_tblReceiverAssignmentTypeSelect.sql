SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReceiverAssignmentTypeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldID], [fldAssignmentID], [fldReceiverComisionID], [fldAssignmentStatusID], [fldAssignmentTypeID], [fldBoxID], [fldLetterReadDate], [fldShowTypeT_F], [fldDate], [fldUserID], [fldOrganId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblReceiverAssignmentType] 
	WHERE  fldId=@Value aND fldOrganId =@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldID], [fldAssignmentID], [fldReceiverComisionID], [fldAssignmentStatusID], [fldAssignmentTypeID], [fldBoxID], [fldLetterReadDate], [fldShowTypeT_F], [fldDate], [fldUserID], [fldOrganId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblReceiverAssignmentType] 
	WHERE  fldDesc like @Value  aND fldOrganId =@organId

	if (@FieldName='')
	SELECT top(@h) [fldID], [fldAssignmentID], [fldReceiverComisionID], [fldAssignmentStatusID], [fldAssignmentTypeID], [fldBoxID], [fldLetterReadDate], [fldShowTypeT_F], [fldDate], [fldUserID], [fldOrganId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblReceiverAssignmentType] 
	where   fldOrganId =@organId
	
	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldID], [fldAssignmentID], [fldReceiverComisionID], [fldAssignmentStatusID], [fldAssignmentTypeID], [fldBoxID], [fldLetterReadDate], [fldShowTypeT_F], [fldDate], [fldUserID], [fldOrganId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblReceiverAssignmentType] 
	where   fldOrganId =@organId
	
	COMMIT
GO
