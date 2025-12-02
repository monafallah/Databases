SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateCodingSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value2 NVARCHAR(50),
	@HeaderCoding int,
	@Value3 nvarchar(max),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	SET @Value3=Com.fn_TextNormalize(@Value3)
	if (@h=0) set @h=2147483647

		if (@fieldname=N'fldId')
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
					,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
	WHERE  ACC.tblTemplateCoding.fldId = @Value

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId 
	WHERE ACC.tblTemplateCoding.fldDesc like  @Value 
	
	
	

	if (@fieldname=N'')
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId 
                      
    if (@fieldname=N'fldName_LevelsAccountingType')                  
   SELECT TOP (@h)* FROM (SELECT      ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId)t 
                      
            WHERE t.fldName_LevelsAccountingType like @Value 
            
            
                      
                      
     if (@fieldname=N'fldNameItem')                 
   SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
                      
              WHERE ACC.tblItemNecessary.fldNameItem like @Value 
                      
                      
                      
                      
                      
   IF (@fieldname=N'fldTitle_Mahiyat' )                                                        
SELECT  TOP (@h)* FROM (SELECT     ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId)t
                      WHERE t.fldTitle_Mahiyat like  @Value
                      
                      
                      
                      
                      
    
   IF (@fieldname=N'fldTemplateName')                                                         
SELECT  * FROM (SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId )t
                      WHERE t.fldTemplateName like  @Value 
                      
                      
                      
                      
      IF (@fieldname=N'fldName')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId  
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
                      WHERE ACC.tblTemplateCoding.fldName like @value




                      
IF (@fieldname=N'fldPID')
BEGIN 
if (@value3 ='')
	SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
        ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
        ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
        ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
        ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
	,'' fldDaramadCode,ACC.tblTemplateCoding.fldCodeBudget,ACC.tblTemplateCoding.fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
	FROM         ACC.tblTemplateCoding inner join
		ACC.tblTemplateCoding as p on p.fldId=@Value and ACC.tblTemplateCoding.fldTempNameId=@value2 and tblTemplateCoding.fldTempCodeId.GetAncestor(1)=p.fldTempCodeId left outer JOIN
        ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
        ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
        ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
        ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
		  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
		  	


else
SELECT  distinct   TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
        ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
        ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
        ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
        ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
	,'' fldDaramadCode,ACC.tblTemplateCoding.fldCodeBudget,ACC.tblTemplateCoding.fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
	FROM         ACC.tblTemplateCoding inner join
		ACC.tblTemplateCoding as p on p.fldId=@Value and ACC.tblTemplateCoding.fldTempNameId=@value2 and tblTemplateCoding.fldTempCodeId.GetAncestor(1)=p.fldTempCodeId left outer JOIN
        ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
        ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
        ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
        ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
		  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
		  	cross apply (select t.fldName,t.fldStrhid from ACC.tblTemplateCoding t	
								where  t.fldTempNameId=@value2  and t.fldStrhid like tblTemplateCoding.fldStrhid+'%'  )child
			where 	(ACC.tblTemplateCoding.fldName like @Value3 or child.fldname like @value3 )
			order by  ACC.tblTemplateCoding.fldCode

END
         
                      
                      
          IF (@fieldname=N'fldPCod')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
                      WHERE ACC.tblTemplateCoding.fldPCod LIKE @value   and fldTempNameId=@value2                                                 
     
IF (@fieldname=N'fldCode')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
                      WHERE ACC.tblTemplateCoding.fldCode LIKE @value     and fldTempNameId=@value2
					  
IF (@fieldname=N'fldTempNameId')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
					    left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
                      WHERE ACC.tblTemplateCoding.fldTempNameId LIKE @value AND ACC.tblTemplateCoding.fldCode LIKE @value2
                      
                      
                      
                      
    
    
IF (@fieldname=N'PCod')
          
    if(@Value='')
	begin
        SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
							   ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
							  ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
							  ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
							  ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
		,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
		FROM         ACC.tblTemplateCoding left outer JOIN
							  ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
							  ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
							  ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
							  ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId  
							  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
							 where ACC.tblTemplateCoding.fldPcod IS NULL  And ACC.tblTemplateCoding.fldTempNameId  LIKE @value2
    END 
    ELSE
	   SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
						   ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
						  ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
						  ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
						  ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
	,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
	FROM         ACC.tblTemplateCoding left outer JOIN
						  ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
						  ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
						  ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
						  ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId  
						  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
						  where  ACC.tblTemplateCoding.fldPcod LIKE @value AND ACC.tblTemplateCoding.fldTempNameId LIKE @Value2  
  
  
  
  
  

