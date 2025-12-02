SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Pay].[fn_KomakGheyerNaghdiPardakht]( @PersonalId int,@Year smallint,@Month tinyint,@typeHesab tinyint)
returns table
return
		
select cast(ISNULL(  Pay.tblKomakGheyerNaghdi.fldMablagh ,0)as bigint)fldMablagh
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId   INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
WHERE fldPersonalId=@PersonalId and Pay.tblKomakGheyerNaghdi.fldYear=@year AND Pay.tblKomakGheyerNaghdi.fldMonth=@Month
					    and d.fldHesabTypeId=@typeHesab
GO
