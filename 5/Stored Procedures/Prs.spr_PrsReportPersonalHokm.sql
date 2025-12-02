SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [Prs].[spr_PrsReportPersonalHokm]
	@fldid [int]

AS
BEGIN	
SELECT        Prs.tblPersonalHokm.fldId, Prs.tblPersonalHokm.fldPrs_PersonalInfoId, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor, 
                         CASE WHEN fldStatusHokm = 0 THEN N'غیر فعال ' ELSE N'فعال ' END AS fldStatusHokmName, Prs.tblPersonalHokm.fldTarikhEtmam, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, 
                         Prs.tblPersonalHokm.fldShomarePostSazmani, Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, 
                         Prs.tblPersonalHokm.fldShomareHokm, Prs.tblPersonalHokm.fldStatusHokm, Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholName,
                          Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamName, tblEmployee.fldName + '_' + tblEmployee.fldFamily + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldNameEmployee, 
                         tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldEmployeeId, Prs.tblVaziyatEsargari.fldTitle AS fldStatusEsargari, ISNULL(Com.tblEmployee_Detail.fldCodePosti, '') AS fldCodePosti, 
                         ISNULL(Com.tblEmployee_Detail.fldAddress, '') AS fldAddress
						 ,isnull( t.fldMadrakTahsiliTitle,tblMadrakTahsili.fldTitle) as fldMadrakTahsiliTitle,isnull( t.fldReshteTahsiliTitle,tblReshteTahsili.fldTitle) as fldReshteTahsiliTitle, 
                         Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, tblOrganizationalPosts.fldTitle AS fldOrganizationalPosts, Prs.Prs_tblPersonalInfo.fldTabaghe, 
                         Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam,  tblChartOrgan.fldTitle AS fldMahleKhedmat,
                          Com.tblAshkhaseHoghoghi_Detail.fldCodePosti AS CodePostiKhedamt, tblState.fldName AS NameState, tblcity.fldName AS NameCity, Com.tblAshkhaseHoghoghi_Detail.fldAddress AS fldAddressMahaleKhedmat, 
                         tblOrganizationalPosts.fldTitle + '_' + Prs.tblPersonalHokm.fldShomarePostSazmani AS fldTitle_NumberOrganPost, Prs.Prs_tblPersonalInfo.fldSh_Personali
FROM            Prs.tblPersonalHokm INNER JOIN
                         Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                         Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Prs.tblPersonalHokm.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                         Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                         Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                         Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId = tblOrganization.fldId INNER JOIN
                         Com.tblCity AS tblcity ON tblOrganization.fldCityId = tblcity.fldId INNER JOIN
                         Com.tblState AS tblState ON tblcity.fldStateId = tblState.fldId INNER JOIN
                         Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId  INNER JOIN
						 Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
						 Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi ON tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                         Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId AND 
                         Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId AND Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
						  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,m.fldTitle as fldMadrakTahsiliTitle,r.fldTitle as fldReshteTahsiliTitle 
									from com.tblHistoryTahsilat as t INNER JOIN
									 Com.tblMadrakTahsili as m ON t.fldMadrakId = m.fldId INNER JOIN
									 Com.tblReshteTahsili as r ON t.fldReshteId = r.fldId
						  where t.fldEmployeeId=tblEmployee.fldid and t.fldTarikh<=tblPersonalHokm.fldTarikhEjra order by T.fldTarikh DESC)t
                      WHERE tblPersonalHokm.fldId=@fldid



    UNION ALL 
SELECT      tblPersonalHokm.fldId, tblPersonalHokm.fldPrs_PersonalInfoId, tblPersonalHokm.fldTarikhEjra, tblPersonalHokm.fldTarikhSodoor, 
                      CASE WHEN fldStatusHokm = 0 THEN N'غیر فعال ' ELSE N'فعال ' END AS fldStatusHokmName, tblPersonalHokm.fldTarikhEtmam, tblPersonalHokm.fldGroup, 
                      tblPersonalHokm.fldMoreGroup, tblPersonalHokm.fldShomarePostSazmani, tblPersonalHokm.fldTedadFarzand, 
                      tblPersonalHokm.fldTedadAfradTahteTakafol, tblPersonalHokm.fldTypehokm, tblPersonalHokm.fldShomareHokm, tblPersonalHokm.fldStatusHokm, 
                      tblPersonalHokm.fldDescriptionHokm, tblPersonalHokm.fldCodeShoghl, 
                     '' AS fldStatusTaaholName, '' AS fldNoeEstekhdamName, 
                      '' AS fldNameEmployee, '', 
                      0,  fldStatusEsargari,
                      fldCodePosti,fldAddress, fldMadrakTahsili, fldReshteTahsili
                      ,fldRasteShoghli,fldReshteShoghli, fldOrganizationalPosts,fldTabaghe,fldShomareMojavezEstekhdam,fldTarikhMojavezEstekhdam
                      , fldMahleKhedmat,'','','','','',''
FROM         prs.tblHokm_InfoPersonal_History INNER JOIN
                     prs.tblPersonalHokm ON tblHokm_InfoPersonal_History.fldPersonalHokmId = tblPersonalHokm.fldId
                      WHERE fldPersonalHokmId=@fldid
end
GO
