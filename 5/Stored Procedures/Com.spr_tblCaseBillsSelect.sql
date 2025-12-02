SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCaseBillsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	 SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
          WHERE  Com.tblCaseBills.fldId = @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId            
                      
                      
                      UNION ALL
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE  Com.tblCaseBills.fldId = @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
	
	UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 where fldAshkhasId is null and Com.tblCaseBills.fldId = @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
	
	
	
	

	if (@fieldname=N'fldDesc')
	SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
        WHERE Com.tblCaseBills.fldDesc like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId              
                      
                      
                      UNION ALL
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE Com.tblCaseBills.fldDesc like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
	
	UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 where fldAshkhasId is null and Com.tblCaseBills.fldDesc like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId  


	if (@fieldname=N'')
	 SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId LEFT outer JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
					  where Com.tblCaseBills.fldOrganId=@fldOrganId
                      UNION all
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  LEFT outer JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
                      where Com.tblCaseBills.fldOrganId=@fldOrganId
                           UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 where fldAshkhasId is null and Com.tblCaseBills.fldOrganId=@fldOrganId
                      
                      
                      
    if (@fieldname=N'CheckFileNum')
	SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
        WHERE Com.tblCaseBills.fldFileNum like  @Value               
                      
                      
                      UNION ALL
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE Com.tblCaseBills.fldFileNum like  @Value
	                  
UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 where fldAshkhasId is null and Com.tblCaseBills.fldFileNum like  @Value  





    if (@fieldname=N'fldFileNum')
	SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
        WHERE Com.tblCaseBills.fldFileNum like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId               
                      
                      
                      UNION ALL
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE Com.tblCaseBills.fldFileNum like  @Value  AND Com.tblCaseBills.fldOrganId=@fldOrganId
	
	UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 where fldAshkhasId is null and Com.tblCaseBills.fldFileNum like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId 
	
	
	
	    if (@fieldname=N'fldName_shakhs')
	SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
        WHERE Com.tblAshkhaseHoghoghi.fldName like  @Value  AND Com.tblCaseBills.fldOrganId=@fldOrganId              
                      
                      
                      UNION ALL
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
	

	
	


	    if (@fieldname=N'fldCodeMelli')
	 SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
        WHERE  Com.tblAshkhaseHoghoghi.fldShenaseMelli LIKE  @Value  AND Com.tblCaseBills.fldOrganId=@fldOrganId              
                      
                      
                      UNION ALL
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE Com.tblEmployee.fldCodemeli like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId

	
	
	
	   if (@fieldname=N'fldName_Organ')
select * from(	 SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId)t
                      
        WHERE fldName_Organ like  @Value  AND fldOrganId=@fldOrganId              
                      
                      
                      UNION ALL
                      
select * from( SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId)t
	WHERE fldName_Organ like  @Value  AND fldOrganId=@fldOrganId	
	
	UNION all
                      
select * from( SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId )t
						 where fldAshkhasId is null and fldName_Organ like  @Value  AND fldOrganId=@fldOrganId
	
	
	
	
	   if (@fieldname=N'fldTitle_chartOrgan')
  SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
                      
        WHERE  Com.tblChartOrgan.fldTitle LIKE  @Value  AND Com.tblCaseBills.fldOrganId=@fldOrganId              
                      
                      
                      UNION ALL
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
	WHERE Com.tblChartOrgan.fldTitle like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
	
	
	UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 where fldAshkhasId is null and Com.tblChartOrgan.fldTitle LIKE  @Value  AND Com.tblCaseBills.fldOrganId=@fldOrganId  
	
	
	
	
	
		   if (@fieldname=N'fldNameCenter')
 SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId
					  WHERE ACC.tblCenterCost.fldNameCenter like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
                      UNION all
                      
SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId
                      WHERE ACC.tblCenterCost.fldNameCenter like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId
                           UNION all
                      
SELECT   top(@h)     Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, Com.tblCaseBills.fldOrganChartId, 
                         Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, 
                         ACC.tblCenterCost.fldNameCenter,N'' AS fldName_shakhs, N'' AS fldCodeMelli, 
                         Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ, N'-' AS fldShakhs_Type
FROM            Com.tblCaseBills INNER JOIN
                         Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                         ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Com.tblChartOrgan ON Com.tblChartOrgan.fldId = Com.tblCaseBills.fldOrganChartId 
						 WHERE fldAshkhasId is null  and ACC.tblCenterCost.fldNameCenter like  @Value AND Com.tblCaseBills.fldOrganId=@fldOrganId

	
	 if (@fieldname=N'fldShakhs_Type')
 select * from( SELECT   top(@h)    Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType, ACC.tblCenterCost.fldNameCenter, Com.tblAshkhaseHoghoghi.fldName AS fldName_shakhs, 
                      Com.tblAshkhaseHoghoghi.fldShenaseMelli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan,Com.fn_stringDecode( Com.tblOrganization.fldName) AS fldName_Organ,N'حقوقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblAshkhaseHoghoghi ON tblAshkhaseHoghoghi.fldId = tblAshkhas.fldHoghoghiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblCaseBills.fldOrganChartId = Com.tblChartOrgan.fldId)t
					  WHERE fldShakhs_Type like  @Value AND fldOrganId=@fldOrganId
                      UNION all
                      
select * from( SELECT   top(@h)   Com.tblCaseBills.fldId, Com.tblCaseBills.fldBillsTypeId, Com.tblCaseBills.fldFileNum, Com.tblCaseBills.fldCentercoId, Com.tblCaseBills.fldOrganId, 
                      Com.tblCaseBills.fldOrganChartId, Com.tblCaseBills.fldAshkhasId, Com.tblCaseBills.fldDesc, Com.tblCaseBills.fldDate, Com.tblCaseBills.fldIP, 
                      Com.tblCaseBills.fldUserId, Com.tblBillsType.fldName AS fldName_BillsType , ACC.tblCenterCost.fldNameCenter, Com.tblEmployee.fldName+' '+Com.tblEmployee.fldFamily AS fldName_shakhs, 
                      Com.tblEmployee.fldCodemeli AS fldCodeMelli , Com.tblChartOrgan.fldTitle AS fldTitle_chartOrgan, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName_Organ,N'حقیقی'AS fldShakhs_Type
FROM         Com.tblCaseBills INNER JOIN
                      Com.tblBillsType ON Com.tblCaseBills.fldBillsTypeId = Com.tblBillsType.fldId INNER JOIN
                      ACC.tblCenterCost ON Com.tblCaseBills.fldCentercoId = ACC.tblCenterCost.fldId  INNER JOIN
                      Com.tblAshkhas ON Com.tblCaseBills.fldAshkhasId = Com.tblAshkhas.fldId INNER JOIN
                      Com.tblEmployee ON tblEmployee.fldId = tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblOrganization ON Com.tblCaseBills.fldOrganId = Com.tblOrganization.fldId INNER JOIN 
                      Com.tblChartOrgan ON tblChartOrgan.fldId = tblCaseBills.fldOrganChartId)t
                      WHERE fldShakhs_Type like  @Value AND fldOrganId=@fldOrganId

	
	
	COMMIT
GO
