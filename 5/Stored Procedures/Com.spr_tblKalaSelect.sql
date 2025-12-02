SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
	WHERE  com.tblKala.fldId = @Value and tblKala.fldorganId=@OrganId
	
	
	

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
	WHERE com.tblKala.fldDesc like  @Value  and tblKala.fldorganId=@OrganId
	
	

	if (@fieldname=N'')
SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
                      
                      
  
  
	if (@fieldname=N'fldOrganId')
SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
					  ,tblKala.fldorganId

FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
                      where  tblKala.fldorganId=@OrganId
                    
  if (@fieldname=N'fldName')
	SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
	WHERE  com.tblKala.fldName like @Value  and tblKala.fldorganId=@OrganId

	if (@fieldname=N'fldKalaCode')
	SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
	WHERE  com.tblKala.fldKalaCode like @Value  and tblKala.fldorganId=@OrganId
	
	
	
	 if (@fieldname=N'fldVahedAsli')
	SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
	WHERE  com.tblKala.fldVahedAsli like @Value  and tblKala.fldorganId=@OrganId




	 if (@fieldname=N'fldVahedFaree')
SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId
	WHERE  com.tblKala.fldVahedFaree like @Value  and tblKala.fldorganId=@OrganId
	
	
	
	
 if (@fieldname=N'fldVahedAsli_Name')
SELECT * FROM (SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId)t
	WHERE  t.fldVahedAsli_Name like @Value  and t.fldorganId=@OrganId
	
	
	
	
	
	
 if (@fieldname=N'fldVahedFaree_Name')
SELECT * FROM (SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId)t
	WHERE  t.fldVahedFaree_Name like @Value  and t.fldorganId=@OrganId
	
	

	
 if (@fieldname=N'fldStatusName')
SELECT * FROM (SELECT     TOP (@h) com.tblKala.fldId, com.tblKala.fldName, com.tblKala.fldKalaType, com.tblKala.fldKalaCode, com.tblKala.fldStatus, 
                      CASE WHEN com.tblKala.fldStatus = 1 THEN N'فعال' WHEN com.tblKala.fldStatus = 2 THEN N'غیرفعال' END AS fldStatusName, com.tblKala.fldSell, 
                      com.tblKala.fldArzeshAfzodeh, com.tblKala.fldIranCode, com.tblKala.fldMoshakhaseType, com.tblKala.fldMoshakhase, com.tblKala.fldVahedAsli, com.tblKala.fldVahedFaree, 
                      com.tblKala.fldNesbatType, com.tblKala.fldVahedMoadel, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId, 
                      Com.tblMeasureUnit.fldNameVahed AS fldVahedAsli_Name , tblMeasureUnit_1.fldNameVahed AS fldVahedFaree_Name
,tblKala.fldorganId
FROM         com.tblKala INNER JOIN
                      Com.tblMeasureUnit ON com.tblKala.fldVahedAsli = Com.tblMeasureUnit.fldId INNER JOIN
                      Com.tblMeasureUnit AS tblMeasureUnit_1 ON com.tblKala.fldVahedFaree = tblMeasureUnit_1.fldId)t
	WHERE  t.fldStatusName like @Value  and t.fldorganId=@OrganId
	
	
	
	COMMIT
GO
