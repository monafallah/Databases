SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_DisketSina](@sal SMALLINT,@mah TINYINT,@Nobat TINYINT,@organId int,@TypeEstekhdam int)
as
--declare @sal SMALLINT,@mah TINYINT,@Nobat TINYINT=1,@organId int =6,@TypeEstekhdam int=1
declare @salP SMALLINT=@sal,@mahP TINYINT=@mah-1

if(@mah=1)
begin
	set @salP=@sal-1
	set @mahP=12
end

declare @type bit=0
if(@TypeEstekhdam<>1)
	set @type=1;
SELECT  fldCodemeli
,fldSathPost,OrganPost
,(select isnull(fldTypeEstekhdamSina,0) from com.tblAnvaEstekhdam where fldid=fldAnvaEstekhdamId) as fldTypeEstekhdamSina
,(select isnull(fldMadrakIdSina,0) from com.tblMadrakTahsili where fldid=fldMadrakId) as fldMadrakId
,fldGroup,fldMoreGroup,cast(isnull(substring([Com].[fn_SanavatRasmi](fldTarikhEstekhdam , fldTarikhEjra ),1,2),0) as int) as s_rasmi
,'159'fldTabaghe
,case when fldTypeBimeId=1 then fldBimePersonal else 0 end fldBimePersonalTamin
,case when fldTypeBimeId=2 then fldHaghDarman else 0 end fldBimePersonalDarman
,case when fldTypeBimeId=2 then fldBimePersonal else 0 end fldSandoghBazneshastegi
,isnull(fldMogharari,0)fldMogharari
,fldBimeKarFarma
, ISNULL([h-paye],0)[h-paye],ISNULL([sanavat],0)[sanavat]
,ISNULL([paye],0)[paye]
,ISNULL([sanavat-basiji],0)[sanavat-basiji]
,(select fldHadaghalDaryafti from prs.tblMoteghayerhaAhkam where fldYear=@sal and fldType=@type) as HadeghalDastmozd
,ISNULL([sakhtikar],0)[sakhtikar],ISNULL([fogh-isar],0)[fogh-isar],ISNULL([sanavat-isar],0)[sanavat-isar],ISNULL([foghshoghl],0)[foghshoghl]
,ISNULL([ayelemandi],0)[ayelemandi],ISNULL([olad],0)[olad],ISNULL([maskan],0)[maskan],ISNULL([bon],0)[bon],ISNULL([modiryati],0)[modiryati]
,ISNULL([jazb],0)+ISNULL([jazb-tabsare],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0)[jazb]
,isnull([khas],0) as khas
,ISNULL([abohava],0)[abohava]
,ISNULL([nobatkari],0)[nobatkari]
,ISNULL([ghazai],0) ghazai
,isnull([tatbigh1],0)as [tatbigh1]
,ISNULL([tatbigh],0)[tatbigh]
,ISNULL([kharobar],0)[masrafi]
,isnull([tarmim],0) as tarmim
,ISNULL([takhasosi],0)[takhasosi]
,ISNULL([ezafekar],0)+ISNULL([tatilkari],0)[ezafekar]
,ISNULL([mamoriat],0)[mamoriat]
,ISNULL([karane],0)[karane]
,ISNULL([made26],0)[made26]
,ISNULL([barjastegi],0)[barjastegi]
,ISNULL([tashilat],0)[tashilat],ISNULL(tadil,0)tadil,[band_y]=ISNULL([band_y],0)+ISNULL([joz1],0)+ISNULL([band6],0)
,[jazb9]=ISNULL([jazb9],0),
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0)
,ISNULL(eydi,0) [eydi]
,ISNULL([s_payankhedmat],0)[s_payankhedmat]
,ISNULL([khoraki],0)[khoraki]
,ISNULL([riali],0)[riali]
,ISNULL([Monasebat],0)[Monasebat]
,ISNULL([javani],0)[javani]
,ISNULL([mahdeKodak],0)[mahdeKodak]
,ISNULL([refahi],0)[refahi]
,fldBimeTakmily,fldBimeOmr
,ISNULL([kalaBehdashti],0)kalaBehdashti
,ISNULL(fldMablaghMoavagheHokm,0)/*+ISNULL(fldMablaghMotamam,0)*/ as fldMablaghMoavagheHokm
,ISNULL(fldMaliyat,0)fldMaliyat
,ISNULL([jazb-tabsare],0)[jazb-tabsare],ISNULL([talash],0)[talash],ISNULL([jebhe],0)[jebhe],ISNULL([janbazi],0)[janbazi],ISNULL([sayer],0)[sayer] 
,ISNULL([ashoora],0)ashoora,ISNULL(zaribtadil,0)zaribtadil,ISNULL([jazbTakhasosi],0) jazbTakhasosi,ISNULL([jazbtadil],0)jazbtadil
,isnull(ISNULL([hadaghaltadil],0)+isnull([khas],0)+isnull([KhasTarmim],0),0)[hadaghaltadil]
,Kosurat
FROM(SELECT     tblEmployee.fldCodemeli,fldMogharari,fldMaliyat,tblMohasebat_PersonalInfo.fldTypeBimeId,tblMohasebat.fldBimeTakmily,tblMohasebat.fldBimeOmr
							, isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,                          
							isnull(h.fldMadrakTahsili,(select k.fldTitle from com.tblMadrakTahsili as k where k.fldid=Com.tblEmployee_Detail.fldMadrakId)) as fldMadrakTahsili,
							isnull(h.fldReshteTahsili,(SELECT     fldTitle
                            FROM          Com.tblReshteTahsili
                            WHERE      (fldId = Com.tblEmployee_Detail.fldReshteId))) as  TitleReshte
							, Com.tblEmployee_Detail.fldNezamVazifeId, Prs.Prs_tblPersonalInfo.fldRasteShoghli,
                      Prs.Prs_tblPersonalInfo.fldReshteShoghli,MoavagheItem.fldMablaghMoavagheHokm,                          (SELECT     fldTitle
                            FROM          Com.tblOrganizationalPosts
                            WHERE      (fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId)) AS OrganPost,
                          (SELECT     fldGroup
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_2
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)) AS fldGroup,
                            ISNULL( (SELECT    fldMoreGroup
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_2
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)),0) AS fldMoreGroup, 
							 Prs.Prs_tblPersonalInfo.fldTabaghe, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam,fldAnvaEstekhdamId
					  ,case when fldTypeEstekhdamId=4 then 164 else 0 end as fldSathPost,
                          (SELECT     fldTarikhEjra
                            FROM          Prs.tblPersonalHokm AS tblPersonalHokm_1
                            WHERE      (fldId = Pay.tblMohasebat_PersonalInfo.fldHokmId)) AS fldTarikhEjra
                           ,fldNameEN,fldMablagh
						   ,tblMohasebat.fldMashmolBime+ISNULL(Moavaghe.fldMashmolBime,0) as fldMashmolBime
						   ,tblMohasebat.fldBimePersonal+ISNULL(Moavaghe.fldBimePersonal,0) as fldBimePersonal
						   ,tblMohasebat.fldBimeKarFarma+ISNULL(Moavaghe.fldBimeKarFarma,0)as fldBimeKarFarma
						   ,tblMohasebat.fldHaghDarman+ISNULL(Moavaghe.fldHaghDarman,0)as fldHaghDarman
						,Prs.Prs_tblPersonalInfo.fldId AS fldPersonalId,
						(SELECT fldJobDesc FROM Pay.tblTabJobOfBime WHERE tblTabJobOfBime.fldJobCode=pay.Pay_tblPersonalInfo.fldJobeCode) AS fldJobDesc
						,isnull(fldEsarBazneshastegi,0) as fldEsarBazneshastegi
						,[Com].[fn_SanavatGheyreRasmi](Prs.Prs_tblPersonalInfo.fldId) as s_gheyrerasmi
						 ,CAST(
						 ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)
