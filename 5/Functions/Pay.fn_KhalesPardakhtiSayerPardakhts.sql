SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [Pay].[fn_KhalesPardakhtiSayerPardakhts]( @PresonalId int,@Year smallint,@Month tinyint,@NobatPardakht tinyint,@typeHesab tinyint)
returns table
return
		SELECT   sum(fldAmount)  as fldKhalesPardakhti
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId  INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId Inner join
					  com.tblShomareHesabOmoomi_Detail as d on d.fldShomareHesabId=tblShomareHesabeOmoomi.fldId
       WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatPardakht 
					  AND   Pay.tblSayerPardakhts.fldPersonalId=@PresonalId and fldFlag=1 
					  and ((@typeHesab=1 and d.fldHesabTypeId=@typeHesab) or(@typeHesab>1 and d.fldHesabTypeId>1))
GO
