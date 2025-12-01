SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblInputInfoSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@LoginType BIT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	SET @Value2=dbo.fn_TextNormalize(@Value2)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	
			SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
								  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
				WHERE  tblInputInfo.fldId = @Value

	
	
	
	
	
	if (@fieldname=N'fldUserId')

			SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
								 					  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
				WHERE  tblInputInfo.fldUserId = @Value AND fldLoginType=@LoginType

	ORDER BY dbo.tblInputInfo.fldId DESC

	
	
	
	
	
	if (@fieldname=N'fldUserId_log')

			SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
													  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
			  	WHERE  tblInputInfo.fldUserID = @Value

	ORDER BY dbo.tblInputInfo.fldId DESC
	
	
	
	
	
	
		if (@fieldname=N'fldLoginTypeName')

	SELECT    TOP (@h) * FROM (SELECT    tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
													  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId)temp
				WHERE  temp.fldLoginTypeName like @Value

	ORDER BY fldId DESC
			
			
			
	
	if (@fieldname=N'fldDateTime')

SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
								 					  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
				WHERE  fldDateTime LIKE @Value
	ORDER BY fldId DESC
		
	
	if (@fieldname=N'FirstLogin')
	
	
	SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
													  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
				  WHERE tblInputInfo.fldUserID=@Value 				   

	if (@fieldname=N'')
	
	
	SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
													  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
				WHERE  tblInputInfo.fldId = @Value
	
		
	
	
	if (@fieldname=N'CheckUser')
	
	SELECT     TOP (@h) tblInputInfo.fldId,dbo.MiladiTOShamsi(tblInputInfo.fldDateTime) AS fldTarikh, CAST(CAST(tblInputInfo.fldDateTime AS TIME(0))AS NVARCHAR(8)) AS fldTime, tblInputInfo.fldIP, 
								  tblInputInfo.fldMACAddress, tblInputInfo.fldLoginType, tblInputInfo.fldUserID, tblInputInfo.fldDesc,dbo.tblInputInfo.fldBrowserType,dbo.tblInputInfo.fldKey,dbo.tblInputInfo.fldAppType , 
								 case when fldusersecondid<>tblInputInfo.fldUserID then  dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily + N' در نقش'+shakhs.fldName+' '+shakhs.fldFamily
								 else dbo.tblAshkhas.fldName+' '+  dbo.tblAshkhas.fldFamily end AS Name_Family
								 					  ,CASE WHEN fldLoginType=1 then N'ورود' WHEN fldLoginType=2 then N'خروج با  session' ELSE N'خروج  با دکمه'  END AS fldLoginTypeName,fldDateTime,
			fldUserSecondId
			FROM         tblInputInfo INNER JOIN
								  tblUser ON tblInputInfo.fldUserID = tblUser.fldId INNER JOIN
								   dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId inner join 
								   tbluser as user1 on fldusersecondid=user1.fldid inner join
								   tblAshkhas as shakhs on shakhs.fldid=user1.fldShakhsId
				WHERE  tblInputInfo.fldKey = @Value AND tblInputInfo.fldIp = @Value2

	COMMIT
GO