+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldBimeBikari+Pay.tblMohasebat.fldPasAndaz
+Pay.tblMohasebat.fldGhestVam				   
						+ISNULL((SELECT sum(fldPasAndaz+fldBimeKarFarma+fldBimeBikari ) 
						FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0)
						AS bigint) as Kosurat ,fldMablaghMotamam
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
					  com.tblNezamVazife as n on n.fldId=tblEmployee_Detail.fldNezamVazifeId
     outer apply(SELECT sum(o.fldMashmolBime)fldMashmolBime,sum(o.fldBimePersonal) as fldBimePersonal,sum(o.fldBimeKarFarma) as fldBimeKarFarma,sum(o.fldHaghDarman) as fldHaghDarman FROM Pay.tblMoavaghat as o 
				 inner join   pay.tblMohasebat as m on m.fldId=o.fldMohasebatId WHERE m.fldPersonalId=tblMohasebat.fldPersonalId and
				 m.fldYear=@sal AND m.fldMonth =@mah ) Moavaghe   
				outer	 apply(SELECT sum(m.fldMablagh) as fldMablaghMoavagheHokm FROM Pay.tblMoavaghat as o 
								inner join   pay.tblMoavaghat_Items as m on m.fldMoavaghatId=o.fldId WHERE o.fldMohasebatId=tblMohasebat.fldId ) MoavagheItem     
				 outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
				outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m 
							inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m.fldId 
							where m.fldPersonalId=tblMohasebat.fldPersonalId and m.fldYear=@salP and m.fldMonth=@mahP )motamam	
	WHERE fldYear=@sal AND fldMonth =@mah AND fldNobatPardakht=@Nobat and fldCalcType=1
                      --AND pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
					  and ((fldTypeEstekhdamId=1 and @TypeEstekhdam=1) or (fldTypeEstekhdamId<>1 and @TypeEstekhdam=2))
                      )t 
 PIVOT (MAX(fldMablagh) 
 FOR fldNameEN IN ([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim],[khoraki],[eydi],[Monasebat],[javani]
,[mahdeKodak],[refahi],[kalaBehdashti],[karane]
))p

GO