--  IF (@fieldname=N'fldChaild')                                                         
--SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
--                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
--                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
--                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
--                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType
--FROM         ACC.tblTemplateCoding left outer JOIN
--                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
--                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
--                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
--                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId


 
    
    IF (@fieldname=N'fldItemId')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
                      left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
					  WHERE ACC.tblTemplateCoding.fldItemId LIKE @value 
                                                          
   
   
   
   
       IF (@fieldname=N'fldLevelsAccountTypId')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
                       left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
					  WHERE ACC.tblTemplateCoding.fldLevelsAccountTypId LIKE @value         
					  
					  
	       IF (@fieldname=N'fldNameTypeHesab')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
                       left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
					  WHERE t.fldName LIKE @value  				  
	
	
		       IF (@fieldname=N'fldTypeHesabId')                                                         
SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
                       ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
                      ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
                      ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
                      ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
,'' fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
FROM         ACC.tblTemplateCoding left outer JOIN
                      ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
                      ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
                      ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
                      ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
                       left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
					  WHERE tblTemplateCoding.fldTypeHesabId LIKE @value  	
					  
					  
					  
IF (@fieldname=N'PCod_Daramd')
          
    if(@Value='0')
	begin
        SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
							   ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
							  ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
							  ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
							  ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType  ,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId 
		, coding.fldDaramadCode,fldCodeBudget,fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
		FROM         ACC.tblTemplateCoding left outer JOIN
							  ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
							  ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
							  ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
							  ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId  
							  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId
							  outer apply (select c.fldDaramadCode,c.fldTempCodingId from acc.tblCoding_Details c
											where c.fldTempCodingId= ACC.tblTemplateCoding .fldid and fldHeaderCodId=@HeaderCoding)coding
						cross apply(	select  parent.fldid as fldItemId from ACC.tblItemNecessary child inner join
								ACC.tblItemNecessary parent on  child.fldItemId.IsDescendantOf(parent.fldItemId)=1
								inner join acc.tblTemplateCoding t on t.fldItemId=child.fldId
								where t.fldid= ACC.tblTemplateCoding.fldId  and parent.fldLevelId=1)item
							 where ACC.tblTemplateCoding.fldPcod IS NULL  And ACC.tblTemplateCoding.fldTempNameId  LIKE @value2
							 and item.fldItemId=7
    END 
    ELSE
		  SELECT     TOP (@h) ACC.tblTemplateCoding.fldId,  ACC.tblTemplateCoding.fldItemId, ACC.tblTemplateCoding.fldName, 
			ACC.tblTemplateCoding.fldPCod, ACC.tblTemplateCoding.fldMahiyatId, ACC.tblTemplateCoding.fldCode, 
			ACC.tblTemplateCoding.fldTempNameId, ACC.tblTemplateCoding.fldLevelsAccountTypId, ACC.tblTemplateCoding.fldDesc, ACC.tblTemplateCoding.fldDate, 
			ACC.tblTemplateCoding.fldIp, ACC.tblTemplateCoding.fldUserId, ACC.tblTemplateName.fldName AS fldTemplateName, ACC.tblItemNecessary.fldNameItem, ACC.tblMahiyat.fldTitle AS fldTitle_Mahiyat, 
			ACC.tblLevelsAccountingType.fldName AS fldName_LevelsAccountingType,t.fldName as fldNameTypeHesab,tblTemplateCoding.fldTypeHesabId
		, fldDaramadCode,ACC.tblTemplateCoding.fldCodeBudget,ACC.tblTemplateCoding.fldAddChildNode,tblTemplateCoding.fldMahiyat_GardeshId
		FROM         ACC.tblTemplateCoding inner join
			ACC.tblTemplateCoding as p on p.fldId=@Value and ACC.tblTemplateCoding.fldTempNameId=@value2 and tblTemplateCoding.fldTempCodeId.GetAncestor(1)=p.fldTempCodeId left outer JOIN
			ACC.tblItemNecessary ON ACC.tblTemplateCoding.fldItemId = ACC.tblItemNecessary.fldId INNER JOIN
			ACC.tblTemplateName ON ACC.tblTemplateCoding.fldTempNameId = ACC.tblTemplateName.fldId INNER JOIN
			ACC.tblMahiyat ON ACC.tblTemplateCoding.fldMahiyatId = ACC.tblMahiyat.fldId INNER JOIN
			ACC.tblLevelsAccountingType ON ACC.tblTemplateCoding.fldLevelsAccountTypId = ACC.tblLevelsAccountingType.fldId 
			 outer apply (select c.fldDaramadCode,c.fldTempCodingId from acc.tblCoding_Details c
											where c.fldTempCodingId= ACC.tblTemplateCoding .fldid and fldHeaderCodId=@HeaderCoding)coding
			  left join acc.tbltypeHesab t on t.fldid=tblTemplateCoding.fldTypeHesabId					  
					  					  
					                                                    
	COMMIT



	
GO
