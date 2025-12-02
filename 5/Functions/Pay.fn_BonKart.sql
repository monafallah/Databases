SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create function [Pay].[fn_BonKart]( @PersonalId int,@Year smallint,@Month tinyint,@Mostamar tinyint)
returns table
return
		
select  ( CAST( ISNULL((m2.fldMablagh),0) +isnull(mo.fldMablagh,0) AS bigint) )fldKhalesPardakhti
FROM         Pay.tblMohasebat as m
			outer apply(select sum(isnull(m.fldMablagh,0)) as fldMablagh,max(s.fldShomareHesab) as fldShomareHesab  
									FROM Pay.tblMohasebat_Items as m
								  inner join  Com.tblShomareHesabeOmoomi as s ON m.fldShomareHesabItemId =s.fldId
								  inner join com.tblItems_Estekhdam as e on e.fldId=m.fldItemEstekhdamId
								  inner join com.tblItemsHoghughi as i on i.fldId=e.fldItemsHoghughiId
								  WHERE fldMohasebatId=m.fldId 
								  and m.fldHesabTypeItemId=1 and i.fldMostamar=@Mostamar and m.fldMaliyatMashmool=1)m2
			outer apply(SELECT SUM(isnull(k.fldMablagh,0)) as  fldMablagh FROM [pay].[tblMohasebat_kosorat/MotalebatParam] as k 
									inner join pay.tblMotalebateParametri_Personal as p on p.fldId=k.fldMotalebatId 
									WHERE  fldMohasebatId=m.fldId 									
									AND fldKosoratId IS NULL and fldHesabTypeParamId=1 and p.fldMashmoleMaliyat=1 and k.fldIsMostamar=@Mostamar)mo
                     WHERE fldPersonalId=@PersonalId and fldYear=@year AND fldMonth=@Month
					  
					  
GO
