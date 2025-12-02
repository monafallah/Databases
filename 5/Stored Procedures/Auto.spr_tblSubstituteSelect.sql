SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblSubstituteSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S, Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId
	WHERE  Auto.tblSubstitute.fldId = @Value AND Auto.tblSubstitute.fldOrganId=@fldOrganId

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId
	WHERE Auto.tblSubstitute.fldDesc like  @Value AND Auto.tblSubstitute.fldOrganId=@fldOrganId
	

	if (@fieldname=N'fldSenderComisionID')
	begin
	declare @tarikh varchar(10)=dbo.Fn_AssembelyMiladiToShamsi(getdate())
	SELECT     TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId
	WHERE Auto.tblSubstitute.fldSenderComisionID like  @Value AND Auto.tblSubstitute.fldOrganId=@fldOrganId
	and @tarikh between Auto.tblSubstitute.fldStartDate and Auto.tblSubstitute.fldEndDate
	end

	if (@fieldname=N'fldReceiverComisionID')
	begin
	declare @tarikh1 varchar(10)=dbo.Fn_AssembelyMiladiToShamsi(getdate())
	SELECT     TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId
	WHERE Auto.tblSubstitute.fldReceiverComisionID like  @Value AND Auto.tblSubstitute.fldOrganId=@fldOrganId
	and tblSubstitute.fldEndDate>=@tarikh1
	end

	if (@fieldname=N'')
	SELECT     TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                     Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S , Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId 





if (@fieldname=N'fldSenderComisionName')
	SELECT * FROM (select     TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId)t
	WHERE t.fldSenderComisionName like  @Value AND t.fldOrganId=@fldOrganId




if (@fieldname=N'fldReciverComisionName')
	SELECT   * FROM ( SELECT   TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId)t
	WHERE t.fldReciverComisionName like  @Value AND t.fldOrganId=@fldOrganId
	
	
	
	
if (@fieldname=N'fldStartDate')
	 SELECT   TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId
	WHERE Auto.tblSubstitute.fldStartDate like  @Value AND Auto.tblSubstitute.fldOrganId=@fldOrganId	
	
	
	






if (@fieldname=N'fldEndDate')
	SELECT      TOP (@h) Auto.tblSubstitute.fldID, Auto.tblSubstitute.fldSenderComisionID, Auto.tblSubstitute.fldReceiverComisionID, Auto.tblSubstitute.fldStartDate, 
                      Auto.tblSubstitute.fldEndDate, Auto.tblSubstitute.fldStartTime,CAST(Auto.tblSubstitute.fldStartTime AS CHAR(8)) AS fldStartTime_S, Auto.tblSubstitute.fldEndTime,CAST(Auto.tblSubstitute.fldEndTime AS CHAR(8)) AS fldEndTime_S,Auto.tblSubstitute.fldIsSigner, Auto.tblSubstitute.fldShowReceiverName, 
                      Auto.tblSubstitute.fldDate, Auto.tblSubstitute.fldUserID, Auto.tblSubstitute.fldDesc, Auto.tblSubstitute.fldIP, Auto.tblSubstitute.fldOrganId, Com.tblEmployee.fldName+' '+ 
                      Com.tblEmployee.fldFamily AS fldReciverComisionName, tblEmployee_1.fldName +' '+ tblEmployee_1.fldFamily AS fldSenderComisionName
FROM         Auto.tblSubstitute INNER JOIN
                      Auto.tblCommision ON Auto.tblSubstitute.fldReceiverComisionID = Auto.tblCommision.fldID INNER JOIN
                      Com.tblAshkhas ON Auto.tblCommision.fldAshkhasID = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId AND Com.tblAshkhas.fldHaghighiId = Com.tblEmployee.fldId INNER JOIN
                      Auto.tblCommision AS tblCommision_1 ON Auto.tblSubstitute.fldSenderComisionID = tblCommision_1.fldID INNER JOIN
                      Com.tblAshkhas AS tblAshkhas_1 ON tblCommision_1.fldAshkhasID = tblAshkhas_1.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee_1 ON tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId AND tblAshkhas_1.fldHaghighiId = tblEmployee_1.fldId
	WHERE Auto.tblSubstitute.fldEndDate like  @Value AND Auto.tblSubstitute.fldOrganId=@fldOrganId		
	
	COMMIT
GO
