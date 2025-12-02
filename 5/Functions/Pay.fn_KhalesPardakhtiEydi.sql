SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Pay].[fn_KhalesPardakhtiEydi]( @PresonalId int,@Year smallint,@Month tinyint,@typeHesab tinyint)
returns table
return
		SELECT       cast(ISNULL(fldKhalesPardakhti,0)as bigint) AS fldkhalesPardakhti
		FROM         Pay.tblMohasebat_Eydi as e INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON e.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId    INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
		WHERE fldPersonalId=@PresonalId and  fldYear=@year/* and fldMonth=@Month*/ and fldFlag=1 and exists (select * from pay.tblMohasebat_Items as i inner join pay.tblMohasebat as m on m.fldId=i.fldMohasebatId 
						  inner join com.tblItems_Estekhdam as e2 on e2.fldId=i.fldItemEstekhdamId where m.fldPersonalId=e.fldPersonalId  and m.fldYear=e.fldYear and fldItemsHoghughiId=74 and fldMonth=@Month and i.fldMablagh<>0)
					  and d.fldHesabTypeId=@typeHesab
GO
