SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_DisketBazneshastegi](@sal SMALLINT,@mah TINYINT,@Nobat TINYINT,@organId int)
as
--declare @sal SMALLINT=1403,@mah TINYINT=11,@Nobat TINYINT=1,@organId int =1
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=2 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT  [fldSh_Personali],fldCodemeli,fldName,fldFamily,fldFatherName,fldSh_Shenasname,fldTarikhTavalod,fldMahalTavalodId
,CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS  fldJensiyat,fldKarkard,	0 as fldExExpert,isnull( FORMAT(fldTarikhMazad30Sal,'####/##/##'),'0') as fldTarikhMazad30Sal 
,fldStatusTaaholId,fldNesbatBaz,fldEsarBazneshastegi,isnull(s_gheyrerasmi,N'')s_gheyrerasmi,isnull([Com].[fn_SanavatRasmi](fldTarikhEstekhdam , fldTarikhEjra ),'0') as s_rasmi,
(select fldTaaholBazneshastegi from com.tblStatusTaahol where fldId=fldStatusTaaholId)  as fldTaaholBazneshastegi
,fldTedadFarzand,fldMadrakId,fldMadrakTahsili, TitleReshte,ISNULL(fldNezamVazifeId,1)AS fldNezamVazifeId,fldNezamVazifeTitle,fldRasteShoghli,fldReshteShoghli,OrganPost,fldGroup,fldMoreGroup,fldEsargariId
,fldTabaghe,fldTarikhEstekhdam,fldTypeEstekhdamBaz,fldMobile,fldMazad30Sal,fldTarikhEjra,fldYear,fldMonth,fldMashmolBime,fldBimePersonal,fldBimeKarFarma
,case when  fldMashmolBimeMoavaghe>0 then fldMashmolBimeMoavaghe else 0  end as fldMashmolBimeMoavaghe
,case when  fldBimePersonalMoavaghe>0 then fldBimePersonalMoavaghe else 0  end as fldBimePersonalMoavaghe
,case when  fldBimeKarfarmaMoavaghe>0 then fldBimeKarfarmaMoavaghe else 0  end as fldBimeKarfarmaMoavaghe
,fldMogharari,substring(fldTypeHokm,1,80)as fldTypeHokm,fldPersonalId,CityName,CityNameSodoor,StateNameSodoor,fldJobDesc
, ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL(tadil,0)tadil,[band_y]=ISNULL([band_y],0)+ISNULL([joz1],0)+ISNULL([band6],0),
ISNULL([riali],'')[riali],[jazb9]=ISNULL([jazb9],0),ISNULL([jazb],0)+ISNULL([jazb-tabsare],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0),
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer],ISNULL([ezafekar],'')[ezafekar] ,ISNULL([mamoriat],'')[mamoriat],ISNULL([tatilkari],'')[tatilkari] ,ISNULL([s_payankhedmat],'')[s_payankhedmat]
,ISNULL([ghazai],'') ghazai,ISNULL([ashoora],'')ashoora,ISNULL(zaribtadil,'')zaribtadil,ISNULL([jazbTakhasosi],'') jazbTakhasosi,ISNULL([jazbtadil],'')jazbtadil
,isnull(ISNULL([hadaghaltadil],0)+isnull([khas],0)+isnull([KhasTarmim],0),'')[hadaghaltadil],isnull([tatbigh1],'')as [tatbigh1]
,isnull([tarmim],0) as tarmim,N'شاغل' as fldHalateEstekhdam
,jame = fldBimePersonal + fldBimeKarFarma +case when  fldBimePersonalMoavaghe>0 then fldBimePersonalMoavaghe else 0  end+case when  fldBimeKarfarmaMoavaghe>0 then fldBimeKarfarmaMoavaghe else 0  end  +fldMogharari
FROM(SELECT     Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName, 
                      fldSh_Shenasname,fldTarikhTavalod, fldMahalTavalodId, fldJensiyat,fldKarkard,	0 as fldExExpert,fldTarikhMazad30Sal,				  
                          (SELECT     fldStatusTaaholId 
                            FROM          Prs.tblPersonalHokm
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)) AS fldStatusTaaholId,
                          (SELECT     fldTedadFarzand
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_3
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)) AS fldTedadFarzand
							, isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,
                          /*(SELECT     fldTitle
                            FROM          Com.tblReshteTahsili
                            WHERE      (fldId = Com.tblEmployee_Detail.fldReshteId))*/ 
							isnull(h.fldMadrakTahsili,(select k.fldTitle from com.tblMadrakTahsili as k where k.fldid=Com.tblEmployee_Detail.fldMadrakId)) as fldMadrakTahsili,
							isnull(h.fldReshteTahsili,(SELECT     fldTitle
                            FROM          Com.tblReshteTahsili
                            WHERE      (fldId = Com.tblEmployee_Detail.fldReshteId))) as  TitleReshte
							, Com.tblEmployee_Detail.fldNezamVazifeId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, 
							isnull(n.fldTitleBazneshastegi,N'') as fldNezamVazifeTitle,
                      Prs.Prs_tblPersonalInfo.fldReshteShoghli,
                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS OrganPost,
                          (SELECT     fldGroup
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_2
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)) AS fldGroup,
                            ISNULL( (SELECT    fldMoreGroup
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_2
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)),0) AS fldMoreGroup, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldTabaghe, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam,fldTypeEstekhdamBaz,
					  case when Pay.Pay_tblPersonalInfo.fldMazad30Sal=0 then 0 else 0 end as fldMazad30Sal,
                          (SELECT     fldTarikhEjra
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_1
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)) AS fldTarikhEjra, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth
                           ,fldNameEN,fldMablagh
						   ,tblMohasebat.fldMashmolBime/*+ISNULL(Moavaghe.fldMashmolBime,0)*/ as fldMashmolBime
						   , tblMohasebat.fldBimePersonal  /*+ISNULL(Moavaghe.fldBimePersonal,0)*/ as fldBimePersonal
						   ,tblMohasebat.fldBimeKarFarma /*+ISNULL(Moavaghe.fldBimeKarFarma,0)*/ as fldBimeKarFarma,
                           ISNULL((SELECT SUM(o.fldMashmolBime) FROM Pay.tblMoavaghat as o WHERE o.fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) fldMashmolBimeMoavaghe
                       ,  ISNULL((SELECT SUM(o.fldBimePersonal) FROM Pay.tblMoavaghat as o  WHERE o.fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) fldBimePersonalMoavaghe
						, ISNULL((SELECT SUM(o.fldBimeKarFarma) FROM Pay.tblMoavaghat as o  WHERE o.fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) fldBimeKarfarmaMoavaghe
						,fldMogharari,fldMobile
						,(SELECT fldTypehokm FROM Prs.tblPersonalHokm WHERE fldid=Pay.tblMohasebat_PersonalInfo.fldHokmId) fldTypeHokm,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId
						,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalTavalodId) AS CityName
						,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId) AS CityNameSodoor,
						(SELECT s.fldName FROM Com.tblCity as c inner join com.tblState as s  on c.fldStateId=s.fldId WHERE c.fldid=fldMahalSodoorId) AS StateNameSodoor,
						(SELECT fldJobDesc FROM Pay.tblTabJobOfBime WHERE tblTabJobOfBime.fldJobCode=pay.Pay_tblPersonalInfo.fldJobeCode) AS fldJobDesc
						,isnull(fldNesbatBaz,N'') as fldNesbatBaz,isnull(fldEsarBazneshastegi,'') as fldEsarBazneshastegi
						,[Com].[fn_SanavatGheyreRasmi](Prs.Prs_tblPersonalInfo.fldId) as s_gheyrerasmi

FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId INNER JOIN 
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId  INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId left join
					  com.tblNezamVazife as n on n.fldId=tblEmployee_Detail.fldNezamVazifeId inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
     outer apply(SELECT (o.fldMashmolBime),o.fldBimePersonal,o.fldBimeKarFarma FROM Pay.tblMoavaghat as o 
				 inner join   pay.tblMohasebat as m on m.fldId=o.fldMohasebatId WHERE m.fldPersonalId=tblMohasebat.fldPersonalId and
				 o.fldYear=@sal AND o.fldMonth =@mah ) Moavaghe     
				 outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
					 WHERE fldYear=@sal AND fldMonth =@mah AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=2
                      AND  pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
                      )t
 PIVOT (MAX(fldMablagh) 
 FOR fldNameEN IN ([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]
))p

GO
