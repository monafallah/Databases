SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPersonalHokmSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	@OrganId INT,
	 @userId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)

	if (@fieldname=N'fldId')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
		if (@fieldname=N'fldTarikhShoroo')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldTarikhShoroo like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

	declare @date datetime
if (@fieldname=N'CheckHokm')
begin
SELECT  Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
			
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId = @Value AND fldTarikhEjra>=@Value2 and fldStatusHokm=0
	AND tblPersonalHokm.fldId<>@h 
end	
	if (@fieldname=N'CheckTaiidHokm')
	begin
	SELECT @date=flddate,@OrganId=fldPrs_PersonalInfoId FROM PRS.tblPersonalHokm
	where fldid=@value
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
			
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId = @OrganId AND fldTarikhEjra<=@Value2 and fldStatusHokm=0
	AND tblPersonalHokm.fldId<>@Value and Prs.tblPersonalHokm.fldDate>=@date 
	end
	if (@fieldname=N'CheckEditEstkhedam')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				
	WHERE  tblPersonalHokm.fldTarikhEjra >= @Value AND (fldPrs_PersonalInfoId) =@OrganId

	if (@fieldname=N'CheckEditTashilat')
SELECT  Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId inner join 
				  prs.tblHokm_InfoPersonal_History as h on h.fldPersonalHokmId=tblPersonalHokm.fldid
WHERE  tblPersonalHokm.fldTarikhEjra >= @Value AND (Prs_tblPersonalInfo.fldEmployeeId) =@OrganId and h.fldMadrakId=@h and h.fldReshteTahsili=@Value2
	
	if (@fieldname=N'ChackPersonalId')/*برای مراغه*/
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				
	WHERE  tblPersonalHokm.fldId like  @OrganId and tblPersonalHokm.fldTarikhSodoor like @value and fldTarikhEjra like @value2
	
	
	if (@fieldname=N'fldDesc')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldDesc like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
	IF (@fieldname=N'fldFileId')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldFileId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
	
		IF (@fieldname=N'fldTypehokm')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldTypehokm like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
		if (@fieldname=N'fldPrs_PersonalInfoId')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
                      	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
						order by Prs.tblPersonalHokm.fldTarikhSodoor desc,Prs.tblPersonalHokm.fldTarikhEjra desc
	
			if (@fieldname=N'CheckPrs_PersonalInfoId')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value

	if (@fieldname=N'fldShomareHokm')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldShomareHokm like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

		if (@fieldname=N'fldSh_Personali')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE fldSh_Personali like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
	
	if (@fieldname=N'fldNameEmployee')
	SELECT     TOP (100)* FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
							)temp
	WHERE  fldNameEmployee LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
	
	if (@fieldname=N'fldCodemeli')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
                     	WHERE  fldCodemeli LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

		
	if (@fieldname=N'fldTarikhEjra')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
                      	WHERE  fldTarikhEjra LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

		
	if (@fieldname=N'fldTarikhSodoor')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
                      	WHERE  Prs.tblPersonalHokm.fldTarikhSodoor LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
		if (@fieldname=N'fldStatusHokmName')
	SELECT     TOP (100)* FROM (	SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
				  )t
                      	WHERE  fldStatusHokmName LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
			if (@fieldname=N'fldNoeEstekhdamName')
	SELECT     TOP (100)* FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
				  
				   )temp
	WHERE  fldNoeEstekhdamName LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
	if (@fieldname=N'fldAnvaeEstekhdamId')
SELECT TOP (100) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldAnvaeEstekhdamId = @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	
		if (@fieldname=N'CheckAnvaeEstekhdamId')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				
	WHERE  tblPersonalHokm.fldAnvaeEstekhdamId = @Value
	
				if (@fieldname=N'fldStatusTaaholName')
	SELECT     TOP (100)* FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
				  )temp
	WHERE  fldStatusTaaholName LIKE @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

	if (@fieldname=N'ALL')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
                     

	if (@fieldname=N'LastPersonalHokm')
SELECT TOP (1) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				
	WHERE  SUBSTRING(tblPersonalHokm.fldTarikhEjra,1,4) like @Value AND fldPrs_PersonalInfoId=@Value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblPersonalHokm.fldTarikhSodoor DESC,fldTarikhEjra desc
	


	if (@fieldname=N'')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
                      WHERE  Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId


	if (@fieldname=N'Personal_Id')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND tblPersonalHokm.fldid like @value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

	if (@fieldname=N'Personal_TarikhShoroo')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldTarikhShoroo like @Value  AND tblPersonalHokm.fldid like @value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId


	if (@fieldname=N'Personal_NoeEstekhdamName')
SELECT TOP (@h)* FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND  Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId) r

	WHERE fldNoeEstekhdamName LIKE @value2 


	if (@fieldname=N'Personal_SumItem')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND tblPersonalHokm.fldSumItem like @value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId



if (@fieldname=N'Personal_Typehokm')
SELECT TOP (@h) * FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId)t
	WHERE fldTypehokm LIKE @Value2



if (@fieldname=N'Personal_StatusTaaholName')
SELECT TOP (@h)* FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId)t
	WHERE fldStatusTaaholName LIKE @Value2



if (@fieldname=N'Personal_StatusHokmName')
SELECT TOP (@h) * FROM (SELECT Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId)t
	WHERE fldStatusHokmName LIKE @Value2



if (@fieldname=N'Personal_ShomareHokm')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND tblPersonalHokm.fldShomareHokm like @value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId



if (@fieldname=N'Personal_TarikhSodoor')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND tblPersonalHokm.fldTarikhSodoor LIKE @value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId


if (@fieldname=N'Personal_TarikhEjra')
SELECT TOP (@h) Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                  CASE WHEN fldStatusHokm = 0 THEN N'تایید نشده ' ELSE N'تایید شده' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, 
                  Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                  Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                  Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Prs.tblPersonalHokm.fldUserId, 
                  Prs.tblPersonalHokm.fldDate, Prs.tblPersonalHokm.fldDesc, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName, 
                  Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, 
                  tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                  Com.tblEmployee_Detail.fldSh_Shenasname, Prs.tblPersonalHokm.fldFileId, Prs.tblPersonalHokm.fldStatusTaaholId, Prs.tblPersonalHokm.fldMashmooleBime, 
                  Prs.tblPersonalHokm.fldTatbigh1, Prs.tblPersonalHokm.fldTatbigh2, Prs.tblPersonalHokm.fldHasZaribeTadil, Prs.tblPersonalHokm.fldZaribeSal1, 
                  Prs.tblPersonalHokm.fldZaribeSal2,ISNULL(fldSumItem,0)fldSumItem,fldSh_Personali,fldTarikhShoroo,fldHokmType,case when fldHokmType=1 then N'حکم مکانیزه' when fldHokmType=2 then N'حکم اولبه' when fldHokmType=3 then N'حکم دستی'  else N'' end as fldHokmTypeName
FROM     Prs.tblPersonalHokm INNER JOIN
                  Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                  Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId
				  cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where h.fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
	WHERE  tblPersonalHokm.fldPrs_PersonalInfoId like @Value  AND tblPersonalHokm.fldTarikhEjra LIKE @value2 AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId




	COMMIT
GO
