SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghJebhe_PersonalSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE  Prs.tblSavabeghJebhe_Personal.fldId = @Value

		if (@fieldname=N'fldAzTarikh')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE  Prs.tblSavabeghJebhe_Personal.fldAzTarikh LIKE @Value AND fldPrsPersonalId=@Value1


		if (@fieldname=N'fldTaTarikh')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE  Prs.tblSavabeghJebhe_Personal.fldTaTarikh LIKE @Value AND fldPrsPersonalId=@Value1

	

		if (@fieldname=N'fldDarsad_Sal')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE fldDarsad_Sal LIKE @Value AND fldPrsPersonalId=@Value1

	if (@fieldname=N'fldTitle')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE fldTitle LIKE @Value AND fldPrsPersonalId=@Value1
	
	if (@fieldname=N'fldItemId')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE fldItemId=@Value
	
	if (@fieldname=N'fldPrsPersonalId')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE fldPrsPersonalId=@Value
	
		if (@fieldname=N'fldAzTarikh_TaTarikh')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE ( (fldAzTarikh BETWEEN @Value AND @Value1 )
	OR (fldTaTarikh BETWEEN @Value AND @Value1) 
	OR (@Value BETWEEN fldAzTarikh AND fldTaTarikh) 
	OR (@Value1 BETWEEN fldAzTarikh AND fldTaTarikh))

	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId
	WHERE  Prs.tblSavabeghJebhe_Personal.fldDesc like  @Value  AND fldPrsPersonalId=@Value1

	if (@fieldname=N'')
	SELECT        TOP (@h) Prs.tblSavabeghJebhe_Personal.fldId, Prs.tblSavabeghJebhe_Personal.fldItemId, Prs.tblSavabeghJebhe_Personal.fldPrsPersonalId, Prs.tblSavabeghJebhe_Personal.fldAzTarikh, 
                         Prs.tblSavabeghJebhe_Personal.fldTaTarikh, Prs.tblSavabeghJebhe_Personal.fldUserId, Prs.tblSavabeghJebhe_Personal.fldDesc, Prs.tblSavabeghJebhe_Personal.fldDate, Prs.tblSavabeghJebhe_Items.fldTitle, 
                         Prs.tblSavabeghJebhe_Items.fldDarsad_Sal
FROM            Prs.tblSavabeghJebhe_Personal INNER JOIN
                         Prs.tblSavabeghJebhe_Items ON Prs.tblSavabeghJebhe_Personal.fldItemId = Prs.tblSavabeghJebhe_Items.fldId

	COMMIT
GO
