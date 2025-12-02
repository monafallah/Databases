SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblInternalAssignmentReceiverSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin tran
    if(@h=0) set @h=2147483647
    set @Value= com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                     ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle +')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
                       
	WHERE  tblInternalAssignmentReceiver.fldID like @Value and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldAssignmentID')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                     ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblInternalAssignmentReceiver.fldAssignmentID like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldReceiverComisionID')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblInternalAssignmentReceiver.fldReceiverComisionID like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldAssignmentStatusID')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                     ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblInternalAssignmentReceiver.fldAssignmentStatusID like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldStatusName')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE   tblAssignmentStatus.fldName like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldAssignmentTypeID')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblInternalAssignmentReceiver.fldAssignmentTypeID like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldTypeAssignment')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblAssignmentType.fldType like @Value   and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldBoxID')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblInternalAssignmentReceiver.fldBoxID like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldBoxName')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')'as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE   tblBox.fldName like @Value   and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldLetterReadDate')
SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  (tblInternalAssignmentReceiver.fldLetterReadDate) like @Value
	 and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	if (@fieldname=N'fldShowTypeT_F')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					  inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  fldShowTypeT_F like @Value  and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	
	
	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                     ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					    inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
	WHERE  tblInternalAssignmentReceiver.fldDesc like @Value   and  tblInternalAssignmentReceiver.fldOrganId=@organId
	
	
    if (@fieldname=N'')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                     ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					    inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					   where  tblInternalAssignmentReceiver. fldOrganId=@organId

 if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblInternalAssignmentReceiver.fldID, tblInternalAssignmentReceiver.fldAssignmentID, tblInternalAssignmentReceiver.fldReceiverComisionID, 
                      tblInternalAssignmentReceiver.fldAssignmentStatusID, tblAssignmentStatus.fldName AS fldStatusName, 
                      tblInternalAssignmentReceiver.fldAssignmentTypeID, tblAssignmentType.fldType AS fldTypeAssignment, tblInternalAssignmentReceiver.fldBoxID, 
                      tblBox.fldName AS fldBoxName,  fldLetterReadDate, 
                      tblInternalAssignmentReceiver.fldShowTypeT_F, tblInternalAssignmentReceiver.fldUserID, 
                      tblInternalAssignmentReceiver.fldDesc,tblInternalAssignmentReceiver.fldDate
                      ,tblEmployee.fldName COLLATE Latin1_General_CS_AS+' ' +fldFamily COLLATE Latin1_General_CS_AS +'('+o.fldTitle+')' as fldName_Family,tblInternalAssignmentReceiver.fldOrganId,tblInternalAssignmentReceiver.fldIP
	FROM         tblInternalAssignmentReceiver INNER JOIN
                      tblAssignment ON tblInternalAssignmentReceiver.fldAssignmentID = tblAssignment.fldID INNER JOIN
                      tblAssignmentStatus ON tblInternalAssignmentReceiver.fldAssignmentStatusID = tblAssignmentStatus.fldID INNER JOIN
                      tblAssignmentType ON tblInternalAssignmentReceiver.fldAssignmentTypeID = tblAssignmentType.fldID INNER JOIN
                      tblCommision ON tblInternalAssignmentReceiver.fldReceiverComisionID = tblCommision.fldID INNER JOIN
                      tblBox ON tblInternalAssignmentReceiver.fldBoxID = tblBox.fldID inner join 
					  com.tblAshkhas  on tblCommision.fldAshkhasId =tblAshkhas.fldid
					  inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					    inner join com.tblOrganizationalPostsEjraee o on o.fldid=fldOrganizPostEjraeeID
					   where  tblInternalAssignmentReceiver. fldOrganId=@organId
commit

GO
