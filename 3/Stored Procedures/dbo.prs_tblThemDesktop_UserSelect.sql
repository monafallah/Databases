SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblThemDesktop_UserSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldFileDesktopId], [fldType], [fldUserId], [fldDesc] ,
	case when fldtype=1 then N'پیش فرض' when fldtype=2 then N'بدون عکس' when fldType=3 then N'انتخاب خودش' end as fldtypeName
	,fldThem,case when fldthem=0 then N'Default' when fldthem=1 then N'Gray' when fldthem=4 then N'Neptune' end as fldThemName
	FROM   [dbo].[tblThemDesktop_User] 
	WHERE  fldId=@Value

	if (@FieldName='fldUserId')
	SELECT top(@h) [fldId], [fldFileDesktopId], [fldType], [fldUserId], [fldDesc] ,
	case when fldtype=1 then N'پیش فرض' when fldtype=2 then N'بدون عکس' when fldType=3 then N'انتخاب خودش' end as fldtypeName
	,fldThem,case when fldthem=0 then N'Default' when fldthem=1 then N'Gray' when fldthem=4 then N'Neptune' end as fldThemName
	FROM   [dbo].[tblThemDesktop_User] 
	WHERE  fldUserId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldFileDesktopId], [fldType], [fldUserId], [fldDesc] ,
	case when fldtype=1 then N'پیش فرض' when fldtype=2 then N'بدون عکس' when fldType=3 then N'انتخاب خودش' end as fldtypeName
	,fldThem,case when fldthem=0 then N'Default' when fldthem=1 then N'Gray' when fldthem=4 then N'Neptune' end as fldThemName
	FROM   [dbo].[tblThemDesktop_User] 
	WHERE  fldDesc=@Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldFileDesktopId], [fldType], [fldUserId], [fldDesc] ,
	case when fldtype=1 then N'پیش فرض' when fldtype=2 then N'بدون عکس' when fldType=3 then N'انتخاب خودش' end as fldtypeName
	,fldThem,case when fldthem=0 then N'Default' when fldthem=1 then N'Gray' when fldthem=4 then N'Neptune' end as fldThemName
	FROM   [dbo].[tblThemDesktop_User] 

	
	COMMIT
GO
