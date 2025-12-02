SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployee_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @value =com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Com.tblEmployee_Detail.fldId, Com.tblEmployee_Detail.fldEmployeeId, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, t.fldMadrakId, Com.tblEmployee_Detail.fldNezamVazifeId, Com.tblEmployee_Detail.fldTaaholId, 
                      T.fldReshteId, Com.tblEmployee_Detail.fldFileId, Com.tblEmployee_Detail.fldSh_Shenasname, Com.tblEmployee_Detail.fldMahalTavalodId, 
                      Com.tblEmployee_Detail.fldMahalSodoorId, Com.tblEmployee_Detail.fldTarikhSodoor, Com.tblEmployee_Detail.fldAddress, Com.tblEmployee_Detail.fldCodePosti, 
                      Com.tblEmployee_Detail.fldMeliyat, Com.tblEmployee_Detail.fldUserId, Com.tblEmployee_Detail.fldDesc, Com.tblEmployee_Detail.fldDate, 
                      Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli
					   ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,Com.tblEmployee_Detail.fldTel,Com.tblEmployee_Detail.fldMobile
FROM         Com.tblEmployee_Detail INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId from com.tblHistoryTahsilat as t where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
	WHERE  Com.tblEmployee_Detail.fldId = @Value

	if (@fieldname=N'fldEmployeeId')
SELECT     TOP (@h) Com.tblEmployee_Detail.fldId, Com.tblEmployee_Detail.fldEmployeeId, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, t.fldMadrakId, Com.tblEmployee_Detail.fldNezamVazifeId, Com.tblEmployee_Detail.fldTaaholId, 
                      T.fldReshteId, Com.tblEmployee_Detail.fldFileId, Com.tblEmployee_Detail.fldSh_Shenasname, Com.tblEmployee_Detail.fldMahalTavalodId, 
                      Com.tblEmployee_Detail.fldMahalSodoorId, Com.tblEmployee_Detail.fldTarikhSodoor, Com.tblEmployee_Detail.fldAddress, Com.tblEmployee_Detail.fldCodePosti, 
                      Com.tblEmployee_Detail.fldMeliyat, Com.tblEmployee_Detail.fldUserId, Com.tblEmployee_Detail.fldDesc, Com.tblEmployee_Detail.fldDate, 
                      Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli
					   ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,Com.tblEmployee_Detail.fldTel,Com.tblEmployee_Detail.fldMobile
FROM         Com.tblEmployee_Detail INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId from com.tblHistoryTahsilat as t where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
	WHERE  Com.tblEmployee_Detail.fldEmployeeId = @Value

		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Com.tblEmployee_Detail.fldId, Com.tblEmployee_Detail.fldEmployeeId, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, t.fldMadrakId, Com.tblEmployee_Detail.fldNezamVazifeId, Com.tblEmployee_Detail.fldTaaholId, 
                      T.fldReshteId, Com.tblEmployee_Detail.fldFileId, Com.tblEmployee_Detail.fldSh_Shenasname, Com.tblEmployee_Detail.fldMahalTavalodId, 
                      Com.tblEmployee_Detail.fldMahalSodoorId, Com.tblEmployee_Detail.fldTarikhSodoor, Com.tblEmployee_Detail.fldAddress, Com.tblEmployee_Detail.fldCodePosti, 
                      Com.tblEmployee_Detail.fldMeliyat, Com.tblEmployee_Detail.fldUserId, Com.tblEmployee_Detail.fldDesc, Com.tblEmployee_Detail.fldDate, 
                      Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli
					   ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,Com.tblEmployee_Detail.fldTel,Com.tblEmployee_Detail.fldMobile
FROM         Com.tblEmployee_Detail INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId from com.tblHistoryTahsilat as t where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
					  WHERE  Com.tblEmployee_Detail.fldDesc like @Value

	if (@fieldname=N'')
	SELECT     TOP (@h) Com.tblEmployee_Detail.fldId, Com.tblEmployee_Detail.fldEmployeeId, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, t.fldMadrakId, Com.tblEmployee_Detail.fldNezamVazifeId, Com.tblEmployee_Detail.fldTaaholId, 
                      T.fldReshteId, Com.tblEmployee_Detail.fldFileId, Com.tblEmployee_Detail.fldSh_Shenasname, Com.tblEmployee_Detail.fldMahalTavalodId, 
                      Com.tblEmployee_Detail.fldMahalSodoorId, Com.tblEmployee_Detail.fldTarikhSodoor, Com.tblEmployee_Detail.fldAddress, Com.tblEmployee_Detail.fldCodePosti, 
                      Com.tblEmployee_Detail.fldMeliyat, Com.tblEmployee_Detail.fldUserId, Com.tblEmployee_Detail.fldDesc, Com.tblEmployee_Detail.fldDate, 
                      Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli
					   ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,Com.tblEmployee_Detail.fldTel,Com.tblEmployee_Detail.fldMobile
FROM         Com.tblEmployee_Detail INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId from com.tblHistoryTahsilat as t where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
	COMMIT
GO
