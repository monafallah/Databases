SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardeMahaneGroupSelect]
@fieldname Nvarchar(50),
@Value Nvarchar(50),
@sal SMALLINT,
@mah TINYINT,
@NobatePardakht TINYINT,
@OrganId INT
AS 

	BEGIN TRAN
	if (@fieldname=N'fldCostCenterId')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldCostCenterId, Prs.Prs_tblPersonalInfo.fldOrganPostId, 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL (k.fldId, 0)AS fldKarKardeMahaneId, ISNULL ( fldYear, 0) AS fldyear, 
                      ISNULL( fldMah, 0) AS fldMah, 
                      ISNULL(fldKarkard,  Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah))AS fldKarkard, ISNULL (fldGheybat , 0)  AS fldGheybat
					  , ISNULL(fldNobateKari , Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah)) 
                      AS fldNobateKari, ISNULL (fldEzafeKari , 0) AS fldEzafeKari, ISNULL (fldTatileKari, 0)  AS fldTatileKari, ISNULL(fldMamoriatBaBeitote , 0) AS fldMamoriatBaBeitote
					  , ISNULL(fldMamoriatBedoneBeitote , 0)  AS fldMamoriatBedoneBeitote, ISNULL (fldMosaedeh , 0)  AS fldMosaedeh, ISNULL(fldNobatePardakht, 1)  AS fldNobatePardakht
					  , ISNULL (fldGhati, '') AS fldGhati, ISNULL(CASE WHEN fldGhati=1 THEN k.fldEzafeKari ELSE CAST(0 AS INT) end 
					  , CAST(0 AS int)) AS fldGhatiEzafeKar, ISNULL (fldBa10 , 0) AS fldBa10, ISNULL(fldBa20, 0) AS fldBa20,  ISNULL (fldBa30 , 0) AS fldBa30,  ISNULL (fldBe10 , 0) AS fldBe10, 
                      ISNULL (fldBe20, 0) AS fldBe20,  ISNULL (fldBe30 , 0) AS fldBe30, CAST(0 AS bit) AS fldChecked
					  ,(select fldNoeEstekhdamId FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
                           , ISNULL (fldShift , 0) AS fldShift,cast(0 as bit)fldMoavaghe,N'' as fldAzTarikhMoavagheS,N'' as fldTaTarikhMoavagheS,fldMeetingCount
                           ,fldEstelagi
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  fldId, fldPersonalId, fldYear, fldMah, fldKarkard, fldGheybat, fldNobateKari, fldEzafeKari, fldTatileKari, fldMamoriatBaBeitote, fldMamoriatBedoneBeitote, fldMosaedeh, fldNobatePardakht, fldFlag, fldGhati, 
									fldBa10, fldBa20, fldBa30, fldBe10, fldBe20, fldBe30, fldUserId, fldDate, fldDesc, fldShift, fldMoavaghe, fldAzTarikhMoavaghe, fldTaTarikhMoavaghe,fldMeetingCount,fldEstelagi
									FROM								 Pay.tblKarKardeMahane AS k
										WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMah = @mah) AND (fldNobatePardakht = @NobatePardakht))k
                      where  Pay.Pay_tblPersonalInfo.fldCostCenterId=@Value and Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 
                      AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
					ORDER BY fldFamily,fldName ASC
					
	if (@fieldname=N'fldChartOrganId')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldCostCenterId, Prs.Prs_tblPersonalInfo.fldOrganPostId, 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL (k.fldId, 0)AS fldKarKardeMahaneId, ISNULL ( fldYear, 0) AS fldyear, 
                      ISNULL( fldMah, 0) AS fldMah, 
                      ISNULL(fldKarkard,  Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah))AS fldKarkard, ISNULL (fldGheybat , 0)  AS fldGheybat
					  , ISNULL(fldNobateKari , Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah)) 
                      AS fldNobateKari, ISNULL (fldEzafeKari , 0) AS fldEzafeKari, ISNULL (fldTatileKari, 0)  AS fldTatileKari, ISNULL(fldMamoriatBaBeitote , 0) AS fldMamoriatBaBeitote
					  , ISNULL(fldMamoriatBedoneBeitote , 0)  AS fldMamoriatBedoneBeitote, ISNULL (fldMosaedeh , 0)  AS fldMosaedeh, ISNULL(fldNobatePardakht, 1)  AS fldNobatePardakht
					  , ISNULL (fldGhati, '') AS fldGhati, ISNULL(CASE WHEN fldGhati=1 THEN k.fldEzafeKari ELSE CAST(0 AS INT) end 
					  , CAST(0 AS int)) AS fldGhatiEzafeKar, ISNULL (fldBa10 , 0) AS fldBa10, ISNULL(fldBa20, 0) AS fldBa20,  ISNULL (fldBa30 , 0) AS fldBa30,  ISNULL (fldBe10 , 0) AS fldBe10, 
                      ISNULL (fldBe20, 0) AS fldBe20,  ISNULL (fldBe30 , 0) AS fldBe30, CAST(0 AS bit) AS fldChecked
					  ,(select fldNoeEstekhdamId FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
                           , ISNULL (fldShift , 0) AS fldShift,cast(0 as bit)fldMoavaghe,N'' as fldAzTarikhMoavagheS,N'' as fldTaTarikhMoavagheS,fldMeetingCount
                           ,fldEstelagi
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPostsEjra ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPostsEjra.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId					 
					  outer apply (select  fldId, fldPersonalId, fldYear, fldMah, fldKarkard, fldGheybat, fldNobateKari, fldEzafeKari, fldTatileKari, fldMamoriatBaBeitote, fldMamoriatBedoneBeitote, fldMosaedeh, fldNobatePardakht, fldFlag, fldGhati, 
									fldBa10, fldBa20, fldBa30, fldBe10, fldBe20, fldBe30, fldUserId, fldDate, fldDesc, fldShift, fldMoavaghe, fldAzTarikhMoavaghe, fldTaTarikhMoavaghe,fldMeetingCount,fldEstelagi
									FROM								 Pay.tblKarKardeMahane AS k
										WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMah = @mah) AND (fldNobatePardakht = @NobatePardakht))k

                      where  tblOrganizationalPostsEjra.fldChartOrganId=@Value and Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 
                       AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
					ORDER BY fldFamily,fldName ASC				
					
          if (@fieldname=N'ALL')
   SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldCostCenterId, Prs.Prs_tblPersonalInfo.fldOrganPostId, 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL (k.fldId, 0)AS fldKarKardeMahaneId, ISNULL ( fldYear, 0) AS fldyear, 
                      ISNULL( fldMah, 0) AS fldMah, 
                      ISNULL(fldKarkard,  Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah))AS fldKarkard, ISNULL (fldGheybat , 0)  AS fldGheybat
					  , ISNULL(fldNobateKari , Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah)) 
                      AS fldNobateKari, ISNULL (fldEzafeKari , 0) AS fldEzafeKari, ISNULL (fldTatileKari, 0)  AS fldTatileKari, ISNULL(fldMamoriatBaBeitote , 0) AS fldMamoriatBaBeitote
					  , ISNULL(fldMamoriatBedoneBeitote , 0)  AS fldMamoriatBedoneBeitote, ISNULL (fldMosaedeh , 0)  AS fldMosaedeh, ISNULL(fldNobatePardakht, 1)  AS fldNobatePardakht
					  , ISNULL (fldGhati, '') AS fldGhati, ISNULL(CASE WHEN fldGhati=1 THEN k.fldEzafeKari ELSE CAST(0 AS INT) end 
					  , CAST(0 AS int)) AS fldGhatiEzafeKar, ISNULL (fldBa10 , 0) AS fldBa10, ISNULL(fldBa20, 0) AS fldBa20,  ISNULL (fldBa30 , 0) AS fldBa30,  ISNULL (fldBe10 , 0) AS fldBe10, 
                      ISNULL (fldBe20, 0) AS fldBe20,  ISNULL (fldBe30 , 0) AS fldBe30, CAST(0 AS bit) AS fldChecked
					  ,(select fldNoeEstekhdamId FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
                           , ISNULL (fldShift , 0) AS fldShift,cast(0 as bit)fldMoavaghe,N'' as fldAzTarikhMoavagheS,N'' as fldTaTarikhMoavagheS,fldMeetingCount
                           ,fldEstelagi
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  fldId, fldPersonalId, fldYear, fldMah, fldKarkard, fldGheybat, fldNobateKari, fldEzafeKari, fldTatileKari, fldMamoriatBaBeitote, fldMamoriatBedoneBeitote, fldMosaedeh, fldNobatePardakht, fldFlag, fldGhati, 
									fldBa10, fldBa20, fldBa30, fldBe10, fldBe20, fldBe30, fldUserId, fldDate, fldDesc, fldShift, fldMoavaghe, fldAzTarikhMoavaghe, fldTaTarikhMoavaghe,fldMeetingCount,fldEstelagi
									FROM								 Pay.tblKarKardeMahane AS k
										WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMah = @mah) AND (fldNobatePardakht = @NobatePardakht))k

   
                      
       if (@fieldname=N'')
      SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldCostCenterId, Prs.Prs_tblPersonalInfo.fldOrganPostId, 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL (k.fldId, 0)AS fldKarKardeMahaneId, ISNULL ( fldYear, 0) AS fldyear, 
                      ISNULL( fldMah, 0) AS fldMah, 
                      ISNULL(fldKarkard,  Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah))AS fldKarkard, ISNULL (fldGheybat , 0)  AS fldGheybat
					  , ISNULL(fldNobateKari , Com.fn_GetKarkardWithNoeEstekhdam(Pay.Pay_tblPersonalInfo.fldId,@sal,@mah)) 
                      AS fldNobateKari, ISNULL (fldEzafeKari , 0) AS fldEzafeKari, ISNULL (fldTatileKari, 0)  AS fldTatileKari, ISNULL(fldMamoriatBaBeitote , 0) AS fldMamoriatBaBeitote
					  , ISNULL(fldMamoriatBedoneBeitote , 0)  AS fldMamoriatBedoneBeitote, ISNULL (fldMosaedeh , 0)  AS fldMosaedeh, ISNULL(fldNobatePardakht, 1)  AS fldNobatePardakht
					  , ISNULL (fldGhati, '') AS fldGhati, ISNULL(CASE WHEN fldGhati=1 THEN k.fldEzafeKari ELSE CAST(0 AS INT) end 
					  , CAST(0 AS int)) AS fldGhatiEzafeKar, ISNULL (fldBa10 , 0) AS fldBa10, ISNULL(fldBa20, 0) AS fldBa20,  ISNULL (fldBa30 , 0) AS fldBa30,  ISNULL (fldBe10 , 0) AS fldBe10, 
                      ISNULL (fldBe20, 0) AS fldBe20,  ISNULL (fldBe30 , 0) AS fldBe30, CAST(0 AS bit) AS fldChecked
					  ,(select fldNoeEstekhdamId FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
                           , ISNULL (fldShift , 0) AS fldShift,cast(0 as bit)fldMoavaghe,N'' as fldAzTarikhMoavagheS,N'' as fldTaTarikhMoavagheS,fldMeetingCount
                        ,fldEstelagi
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  fldId, fldPersonalId, fldYear, fldMah, fldKarkard, fldGheybat, fldNobateKari, fldEzafeKari, fldTatileKari, fldMamoriatBaBeitote, fldMamoriatBedoneBeitote, fldMosaedeh, fldNobatePardakht, fldFlag, fldGhati, 
									fldBa10, fldBa20, fldBa30, fldBe10, fldBe20, fldBe30, fldUserId, fldDate, fldDesc, fldShift, fldMoavaghe, fldAzTarikhMoavaghe, fldTaTarikhMoavaghe,fldMeetingCount,fldEstelagi
									FROM								 Pay.tblKarKardeMahane AS k
										WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMah = @mah) AND (fldNobatePardakht = @NobatePardakht))k

                      WHERE   Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 
                      ORDER BY fldFamily,fldName ASC               
                      
 	COMMIT
GO
