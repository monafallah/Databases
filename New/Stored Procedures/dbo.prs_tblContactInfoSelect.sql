SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblContactInfoSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=dbo.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldType], [fldMatn], [fldInputId], [fldDate] ,
	case when fldType=1 then N'آدرس'   when fldType=2  then N'تلفن' when fldType=3   then N'ایمیل'  when fldType=4  then N'ساعت'  when fldType=5  then N'شبکه های اجتماعی' when fldType=6  then N'درباره ما' 
	end fldtypeName
	FROM   [dbo].[tblContactInfo] 
	WHERE  fldId=@value

	
	if (@fieldname='fldType')
	SELECT top(@h)[fldId], [fldType], [fldMatn], [fldInputId], [fldDate] ,
	case when fldType=1 then N'آدرس'   when fldType=2  then N'تلفن' when fldType=3   then N'ایمیل'  when fldType=4  then N'ساعت'  when fldType=5  then N'شبکه های اجتماعی' when fldType=6  then N'درباره ما' 
	end fldtypeName
	FROM   [dbo].[tblContactInfo] 
	WHERE  fldType=@value
	
	if (@fieldname='fldtypeName')
	select * from(SELECT top(@h)[fldId], [fldType], [fldMatn], [fldInputId], [fldDate] ,
	case when fldType=1 then N'آدرس'   when fldType=2  then N'تلفن' when fldType=3   then N'ایمیل'  when fldType=4  then N'ساعت'  when fldType=5  then N'شبکه های اجتماعی' when fldType=6  then N'درباره ما' 
	end fldtypeName
	FROM   [dbo].[tblContactInfo] )t
	WHERE  fldtypeName like @value
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldType], [fldMatn], [fldInputId], [fldDate],
	case when fldType=1 then N'آدرس'   when fldType=2 then N'تلفن' when fldType=3   then N'ایمیل'  when fldType=4  then N'ساعت'  when fldType=5  then N'شبکه های اجتماعی'  when fldType=6  then N'درباره ما'
	end fldtypeName 
	FROM   [dbo].[tblContactInfo] 
	


	COMMIT
GO
