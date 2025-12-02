SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_SelectUserByUserId]
@fieldname nvarchar(50),
@Value nvarchar(50),
@UserId INT,
@h INT
AS
BEGIN TRAN
--DECLARE @UserId int=1
DECLARE @From int,@To int
DECLARE @temp TABLE(Id INT,UserId int)
if (@h=0) set @h=2147483647
INSERT INTO @temp
	SELECT * FROM Com.fn_GetUserByUserId(@UserId)
DECLARE c CURSOR FOR
SELECT * FROM @temp
WHERE id<>UserId
OPEN c
DECLARE @Id int, @fldUserId INT
FETCH NEXT FROM c INTO @Id,@fldUserId
WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO @temp
	SELECT * FROM Com.fn_GetUserByUserId(@Id)
	FETCH NEXT FROM c INTO @Id,@fldUserId
END
CLOSE c
DEALLOCATE c

if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblUser.fldId, tblUser.fldEmployId, tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, /*tblUser.fldOrganId,*/ tblUser.fldUserId, 
                      tblUser.fldDesc, tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName,/*[Com].[fn_stringDecode](tblOrganization.fldName) AS fldNameOrgan,*/ 
                      tblEmployee.fldName +' '+ tblEmployee.fldFamily AS fldNameEmployee,fldCodemeli
	FROM         tblUser INNER JOIN
                      tblEmployee ON tblUser.fldEmployId = tblEmployee.fldId 
	WHERE  ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserId=@UserId )>0 OR tblUser.fldUserId=@UserId  or tblUser.fldId IN (SELECT Id FROM @temp))AND tblUser.fldId like @Value

if (@fieldname=N'fldUserName')
	SELECT     TOP (@h) tblUser.fldId, tblUser.fldEmployId, tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, /*tblUser.fldOrganId,*/ tblUser.fldUserId, 
                      tblUser.fldDesc, tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName,/*[Com].[fn_stringDecode](tblOrganization.fldName) AS fldNameOrgan,*/ 
                      tblEmployee.fldName +' '+ tblEmployee.fldFamily AS fldNameEmployee,fldCodemeli
	FROM         tblUser INNER JOIN
                      tblEmployee ON tblUser.fldEmployId = tblEmployee.fldId 
	WHERE  ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserId=@UserId )>0 OR tblUser.fldUserId=@UserId  or tblUser.fldId IN (SELECT Id FROM @temp)) AND tblUser.fldUserName like @Value
	
	if (@fieldname=N'fldCodemeli')
	SELECT     TOP (@h) tblUser.fldId, tblUser.fldEmployId, tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, /*tblUser.fldOrganId,*/ tblUser.fldUserId, 
                      tblUser.fldDesc, tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName,/*[Com].[fn_stringDecode](tblOrganization.fldName) AS fldNameOrgan,*/ 
                      tblEmployee.fldName +' '+ tblEmployee.fldFamily AS fldNameEmployee,fldCodemeli
	FROM         tblUser INNER JOIN
                      tblEmployee ON tblUser.fldEmployId = tblEmployee.fldId 
	WHERE ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserId=@UserId )>0 OR tblUser.fldUserId=@UserId  or tblUser.fldId IN (SELECT Id FROM @temp))AND fldCodemeli like @Value

if (@fieldname=N'fldNameEmployee')
	SELECT * FROM (	SELECT     TOP (@h) tblUser.fldId, tblUser.fldEmployId, tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, /*tblUser.fldOrganId,*/ tblUser.fldUserId, 
                      tblUser.fldDesc, tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName,/*[Com].[fn_stringDecode](tblOrganization.fldName) AS fldNameOrgan,*/ 
                      tblEmployee.fldName +' '+ tblEmployee.fldFamily AS fldNameEmployee,fldCodemeli
	FROM         tblUser INNER JOIN
                      tblEmployee ON tblUser.fldEmployId = tblEmployee.fldId 
                      WHERE ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserId=@UserId )>0 OR tblUser.fldUserId=@UserId  or tblUser.fldId IN (SELECT Id FROM @temp)))temp
	WHERE temp.fldId IN (SELECT Id FROM @temp) AND fldNameEmployee LIKE @Value 

if (@fieldname=N'fldActive_DeactiveName')
	SELECT * FROM (		SELECT     TOP (@h) tblUser.fldId, tblUser.fldEmployId, tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, /*tblUser.fldOrganId,*/ tblUser.fldUserId, 
                      tblUser.fldDesc, tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName,/*[Com].[fn_stringDecode](tblOrganization.fldName) AS fldNameOrgan,*/ 
                      tblEmployee.fldName +' '+ tblEmployee.fldFamily AS fldNameEmployee,fldCodemeli
	FROM         tblUser INNER JOIN
                      tblEmployee ON tblUser.fldEmployId = tblEmployee.fldId 
                    where  ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserId=@UserId )>0 OR tblUser.fldUserId=@UserId  or tblUser.fldId IN (SELECT Id FROM @temp)))temp
	WHERE  fldActive_DeactiveName LIKE @Value


if (@fieldname=N'')
	SELECT     TOP (@h) tblUser.fldId, tblUser.fldEmployId, tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, /*tblUser.fldOrganId,*/ tblUser.fldUserId, 
                      tblUser.fldDesc, tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName,/*[Com].[fn_stringDecode](tblOrganization.fldName) AS fldNameOrgan,*/ 
                      tblEmployee.fldName +' '+ tblEmployee.fldFamily AS fldNameEmployee,fldCodemeli
	FROM         tblUser INNER JOIN
                      tblEmployee ON tblUser.fldEmployId = tblEmployee.fldId 
	WHERE  ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserId=@UserId )>0 OR tblUser.fldUserId=@UserId  or tblUser.fldId IN (SELECT Id FROM @temp))

COMMIT TRAN
GO
