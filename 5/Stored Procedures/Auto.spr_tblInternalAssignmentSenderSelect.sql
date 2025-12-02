SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblInternalAssignmentSenderSelect] 
    @fieldname as nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h as int
AS 
begin tran
    if(@h=0) set @h=2147483647
    set @Value= com.fn_TextNormalizeSelect(@Value)
    if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
	WHERE  tblInternalAssignmentSender.fldId like @Value  and tblInternalAssignmentSender.fldorganid =@organId
	
	if (@fieldname=N'fldAssignmentID')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
	WHERE  tblInternalAssignmentSender.fldAssignmentID like @Value  and tblInternalAssignmentSender.fldorganid =@organId
	
	if (@fieldname=N'fldSenderComisionID')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
	WHERE  tblInternalAssignmentSender.fldSenderComisionID like @Value  and tblInternalAssignmentSender.fldorganid =@organId
	
	if (@fieldname=N'fldBoxID')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId 
	WHERE  tblInternalAssignmentSender.fldBoxID like @Value  and tblInternalAssignmentSender.fldorganid =@organId
	
	if (@fieldname=N'fldNameBox')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
	WHERE  tblBox.fldName like @Value  and tblInternalAssignmentSender.fldorganid =@organId
	
	if (@fieldname=N'fldDate')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
	WHERE  (tblInternalAssignmentSender.fldDate) like @Value
	 and tblInternalAssignmentSender.fldorganid =@organId
	

	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
	WHERE  tblInternalAssignmentSender.fldDesc like @Value  	 and tblInternalAssignmentSender.fldorganid =@organId
	
	
		
    if (@fieldname=N'')
SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					 where 	  tblInternalAssignmentSender.fldorganid =@organId



		
    if (@fieldname=N'fldOrganId')
SELECT     TOP (@h) tblInternalAssignmentSender.fldId, tblInternalAssignmentSender.fldAssignmentID, tblInternalAssignmentSender.fldSenderComisionID, 
                      tblInternalAssignmentSender.fldBoxID, tblBox.fldName AS fldNameBox, tblInternalAssignmentSender.fldDate, 
                      tblInternalAssignmentSender.fldUserId, tblInternalAssignmentSender.fldDesc,
                      tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName_Family,tblInternalAssignmentSender.fldOrganId
					  ,tblInternalAssignmentSender.fldIP
	FROM         tblInternalAssignmentSender INNER JOIN
                      tblAssignment ON tblInternalAssignmentSender.fldAssignmentID = tblAssignment.fldId INNER JOIN
                      tblCommision ON tblInternalAssignmentSender.fldSenderComisionID = tblCommision.fldId INNER JOIN
                      tblBox ON tblInternalAssignmentSender.fldBoxID = tblBox.fldId INNER JOIN
                     com.tblAshkhas on fldashkhasId=tblAshkhas.fldId
					 inner join com.tblEmployee on fldHaghighiId=tblEmployee.fldId
					 where 	  tblInternalAssignmentSender.fldorganid =@organId
 commit

GO
