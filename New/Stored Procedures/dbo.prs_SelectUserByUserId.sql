SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_SelectUserByUserId]
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


	SET @Value=dbo.fn_TextNormalize(@Value)
--INSERT INTO @temp
--	SELECT fldId,fldUserId FROM dbo.tblUser WHERE fldUserId=@UserId
--	SELECT @From=0,@To=@@ROWCOUNT

--WHILE @From<@To
--BEGIN
--	INSERT INTO @temp
--	SELECT fldId,fldUserId FROM dbo.tblUser WHERE fldUserId IN (SELECT Id FROM @temp WHERE id<>UserId) AND fldId NOT IN (SELECT Id FROM @temp WHERE id<>UserId)
--	SET @From=@From+1
--END
--SELECT * FROM @temp
INSERT INTO @temp
	SELECT * FROM dbo.fn_GetUserByUserId(@UserId)
DECLARE c CURSOR FOR
SELECT * FROM @temp
WHERE id<>UserId
OPEN c
DECLARE @Id int, @fldInputID INT
FETCH NEXT FROM c INTO @Id,@fldInputID
WHILE @@FETCH_STATUS=0
BEGIN
	INSERT INTO @temp
	SELECT * FROM dbo.fn_GetUserByUserId(@Id)
	FETCH NEXT FROM c INTO @Id,@fldInputID
END
CLOSE c
DEALLOCATE c

if (@fieldname=N'fldId')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType, (select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N' کاربر سامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE  tblUser.fldId IN (SELECT Id FROM @temp) AND tblUser.fldId like @Value 
	ORDER BY  fldFamily,fldName	


if (@fieldname=N'fldUserType')
SELECT * FROM (SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N' کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE  tblUser.fldId IN (SELECT Id FROM @temp))temp
	where temp.fldUserType like @Value
ORDER BY  fldFamily,fldName	


	if (@fieldname=N'fldType')
SELECT TOP(@h) * FROM (SELECT  tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N' کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE  tblUser.fldId IN (SELECT Id FROM @temp) )temp
	where temp.fldType = @Value
	ORDER BY  fldFamily,fldName	

		if (@fieldname=N'fldTypeName')
SELECT TOP(@h) * FROM (SELECT  tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N' کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE  tblUser.fldId IN (SELECT Id FROM @temp))temp
	where temp.fldTypeName like @Value
ORDER BY  fldFamily,fldName	

if (@fieldname=N'fldUserName')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
					  	WHERE  tblUser.fldId IN (SELECT Id FROM @temp) AND tblUser.fldUserName like @Value
					  	
			ORDER BY  fldFamily,fldName	
		  	
					  	
					  	


if (@fieldname=N'fldNamePersonal')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N' کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
 WHERE tblUser.fldId IN (SELECT Id FROM @temp) AND dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily LIKE @Value 
	
	ORDER BY  fldFamily,fldName	
	


if (@fieldname=N'fldName')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N' کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
 WHERE tblUser.fldId IN (SELECT Id FROM @temp) AND dbo.tblAshkhas.fldName LIKE @Value 
	
	ORDER BY  fldFamily,fldName	
	
	
	

if (@fieldname=N'fldFamily')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N' کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
 WHERE tblUser.fldId IN (SELECT Id FROM @temp) AND dbo.tblAshkhas.fldFamily LIKE @Value 
	
	ORDER BY  fldFamily,fldName	
	
	
	
	
	
	if (@fieldname=N'fldCodeMeli')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
					  	WHERE  tblUser.fldId IN (SELECT Id FROM @temp)  AND dbo.tblAshkhas.fldCodeMeli like @Value
				ORDER BY  fldFamily,fldName	
	  	

if (@fieldname=N'fldActive_DeactiveName')
	SELECT * FROM (SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp) )temp				  
					
	WHERE  fldActive_DeactiveName LIKE @Value
	ORDER BY  fldFamily,fldName	

if (@fieldname=N'Limitation')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp))temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'Limitation_fldId')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp)  and tblUser.fldId=@Value)temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'Limitation_fldCodeEnhesari')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp) and  fldCodeEnhesari like @Value)temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'Limitation_fldCodeMeli')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp) and  fldCodeMeli like @Value)temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'Limitation_fldUserName')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp) and tblUser.fldUserName like @Value)temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'Limitation_fldFatherName')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp)  and fldFatherName like @Value)temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'Limitation_fldNamePersonal')
	SELECT  TOP(@h) * FROM (SELECT tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp)  and  dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily like @Value)temp		
	WHERE  fldLimitationUser <>''
ORDER BY  fldFamily,fldName	

	if (@fieldname=N'fldLimitationUser')
	SELECT TOP(@h) * FROM (SELECT  tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp) )temp				  
					
	WHERE  fldLimitationUser like @Value
	ORDER BY  fldFamily,fldName	

	if (@fieldname=N'fldLimitationType')
	SELECT * FROM (SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
	WHERE tblUser.fldId IN (SELECT Id FROM @temp) )temp				  
					
	WHERE  fldLimitationType like @Value
ORDER BY  fldFamily,fldName	

if (@fieldname=N'')
SELECT TOP(@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,dbo.tblUser.fldFirstLogin,dbo.tblUser.fldShakhsId, tblUser.fldInputID, tblUser.fldDesc, 
                      tblUser.fldDate,dbo.tblUser.fldUserType,(select cast(tblUser_Station.fldStationId as varchar(10))+',' from tblUser_Station where tblUser_Station.fldUserId=tblUser.fldId for xml path(''))fldStationId
					  ,dbo.tblUser.fldUserId, CASE WHEN fldActive_Deactive = 1 THEN N'مجاز' ELSE N'غیرمجاز' END AS fldActive_DeactiveName,
					   dbo.tblAshkhas.fldName+' '+ dbo.tblAshkhas.fldFamily AS fldNamePersonal,fldCodeMeli,fldFatherName,fldMobile
, isnull(fldCodeEnhesari,'')fldCodeEnhesari,CASE WHEN dbo.tblUser.fldUserType=1 THEN  N'کاربر سامانه '
                                                     WHEN dbo.tblUser.fldUserType=2 THEN  N'کاربر وب سرویس '
                                                      WHEN dbo.tblUser.fldUserType=3 THEN  N'کاربرسامانه و وب سرویس 'end AS fldUserType_Name
	,dbo.Fn_LimitationUser(tblUser.fldId)fldLimitationUser,dbo.Fn_LimitationType_User(tblUser.fldId)fldLimitationType,dbo.tblUser.fldType, CASE WHEN fldType = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldTypeName
,fldName,fldFamily
FROM         tblUser INNER JOIN
dbo.tblAshkhas ON tblAshkhas.fldId = tblUser.fldShakhsId left outer join
tblPersonalInfo on tblPersonalInfo.fldShakhsId=tblAshkhas.fldId
					  WHERE  tblUser.fldId IN (SELECT Id FROM @temp) 
ORDER BY  fldFamily,fldName	

COMMIT TRAN
GO
