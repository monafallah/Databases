SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblInputInfoSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@LoginType BIT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	BEGIN
				SELECT     TOP (@h) tblInputInfo.fldId, dbo.Fn_AssembelyMiladiToShamsi(tblInputInfo.fldDateTime) AS fldDateTime, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc, tblInputInfo.fldDate, 
								  Com.tblEmployee.fldName+' '+  Com.tblEmployee.fldFamily AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' ELSE N'خروج'  END AS fldLoginTypeName
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   Com.tblEmployee ON tblUser.fldEmployId =  Com.tblEmployee.fldId
				WHERE  tblInputInfo.fldId = @Value
				
	
	END
	
	if (@fieldname=N'fldUserId')

			SELECT     TOP (@h) tblInputInfo.fldId, dbo.Fn_AssembelyMiladiToShamsi(tblInputInfo.fldDateTime) AS fldDateTime, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc, tblInputInfo.fldDate, 
								  Com.tblEmployee.fldName+' '+  Com.tblEmployee.fldFamily AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' ELSE N'خروج'  END AS fldLoginTypeName
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   Com.tblEmployee ON tblUser.fldEmployId =  Com.tblEmployee.fldId
							WHERE  tblInputInfo.fldUserId = @Value AND fldLoginType=@LoginType
	ORDER BY com.tblInputInfo.fldId DESC

	
	
	if (@fieldname=N'fldUserId_log')

			SELECT     TOP (@h) tblInputInfo.fldId, dbo.Fn_AssembelyMiladiToShamsi(tblInputInfo.fldDateTime) AS fldDateTime, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc, tblInputInfo.fldDate, 
								  Com.tblEmployee.fldName+' '+  Com.tblEmployee.fldFamily AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' ELSE N'خروج'  END AS fldLoginTypeName
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   Com.tblEmployee ON tblUser.fldEmployId =  Com.tblEmployee.fldId
								  	WHERE  tblInputInfo.fldUserID = @Value
	ORDER BY com.tblInputInfo.fldId DESC
	
		if (@fieldname=N'fldLoginTypeName')

	SELECT     TOP (@h)* FROM(
			SELECT     tblInputInfo.fldId, dbo.Fn_AssembelyMiladiToShamsi(tblInputInfo.fldDateTime) AS fldDateTime, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc, tblInputInfo.fldDate, 
								  Com.tblEmployee.fldName+' '+  Com.tblEmployee.fldFamily AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' ELSE N'خروج'  END AS fldLoginTypeName
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   Com.tblEmployee ON tblUser.fldEmployId =  Com.tblEmployee.fldId)temp
				WHERE  fldLoginTypeName like @Value
	ORDER BY fldId DESC
			
	
			if (@fieldname=N'fldDateTime')

	SELECT     TOP (@h)* FROM(
			SELECT     TOP (@h) tblInputInfo.fldId, dbo.Fn_AssembelyMiladiToShamsi(tblInputInfo.fldDateTime) AS fldDateTime, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc, tblInputInfo.fldDate, 
								  Com.tblEmployee.fldName+' '+  Com.tblEmployee.fldFamily AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' ELSE N'خروج'  END AS fldLoginTypeName
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   Com.tblEmployee ON tblUser.fldEmployId =  Com.tblEmployee.fldId)temp
				WHERE  fldDateTime LIKE @Value
	ORDER BY fldId DESC
		


	if (@fieldname=N'')
	
	
			SELECT     TOP (@h) tblInputInfo.fldId, dbo.Fn_AssembelyMiladiToShamsi(tblInputInfo.fldDateTime) AS fldDateTime, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc, tblInputInfo.fldDate, 
								  Com.tblEmployee.fldName+' '+  Com.tblEmployee.fldFamily AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' ELSE N'خروج'  END AS fldLoginTypeName
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   Com.tblEmployee ON tblUser.fldEmployId =  Com.tblEmployee.fldId
	
		
	
	

	COMMIT
GO
