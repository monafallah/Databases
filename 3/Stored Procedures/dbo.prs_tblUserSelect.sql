SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=dbo.fn_TextNormalize(@Value)
	
    

	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId
				,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
	WHERE  tblUser.fldId = @Value
	ORDER BY tblUser.fldId desc

	if (@fieldname=N'fldUserId')
	begin
	if(@Value='0')
		begin
				SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
						  tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
						,fldShakhsId
					,fldFirstLogin,fldCodeMeli
	FROM         tblUser INNER JOIN
						  tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
		WHERE  tblUser.fldId = 1
		ORDER BY tblUser.fldId desc
	end
	else
	begin
		SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
						  tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
						,fldShakhsId
					,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
	FROM         tblUser INNER JOIN
						  tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
		WHERE  tblUser.fldUserId = @Value and tblUser.fldId<>1
		ORDER BY tblUser.fldId desc
	end

end


   IF (@fieldname=N'checkPass')
SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId
				,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
	WHERE  fldUserName = @Value AND fldPassword=@Value2
		ORDER BY tblUser.fldId desc

	if (@fieldname=N'fldDesc')
			SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive, tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
	WHERE tblUser.fldDesc like  @Value
		ORDER BY tblUser.fldId desc

		
		if (@fieldname=N'fldUserName')
			SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
					  	WHERE  tblUser.fldUserName LIKE @Value


		ORDER BY tblUser.fldId DESC
      
	  if (@fieldname=N'fldNamePersonal')
			SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
					  	WHERE  tblAshkhas.fldName+' '+ tblAshkhas.fldFamily  LIKE @Value


		ORDER BY tblUser.fldId DESC

		 if (@fieldname=N'fldCodeMeli')
			SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
					  	WHERE fldCodeMeli  LIKE @Value


		ORDER BY tblUser.fldId DESC

	if (@fieldname=N'CheckShakhsId')
			SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
					  	WHERE  tblUser.fldShakhsId LIKE @Value

		ORDER BY tblUser.fldId desc


	if (@fieldname=N'')
		SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId

                      	ORDER BY tblUser.fldId desc


if (@fieldname=N'AllActiveUser')
	SELECT     TOP (@h) tblUser.fldId,  tblUser.fldUserName, tblUser.fldPassword, tblUser.fldActive_Deactive,  tblUser.fldUserId, tblUser.fldDesc, 
                      tblUser.fldDate, CASE WHEN fldActive_Deactive = 1 THEN N'فعال' ELSE N'غیرفعال' END AS fldActive_DeactiveName, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldNamePersonal
					,fldShakhsId,fldFirstLogin,fldCodeMeli,tblUser.fldInputID
FROM         tblUser INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
where fldActive_Deactive=1
                      	ORDER BY tblUser.fldId desc

	COMMIT
GO
