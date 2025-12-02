SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_rptFishHoghoghi_DetailsShow]

@PersonalId INT=632,
@NobatPardakht TINYINT=1,
@Year SMALLINT=1401,
@Month TINYINT=8,
@organID INT=1
,@userId int=1,
@CalcType TINYINT=1
as 
BEGIN TRAN


SELECT     tblMohasebat_1.fldId as fldMohasebatId,Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, tblMohasebat_1.fldMashmolBime,fldMashmolBimeMoavagh, tblMohasebat_1.fldBimeKarFarma + tblMohasebat_1.fldBimeBikari as fldBimeKarFarma
					  , fldBimeKarFarmaMoavagh
							  , (SELECT SUM(Pay.tblMandehPasAndaz.FldMablagh)  FROM Pay.tblMandehPasAndaz WHERE fldPersonalId=Pay.Pay_tblPersonalInfo.fldId)  + ISNULL
                          ((SELECT    ISNULL( SUM(fldPasAndaz),0) AS Expr1
                              FROM         Pay.tblMohasebat
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)),0)+
                          ISNULL(fldPasAndazPersonelMoavagh, 0) AS fldMandePasAndaz, tblMohasebat_1.fldMashmolMaliyat  AS fldMashmolMaliyat, tblMohasebat_1.fldKarkard, tblMohasebat_1.fldTedadEzafeKar AS fldEzafeKar, 
                      tblMohasebat_1.fldGheybat, tblMohasebat_1.fldBaBeytute + tblMohasebat_1.fldBedunBeytute AS fldMamoriyat, (tblMohasebat_1.fldTedadTatilKar/7.33) AS fldTatilKar, 
                      tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth, Com.fn_MandeVam(tblMohasebat_1.fldYear, tblMohasebat_1.fldMonth, 
                      tblMohasebat_1.fldPersonalId) AS fldMandeVam,fldshift,tblMohasebat_1.fldTedadNobatKari
					  ,tblFile.fldImage,i.fldMablaghItems,fldBimeOmrKarFarma,fldBimeTakmilyKarFarma,fldHaghDarmanKarfFarma+fldHaghDarmanDolat as fldHaghDarmanKarfFarma
					  ,tblMohasebat_1.fldPasAndaz/2 as fldPasAndazKarfarma,m.fldMablaghMotalebat,o.fldHaghDarmanKarfFarmaMoavagh,o.fldPasAndazKarfFarmaMoavagh
					  ,mi.fldMablaghItemsMoavagh ,o.fldTitleMoavagh,fldBimePersonal
					  ,CASE WHEN (Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = 1) THEN N'حق بیمه' ELSE N'حق بازنشستگی' END AS fldTitleBime
					  ,fldMaliyat,fldHaghDarman,tblMohasebat_1.fldBimeOmr,tblMohasebat_1.fldBimeTakmily,tblMohasebat_1.fldMosaede,tblMohasebat_1.fldGhestVam
					  ,tblMohasebat_1.fldPasAndaz as fldPasAndazPersonel,fldPasAndazPersonelMoavagh,tblMohasebat_1.fldMogharari ,k.fldMablaghkosorat,b.fldMablaghKosoratBank
					  ,mn.fldMaliyatManfi,fldMaliyatMoavagh,fldBimePersonalMoavagh,o.fldHaghDarmanPersonelMoavagh,fldMashmolMaliyatMoavagh,CountMoavaghe
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId left JOIN
                      /*Com.tblOrganization AS tblOrgan ON tblChartOrgan.fldOrganId = tblOrgan.fldId INNER JOIN*/
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
					outer apply(select sum(i.fldMablagh) as fldMaliyatManfi from pay.tblMaliyatManfi as i where i.fldMohasebeId=tblMohasebat_1.fldId )mn
					outer apply(select sum(i.fldMablagh) as fldMablaghItems from pay.tblMohasebat_Items as i where i.fldMohasebatId=tblMohasebat_1.fldId )i
					outer apply(select sum(m.fldMablagh) as fldMablaghMotalebat from [Pay].[tblMohasebat_kosorat/MotalebatParam] as m where m.fldMohasebatId=tblMohasebat_1.fldId and m.fldMotalebatId is not null )m
					outer apply(select sum(m.fldMablagh) as fldMablaghkosorat from [Pay].[tblMohasebat_kosorat/MotalebatParam] as m where m.fldMohasebatId=tblMohasebat_1.fldId and m.fldKosoratId is not null )k	
					outer apply(select sum(m.fldMablagh) as fldMablaghKosoratBank from [Pay].tblMohasebat_KosoratBank as m where m.fldMohasebatId=tblMohasebat_1.fldId)b
					outer apply(select sum(m.fldHaghDarmanKarfFarma+m.fldHaghDarmanDolat) as fldHaghDarmanKarfFarmaMoavagh, SUM(m.fldPasAndaz/2) as fldPasAndazKarfFarmaMoavagh
								, SUM(m.fldPasAndaz) as fldPasAndazPersonelMoavagh,sum(m.fldMaliyat) as fldMaliyatMoavagh, SUM(m.fldBimePersonal) as fldBimePersonalMoavagh
								,SUM(fldHaghDarman) as fldHaghDarmanPersonelMoavagh, SUM(fldMashmolBime) as fldMashmolBimeMoavagh,SUM(fldBimeKarFarma + fldBimeBikari) as fldBimeKarFarmaMoavagh
								, SUM(fldMashmolMaliyat) As fldMashmolMaliyatMoavagh
								, N'معوقه ' +CAST(COUNT(*) AS NVARCHAR(5))+  N' ماهه ' AS fldTitleMoavagh  
								,Count(*) as CountMoavaghe from [Pay].tblMoavaghat as m where m.fldMohasebatId=tblMohasebat_1.fldId )o
					outer apply(select sum(i.fldMablagh )as fldMablaghItemsMoavagh  from [Pay].tblMoavaghat as m
								inner join pay.tblMoavaghat_Items as i on i.fldMoavaghatId=m.fldId
								where m.fldMohasebatId=tblMohasebat_1.fldId )mi					
					/*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
					 WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht AND tblMohasebat_1.fldPersonalId=@PersonalId
                     and fldCalcType=@CalcType
					-- AND tblOrgan.fldId IN (SELECT Id FROM .Com.fn_GetOrganTree(@UserId))
					 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID

GO
