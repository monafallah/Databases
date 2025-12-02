SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_SelectDisketMaliyatForHoghogh](@sal SMALLINT,@mah TINYINT ,@Nobat TINYINT,@organId INT)
as
declare @sal1 SMALLINT=1401,@mah1 TINYINT=1,@Nobat1 TINYINT=1,@organId1 INT=1
--,@sal SMALLINT=1403,@mah TINYINT=1 ,@Nobat TINYINT=1,@organId INT=1
set @sal1=@sal
set @mah1=@mah
set @Nobat1=@Nobat
set @organId1=@organId
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end
declare @FiscalHeaderId int,@flag tinyint=0
select @FiscalHeaderId=fldId  from pay.tblFiscal_Header as h
where substring( fldEffectiveDate,1,4)=@sal1

select @flag=fldValue from com.tblGeneralSetting where fldId=6

SELECT  ISNULL([MaliyatMoavaghe],0)MaliyatMoavaghe,case when MashmolMaliyatMoavaghe> 0 then MashmolMaliyatMoavaghe else 0 end  MashmolMaliyatMoavaghe
,case when MashmolMaliyatMoavagheGHeirMostamar> 0 then MashmolMaliyatMoavagheGHeirMostamar else 0 end  AS MashmolMaliyatMoavagheGHeirMostamar
,ISNULL([MaliyatManfi],0)MaliyatManfi
,ISNULL([KolMotalebat],0)KolMotalebat ,case when ISNULL([ItemEstekhdam],0)+ isnull(MotalebatNaghdiMostamar,0)<0 then 0 else ISNULL([ItemEstekhdam],0)+isnull(MotalebatNaghdiMostamar,0) end as ItemEstekhdam
,case when [fldMashmolMaliyat]<0 then 0 else ISNULL([fldMashmolMaliyat],0) end fldMashmolMaliyat,
ISNULL([fldMaliyat],0)fldMaliyat,ISNULL([fldMaliyatDaraei],0)[fldMaliyatDaraei],ISNULL([fldFiscalHeaderId],0)fldFiscalHeaderId
,ISNULL([ezafekar],0)+case when fldHasMaliyatEzafe=1 then  ISNULL([ezafekariSayer],0) else 0 end as [ezafekar]
,ISNULL([eydi],0) as [eydi],ISNULL([mamoriat],0)+ISNULL([mamooriyatSayer],0)
+case when @flag=0 then 0 else ISNULL([ItemEstekhdamGheirMashmol],0) end  as [mamoriat]
,ISNULL([tatilkari],0)+case when fldHasMaliyatTatilkari=1 then  ISNULL([tatilkariSayer],0) else 0 end as [tatilkari]
,ISNULL([s_payankhedmat],0)[s_payankhedmat],
[fldName],[fldFamily],[fldCodemeli],[fldFatherName],fldMaliyatEsargari,[fldEsargariId],[fldAddress],[fldTarikhEstekhdam],isnull([fldCodePosti],'') as fldCodePosti,[fldShomareBime]
,[fldTypeBimeId],[fldMeliyat],[MahalKhedmat],[Semat],[fldNoeEstekhdam],[fldPersonalId],[fldMadrakId],ISNULL(fldBimePersonal,0)as fldBimePersonal
,/*case when r.fldId is null then ISNULL([refahi],0) else 0 end
+case when o.fldId is null then ISNULL([olad],0) else 0 end
+case when a.fldId is null then ISNULL([ayelemandi],0) else 0 end
+case when m.fldId is null then ISNULL([maskan],0) else 0 end*/0 as SayerMoafiyat,isnull(p.karane,0)karane,fldBimeOmrPersonal
 ,  cast(0 as bigint) fldkhalesPardakhti
 ,isnull(m,0)+isnull(mo,0)as fldBonMostamar
 ,isnull(mg,0)+isnull(mog,0) as fldBonGheyrMostamar
  ,case when moavagh.fldMablagh<0 then 0 else isnull(moavagh.fldMablagh,0) end as fldBonMostamarMoavagh
  ,case when moavaghg.fldMablagh<0 then 0 else isnull(moavaghg.fldMablagh,0) end as fldBonGheyrMostamarMoavagh
 ,isnull(ezafe.fldMablagh,0)as fldMablagh_Ezafekar,isnull(ezafe.fldKhalesPardakhti,0)as fldKhalesPardakhti_Ezafekar
  ,isnull(tatil.fldMablagh,0)as fldMablagh_Tatilkar,isnull(tatil.fldKhalesPardakhti,0)as fldKhalesPardakhti_Tatilkar
  ,isnull(k.fldMablagh,0)as fldMablagh_komakMostamar,isnull(k.fldKhalesPardakhti,0)as fldKhalesPardakhti_komakMostamar
  ,isnull(kg.fldMablagh,0)as fldMablagh_komakGheirMostamar,isnull(kg.fldKhalesPardakhti,0)as fldKhalesPardakhti_komakGheirMostamar
  ,isnull(s.fldAmount,0)as fldMablagh_Sayer,isnull(s.fldKhalesPardakhti,0)as fldKhalesPardakhti_Sayer
  ,isnull(ma.fldMablagh,0)as fldMablagh_Mamoriat,isnull(ma.fldKhalesPardakhti,0)as fldKhalesPardakhti_Mamoriat
  ,isnull(fldMazayaRefahi_Angizeshi,0) as fldMazayaRefahi_Angizeshi
 FROM (SELECT  tblMohasebat.fldId,
 fldAnvaEstekhdamId as AnvaEstekhdamId
  ,/*ISNULL
                          ((SELECT     SUM(fldMaliyat) AS Expr1
                              FROM         Pay.tblMoavaghat
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId)
                              GROUP BY fldMohasebatId), 0)*/0 AS MaliyatMoavaghe, ISNULL
                          ((SELECT     SUM(mi.fldMablagh) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1
							  inner join pay.tblMoavaghat_Items as mi on mi.fldMoavaghatId=tblMoavaghat_1.fldId
							  inner join Com.tblItems_Estekhdam as ie ON mi.fldItemEstekhdamId = ie.fldId
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId and mi.fldHesabTypeItemId<>1)--AND (fldItemsHoghughiId NOT IN (33, 34, 35, 36))
							-- and mi.fldMaliyatMashmool=1
							and mi.fldMostamar=1 --and  mi.fldMablagh>0
							--and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55))
                              GROUP BY fldMohasebatId), 0) AS MashmolMaliyatMoavaghe
							 , ISNULL ((SELECT     SUM(mi.fldMablagh) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1
							  inner join pay.tblMoavaghat_Items as mi on mi.fldMoavaghatId=tblMoavaghat_1.fldId
							  inner join Com.tblItems_Estekhdam as ie ON mi.fldItemEstekhdamId = ie.fldId
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId and mi.fldHesabTypeItemId<>1)--AND (fldItemsHoghughiId NOT IN (33, 34, 35, 36))
							-- and mi.fldMaliyatMashmool=1
							and mi.fldMostamar=2  --and  mi.fldMablagh>0
							--and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55))
                              GROUP BY fldMohasebatId), 0) AS MashmolMaliyatMoavagheGHeirMostamar
							  , /*ISNULL
                          ((SELECT     Pay.tblMohasebat.fldMaliyat
                              FROM         Pay.tblP_MaliyatManfi
                              WHERE     (fldMohasebeId = Pay.tblMohasebat.fldId)), 0)*/0  AS MaliyatManfi,
                         isnull( (SELECT    SUM(pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh)
                            FROM          pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   pay.tblMotalebateParametri_Personal ON 
                                                   pay.[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = pay.tblMotalebateParametri_Personal.fldId
												   inner join pay.tblParametrs as h on h.fldId=tblMotalebateParametri_Personal.fldParametrId
                            WHERE      (pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = pay.tblMohasebat.fldId 
							/*AND fldMashmoleMaliyat=1*/ and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId<>1 
							and [tblMohasebat_kosorat/MotalebatParam].fldIsMostamar=2 ) and fldParametrId not in (347,348,363,362)
                           /* GROUP BY pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat*/) ,0)
						   +
						   ISNULL ((SELECT     SUM(pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId  and tblMohasebat_Items.fldHesabTypeItemId<>1) 
							 /* AND ((tblMohasebat_Items.fldMaliyatMashmool=1 and @flag=1) or @flag=0)*/ and tblMohasebat_Items.fldMostamar=2 and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55,63))), 0) 
						   AS KolMotalebat
							   ,(SELECT    SUM(pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh)
                            FROM          pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                                                   pay.tblMotalebateParametri_Personal ON 
                                                   pay.[tblMohasebat_kosorat/MotalebatParam].fldMotalebatId = pay.tblMotalebateParametri_Personal.fldId
                            WHERE      (pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = pay.tblMohasebat.fldId 
							/*AND fldMashmoleMaliyat=1*/ and [tblMohasebat_kosorat/MotalebatParam].fldHesabTypeParamId<>1
							and [tblMohasebat_kosorat/MotalebatParam].fldIsMostamar=1)  and fldParametrId not in (347,348,363,362)) AS MotalebatNaghdiMostamar
							, ISNULL ((SELECT     SUM(pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId  and tblMohasebat_Items.fldHesabTypeItemId<>1) 
							 /* AND ((tblMohasebat_Items.fldMaliyatMashmool=1 and @flag=1) or @flag=0)*/ and tblMohasebat_Items.fldMostamar=1 and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55,63))), 0) 
	+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP   and o.fldHesabTypeItemId<>1
								AND ((o.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and o.fldMostamar=1 and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55,63))),0) 						  
							  AS ItemEstekhdam ,
                     ISNULL ((SELECT     SUM(pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId  /*and tblMohasebat_Items.fldHesabTypeItemId<>1*/) 
							  AND (tblMohasebat_Items.fldMaliyatMashmool=0 ) /*and tblMohasebat_Items.fldMostamar=1*/ and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55,63))), 0) 
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP
								AND (o.fldMaliyatMashmool=0 ) /*and tblMohasebat_Items.fldMostamar=1*/ and (fldItemsHoghughiId NOT IN (33, 34, 35, 36,55,63))),0) 							  
							  AS ItemEstekhdamGheirMashmol, 
					 Pay.tblMohasebat.fldMashmolMaliyat
					  ,(case when fldMaliyatType=1 or ( fldMaliyatType=2 and fldMaliyatCalc is null ) then ISNULL(Pay.tblMohasebat.fldMaliyat,0) else ISNULL(Pay.tblMohasebat.fldMaliyatCalc,0) end    
					  +ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId)
					  ,ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)))fldMaliyat,
					  case when fldMaliyatType=2  and fldMaliyatCalc is null  then 0 when fldMaliyatType=2  then  ISNULL(Pay.tblMohasebat.fldMaliyat,0) else ISNULL(Pay.tblMohasebat.fldMaliyatCalc,0)   end as fldMaliyatDaraei
					  ,Com.tblItemsHoghughi.fldNameEN, Pay.tblMohasebat_PersonalInfo.fldFiscalHeaderId, 
                      tblMohasebat_Items_1.fldMablagh+isnull(fldMablaghMotamam,0) as fldMablagh,Com.tblEmployee.fldName,Com.tblEmployee.fldFamily,Com.tblEmployee.fldCodemeli,fldFatherName,
                      isnull(h.fldMadrakId,tblEmployee_Detail.fldMadrakId) as fldMadrakId,fldAddress,fldMaliyatEsargari,fldEsargariId,fldTarikhEstekhdam,fldCodePosti,Pay_tblPersonalInfo.fldShomareBime,Pay_tblPersonalInfo.fldTypeBimeId,
                      fldMeliyat,/*Com.fn_MahaleKhedmat(Prs_tblPersonalInfo.fldId)*/N'' AS MahalKhedmat,(SELECT fldTitle FROM Com.tblOrganizationalPosts WHERE fldid=Prs_tblPersonalInfo.fldOrganPostId) AS Semat
                      ,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdam,Prs_tblPersonalInfo.fldId AS fldPersonalId,
					  tblMohasebat.fldPersonalId as fldPayPersonalId,
					  case when Pay_tblPersonalInfo.fldTypeBimeId=1 then ISNULL(Pay.tblMohasebat.fldBimePersonal,0)+
					  +ISNULL(Pay.tblMohasebat.fldBimeTakmily-tblMohasebat.fldBimeTakmilyKarFarma,0)+
					  /*+ISNULL(Pay.tblMohasebat.fldBimeOmr-tblMohasebat.fldBimeOmrKarFarma,0)*/+
					  ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) 
					  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) else 
					  ISNULL(Pay.tblMohasebat.fldHaghDarman,0)+
					  +ISNULL(Pay.tblMohasebat.fldBimeTakmily-tblMohasebat.fldBimeTakmilyKarFarma,0)+
					  /*+ISNULL(Pay.tblMohasebat.fldBimeOmr-tblMohasebat.fldBimeOmrKarFarma,0)*/+
					  ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarman) 
					  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) end AS fldBimePersonal
					  , ISNULL(Pay.tblMohasebat.fldBimeOmr-tblMohasebat.fldBimeOmrKarFarma,0) as fldBimeOmrPersonal
					 ,sayere.fldHasMaliyat as fldHasMaliyatEzafe,sayert.fldHasMaliyat as fldHasMaliyatTatilkari
					 ,(select sum(isnull(m.fldMablagh,0)) as fldMablagh
									FROM Pay.tblMohasebat_Items as m  INNER JOIN
                      Com.tblItems_Estekhdam ON m.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
									 WHERE  m.fldMohasebatId =tblMohasebat.fldId  
								  and m.fldHesabTypeItemId=1 and m.fldMostamar=1 
								   AND ((m.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and fldItemsHoghughiId<>63)
					++ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP
								and o.fldHesabTypeItemId=1 and o.fldMostamar=1 
								   AND ((o.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and fldItemsHoghughiId<>63),0) 			   
								   m
					,(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									WHERE  fldMohasebatId=tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1  and fldParametrId not in (347,348,363,362)
									/*and p.fldMashmoleMaliyat=1*/ and k.fldIsMostamar=1)mo
					,(select sum(isnull(m.fldMablagh,0)) as fldMablagh
									FROM Pay.tblMohasebat_Items as m
									 INNER JOIN  Com.tblItems_Estekhdam ON m.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								  WHERE fldMohasebatId=tblMohasebat.fldId 
								  and m.fldHesabTypeItemId=1 and m.fldMostamar=2 
								   AND ((m.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and  (fldItemsHoghughiId <>63) )
					+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								and o.fldHesabTypeItemId=1 and o.fldMostamar=2 
								   AND ((o.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and  (fldItemsHoghughiId <>63) ),0) 			   
								   mg
					,(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									inner join pay.tblParametrs as h on h.fldId=p.fldParametrId
									WHERE  fldMohasebatId=tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1  and fldParametrId not in (347,348,363,362) /*and p.fldMashmoleMaliyat=1*/ and k.fldIsMostamar=2)mog
, ISNULL ((SELECT     SUM(pay.tblMohasebat_Items.fldMablagh) AS Expr1
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
                              WHERE     (fldMohasebatId = Pay.tblMohasebat.fldId ) 
							  and (fldItemsHoghughiId =63)), 0)+
							isnull(  (SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									inner join pay.tblParametrs as h on h.fldId=p.fldParametrId
									WHERE  fldMohasebatId=tblMohasebat.fldId 									
									AND fldKosoratId IS NULL and fldParametrId in (347,348,363,362)),0)
+ISNULL((select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP 
								 and (fldItemsHoghughiId =63) ),0) 							 
							 AS fldMazayaRefahi_Angizeshi

FROM         Pay.tblMohasebat left JOIN
                      Pay.tblMohasebat_Items AS tblMohasebat_Items_1 ON Pay.tblMohasebat.fldId = tblMohasebat_Items_1.fldMohasebatId left JOIN
                      Com.tblItems_Estekhdam ON tblMohasebat_Items_1.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId left JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      com.tblEmployee ON prs.Prs_tblPersonalInfo.fldEmployeeId=com.tblEmployee.fldId INNER JOIN
					  prs.tblVaziyatEsargari as e on e.fldId=Prs_tblPersonalInfo.fldEsargariId INNER JOIN
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select h.fldMadrakId,h.fldMadrakTahsili,h.fldReshteTahsili from prs.tblHokm_InfoPersonal_History as h where h.fldPersonalHokmId=tblMohasebat_PersonalInfo.fldHokmId)h
                     outer apply(select e.fldHasMaliyat from pay.tblEzafeKari_TatilKari as e where e.fldYear=@sal1  AND e.fldMonth=@mah1   AND (e.fldNobatePardakht=@Nobat1 or @Nobat1=0) and e.fldPersonalId=tblMohasebat.fldPersonalId and e.fldType=1) sayere
					 outer apply(select e.fldHasMaliyat from pay.tblEzafeKari_TatilKari as e where e.fldYear=@sal1  AND e.fldMonth=@mah1   AND (e.fldNobatePardakht=@Nobat1 or @Nobat1=0) and e.fldPersonalId=tblMohasebat.fldPersonalId and e.fldType=2) sayert
					 outer apply (select sum(o.fldMablagh) as fldMablaghMotamam 
                                from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
                                INNER JOIN Com.tblItems_Estekhdam ON o.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId
								where  tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP AND o.fldItemEstekhdamId=tblMohasebat_Items_1.fldItemEstekhdamId )motamam
					WHERE /*tblMohasebat_Items_1.fldHesabTypeItemId<>1 and*/ fldYear=@sal1 AND fldMonth=@mah1 AND (fldNobatPardakht=@Nobat1 or @Nobat1=0) AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1 and fldCalcType=1
                                 /*and  fldPersonalId=935 */  )t
 PIVOT ( MAX(fldMablagh)   
FOR fldNameEN IN ([ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[refahi],[olad],[ayelemandi],[maskan],[karane],[ezafekariSayer],[tatilkariSayer],[mamooriyatSayer],[eydi])
 )p
  outer apply(SELECT    SUM(tblMoavaghat_Items.fldMablagh)   as  fldMablagh
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=p.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1 
						 AND ((tblMoavaghat_Items.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and tblMoavaghat_Items.fldMostamar=1)moavagh
  outer apply(SELECT    SUM(tblMoavaghat_Items.fldMablagh)   as  fldMablagh
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId						
						 WHERE fldMohasebatId=p.fldId  and tblMoavaghat_Items.fldHesabTypeItemId=1 
						 AND ((tblMoavaghat_Items.fldMaliyatMashmool=1 and @flag=1) or @flag=0) and tblMoavaghat_Items.fldMostamar=2 )moavaghg
 --outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh
	--								FROM Pay.tblMohasebat_Items as m
	--								 WHERE  m.fldMohasebatId =p.fldId  
	--							  and m.fldHesabTypeItemId=1 and m.fldMostamar=1 /*and m.fldMaliyatMashmool=1*/)m
					  --outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
							--		inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
							--		WHERE  fldMohasebatId=p.fldId 									
							--		AND fldKosoratId IS NULL and fldHesabTypeParamId=1 /*and p.fldMashmoleMaliyat=1*/ and k.fldIsMostamar=1)mo
					 --outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh
						--			FROM Pay.tblMohasebat_Items as m
						--		  WHERE fldMohasebatId=p.fldId 
						--		  and m.fldHesabTypeItemId=1 and m.fldMostamar=2 /*and m.fldMaliyatMashmool=1*/)mg
					  --outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
							--		inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
							--		WHERE  fldMohasebatId=p.fldId 									
							--		AND fldKosoratId IS NULL and fldHesabTypeParamId=1 /*and p.fldMashmoleMaliyat=1*/ and k.fldIsMostamar=2)mog
					outer apply(SELECT SUM(isnull(e.fldKhalesPardakhti,0)) as fldKhalesPardakhti ,SUM(isnull(e.fldMablagh,0)) as fldMablagh from 	Pay.tblMohasebatEzafeKari_TatilKari as e
						where e.fldPersonalId=p.fldPayPersonalId and fldYear=@sal1 AND fldMonth=@mah1 and fldType=1)ezafe
					outer apply(SELECT SUM(isnull(e.fldKhalesPardakhti,0)) as fldKhalesPardakhti ,SUM(isnull(e.fldMablagh,0))  as fldMablagh from 	Pay.tblMohasebatEzafeKari_TatilKari as e
						where e.fldPersonalId=p.fldPayPersonalId and fldYear=@sal1 AND fldMonth=@mah1 and fldType=2)tatil
					outer apply(SELECT SUM(isnull(e.fldKhalesPardakhti,0)) as fldKhalesPardakhti ,SUM(isnull(e.fldMablagh,0)) as fldMablagh from 	Pay.tblKomakGheyerNaghdi as e
						where e.fldPersonalId=p.fldPayPersonalId and fldYear=@sal1 AND fldMonth=@mah1  AND fldNoeMostamer=1 )k
					outer apply(SELECT SUM(isnull(e.fldKhalesPardakhti,0)) as fldKhalesPardakhti ,SUM(isnull(e.fldMablagh,0)) as fldMablagh from 	Pay.tblKomakGheyerNaghdi as e
						where e.fldPersonalId=p.fldPayPersonalId and fldYear=@sal1 AND fldMonth=@mah1  AND fldNoeMostamer=0 )kg
					outer apply(SELECT SUM(isnull(e.fldKhalesPardakhti,0)) as fldKhalesPardakhti ,SUM(isnull(e.fldAmount,0)) as fldAmount from 	Pay.tblSayerPardakhts as e
						where e.fldPersonalId=p.fldPayPersonalId and fldYear=@sal1 AND fldMonth=@mah1 and fldHasMaliyat=1  )s
					outer apply(SELECT SUM(isnull(e2.fldKhalesPardakhti,0)) as fldKhalesPardakhti ,SUM(isnull(e2.fldMablagh,0)) as fldMablagh   from 	Pay.tblMohasebat_Mamuriyat as e2
						where e2.fldPersonalId=p.fldPayPersonalId and fldYear=@sal1 AND fldMonth=@mah1 and fldMashmolMaliyat>0  )ma
/* outer apply(select f.fldId,fldItemsHoghughiId from   pay.tblFiscalTitle as f 
	 inner join com.tblItems_Estekhdam as i on i.fldId=f.fldItemEstekhdamId
	 where f.fldFiscalHeaderId=@FiscalHeaderId and f.fldAnvaEstekhdamId=AnvaEstekhdamId and fldItemsHoghughiId=22)o
  outer apply(select f.fldId from   pay.tblFiscalTitle as f 
	 inner join com.tblItems_Estekhdam as i on i.fldId=f.fldItemEstekhdamId
	 where f.fldFiscalHeaderId=@FiscalHeaderId and f.fldAnvaEstekhdamId=AnvaEstekhdamId and fldItemsHoghughiId=23)a
  outer apply(select f.fldId from   pay.tblFiscalTitle as f 
	 inner join com.tblItems_Estekhdam as i on i.fldId=f.fldItemEstekhdamId
	 where f.fldFiscalHeaderId=@FiscalHeaderId and f.fldAnvaEstekhdamId=AnvaEstekhdamId and fldItemsHoghughiId=25)m
 outer apply(select f.fldId from   pay.tblFiscalTitle as f 
	 inner join com.tblItems_Estekhdam as i on i.fldId=f.fldItemEstekhdamId
	 where f.fldFiscalHeaderId=@FiscalHeaderId and f.fldAnvaEstekhdamId=AnvaEstekhdamId and fldItemsHoghughiId=56)r*/
	 --order by fldFamily

	

GO
