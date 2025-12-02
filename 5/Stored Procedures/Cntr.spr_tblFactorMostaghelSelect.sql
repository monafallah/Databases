SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorMostaghelSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@organId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldFactorId], [fldAshkhasId], [fldBudjeCodingId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	,fldTankhahGroupId
	FROM   [Cntr].[tblFactorMostaghel] 

	WHERE  fldId=@value

	if (@fieldname='fldOrganID')
	SELECT top(@h)[fldId], [fldFactorId], [fldAshkhasId], [fldBudjeCodingId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	,fldTankhahGroupId
	FROM   [Cntr].[tblFactorMostaghel] 
	WHERE  fldOrganID=@organid

	if (@fieldname='fldFactorId')
	SELECT top(@h)[fldId], [fldFactorId], [fldAshkhasId], [fldBudjeCodingId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	,fldTankhahGroupId
	FROM   [Cntr].[tblFactorMostaghel] 
	WHERE  fldFactorId=@value
	
		if (@fieldname='fldTankhahGroupId')
	SELECT top(@h)[fldId], [fldFactorId], [fldAshkhasId], [fldBudjeCodingId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	,fldTankhahGroupId
	FROM   [Cntr].[tblFactorMostaghel] 
	WHERE fldTankhahGroupId=@value and   fldOrganID=@organid


	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldFactorId], [fldAshkhasId], [fldBudjeCodingId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	,fldTankhahGroupId
	FROM   [Cntr].[tblFactorMostaghel] 
	


	COMMIT
GO
