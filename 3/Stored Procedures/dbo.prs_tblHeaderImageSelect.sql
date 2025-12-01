SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblHeaderImageSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=dbo.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldTitle], [fldImageUrl], [fldStatus], [fldInputId], [fldDate] 
	,case when fldStatus=0 then N'غیرفعال' else N'فعال' end fldStatusName
	,fldMatn1,fldMatn2
	FROM   [dbo].[tblHeaderImage] 
	WHERE  fldId=@value
	
	if (@fieldname='fldStatus')
	SELECT top(@h)[fldId], [fldTitle], [fldImageUrl], [fldStatus], [fldInputId], [fldDate] 
	,case when fldStatus=0 then N'غیرفعال' else N'فعال' end fldStatusName
	,fldMatn1,fldMatn2
	FROM   [dbo].[tblHeaderImage] 
	WHERE  fldStatus=@value
	

	if (@fieldname='fldStatusName')
	SELECT top(@h)* from (select [fldId], [fldTitle], [fldImageUrl], [fldStatus], [fldInputId], [fldDate] 
	,case when fldStatus=0 then N'غیرفعال' else N'فعال' end fldStatusName
	,fldMatn1,fldMatn2
	FROM   [dbo].[tblHeaderImage] ) t
	WHERE  fldStatusName like @value
	


	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldTitle], [fldImageUrl], [fldStatus], [fldInputId], [fldDate] 
		,case when fldStatus=0 then N'غیرفعال' else N'فعال' end fldStatusName
		,fldMatn1,fldMatn2
	FROM   [dbo].[tblHeaderImage] 
	


	COMMIT
GO
